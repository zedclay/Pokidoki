import 'package:drift/drift.dart';

import '../tables/local_conversations.dart';
import '../tables/local_messages.dart';
import '../tables/messaging_sync_metadata.dart';
import '../tables/outbound_message_queue.dart';
import '../dao/conversations_dao.dart';
import '../dao/messages_dao.dart';
import '../dao/outbound_queue_dao.dart';
import '../dao/sync_metadata_dao.dart';

part 'messaging_database.g.dart';

@DriftDatabase(
  tables: [
    LocalConversations,
    LocalMessages,
    OutboundMessageQueue,
    MessagingSyncMetadata,
  ],
  daos: [ConversationsDao, MessagesDao, OutboundQueueDao, SyncMetadataDao],
)
class MessagingDatabase extends _$MessagingDatabase {
  MessagingDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement(
        'CREATE UNIQUE INDEX IF NOT EXISTS local_messages_server_message_id '
        'ON local_messages (server_message_id) '
        'WHERE server_message_id IS NOT NULL',
      );
      await customStatement(
        'CREATE UNIQUE INDEX IF NOT EXISTS local_messages_client_message_id '
        'ON local_messages (client_message_id)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS local_messages_conversation_id '
        'ON local_messages (conversation_id)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS local_messages_expires_at '
        'ON local_messages (expires_at)',
      );
      await customStatement(
        'CREATE UNIQUE INDEX IF NOT EXISTS outbound_queue_client_message_id '
        'ON outbound_message_queue (client_message_id)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS local_conversations_last_message_at '
        'ON local_conversations (last_message_at)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS local_conversations_updated_at '
        'ON local_conversations (updated_at)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS local_conversations_other_participant_id '
        'ON local_conversations (other_participant_id)',
      );
    },
    onUpgrade: (m, from, to) async {
      // Version 2+ migrations go here. Never drop data by default.
    },
  );

  Future<void> clearAllData() async {
    await transaction(() async {
      await delete(outboundMessageQueue).go();
      await delete(localMessages).go();
      await delete(localConversations).go();
      await delete(messagingSyncMetadata).go();
    });
  }
}
