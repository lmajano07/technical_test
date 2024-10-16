enum ResponseType { success, error }

abstract class ApiResponse {
  final ResponseType type;
  final int? statusCode;
  final String? message;

  ApiResponse({
    required this.type,
    this.statusCode,
    this.message,
  });
}

class SuccessResponse extends ApiResponse {
  SuccessResponse({
    super.message,
    super.statusCode,
  }) : super(type: ResponseType.success);
}

class ErrorResponse extends ApiResponse {
  ErrorResponse({
    super.message,
    super.statusCode,
  }) : super(type: ResponseType.error);
}
