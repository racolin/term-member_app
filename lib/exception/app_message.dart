enum AppMessageType { error, failure, success, info, none }

class AppMessage {
  final AppMessageType type;
  final String title;
  final String content;
  ///
  /// Not null when message is exception
  ///
  final String? description;

  AppMessage({
    required this.type,
    required this.title,
    required this.content,
    this.description,
  });
}
