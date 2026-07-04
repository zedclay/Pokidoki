/// Shared media or file kind for conversation media screens.
enum SharedMediaKind { image, video, file }

/// Immutable shared media item for UI development.
class SharedMediaItem {
  const SharedMediaItem({
    required this.id,
    required this.conversationId,
    required this.kind,
    required this.fileName,
    required this.sizeBytes,
    required this.sharedAt,
  });

  final String id;
  final String conversationId;
  final SharedMediaKind kind;
  final String fileName;
  final int sizeBytes;
  final DateTime sharedAt;
}
