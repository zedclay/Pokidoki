class MessagingSocketEvents {
  static const namespace = '/messaging';

  static const conversationJoin = 'conversation.join';
  static const conversationLeave = 'conversation.leave';
  static const messageSend = 'message.send';
  static const messageDelivered = 'message.delivered';
  static const conversationRead = 'conversation.read';
  static const typingStart = 'typing.start';
  static const typingStop = 'typing.stop';

  static const messageCreated = 'message.created';
  static const messageDeliveredEvent = 'message.delivered';
  static const messageRead = 'message.read';
  static const conversationUpdated = 'conversation.updated';
  static const conversationSettingsUpdated = 'conversation.settings.updated';
  static const typingStarted = 'typing.started';
  static const typingStopped = 'typing.stopped';
}
