abstract class BaseResponse<T> {
  BaseResponse({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.error,
  });
  final T? data;
  final bool? succeeded;
  final int? statusCode;
  final Object? error;
}
