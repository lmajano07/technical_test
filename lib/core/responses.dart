enum ResponseType {
  success,
  error;

  @override
  String toString() {
    switch (this) {
      case success:
        return 'Success';
      case error:
        return 'Error';
      default:
        return 'Success';
    }
  }
}

abstract class ApiResponse {
  final ResponseType type;
  final int? statusCode;
  final String message;

  ApiResponse({
    required this.type,
    this.statusCode,
    required this.message,
  });
}

class SuccessResponse extends ApiResponse {
  SuccessResponse({
    super.message = '',
    super.statusCode,
  }) : super(type: ResponseType.success);
}

class ErrorResponse extends ApiResponse {
  ErrorResponse({
    required super.message,
    super.statusCode,
  }) : super(type: ResponseType.error);
}
