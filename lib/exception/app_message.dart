enum AppMessageType { error, failure, success, info, none }

class AppMessage {
  final AppMessageType messageType;
  final String title;
  final String content;

  AppMessage({
    required this.messageType,
    required this.title,
    required this.content,
  });
}
