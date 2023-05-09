enum AppMessageType { error, failure, success, logout, info, none }

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

  @override
  String toString() {
    return '{name: ${type.name}, title: $title, content: $content, description: $description}';
  }
}
