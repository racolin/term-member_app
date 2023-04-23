enum AppMessageType { error, failure, success, info, none }

class AppMessage {
  final AppMessageType type;
  final String title;
  final String content;

  AppMessage({
    required this.type,
    required this.title,
    required this.content,
  });
}
