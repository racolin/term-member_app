import '../../exception/app_message.dart';

enum ResponseType { success, failure }

class ResponseModel<T extends Object> {
  ///
  /// ResponseType { success, failure }
  ///
  final ResponseType type;

  final AppMessage? _message;

  final T? _data;

  ///
  /// Not null when type is success
  ///
  AppMessage get message => _message!;

  ///
  /// Not null when type is failure
  ///
  T get data => _data!;

  const ResponseModel({
    required this.type,
    T? data,
    AppMessage? message,
  })  : _data = data,
        _message = message,
        assert(
          (type == ResponseType.failure && message != null) ||
              (type == ResponseType.success && data != null),
          'If failure, message must be not null. If success, data must be not null',
        );
}
