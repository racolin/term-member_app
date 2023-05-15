enum AppMessageType {
  ///
  /// Lỗi được catch khi tương tác với server
  ///
  error,

  ///
  /// Lỗi được catch trong app
  ///
  failure,
  
  ///
  /// Thao tác thành công
  /// 
  success,
  
  ///
  /// Lỗi và cần phải logout
  /// 
  logout,
  
  ///
  /// Thông báo của ứng dụng tới người dùng.
  ///
  /// Không có lỗi xảy ra
  /// 
  notify,

  ///
  /// Lỗi do dữ liệu rỗng
  ///
  none;
}

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
