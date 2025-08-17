abstract class BaseResponse<T> {
  BaseResponse({
    required this.data,
    required this.succeeded,
    required this.statusCode,
    required this.messages,
  });
  final T? data;
  final bool? succeeded;
  final int? statusCode;
  final List<String>? messages;
}

class NetworkResponse<T> extends BaseResponse<T> {
  NetworkResponse({
    required super.data,
    required super.succeeded,
    required super.statusCode,
    required super.messages,
  });

  factory NetworkResponse.success({required T data}) {
    return NetworkResponse(
      data: data,
      succeeded: true,
      statusCode: 200,
      messages: [],
    );
  }

  factory NetworkResponse.failure({required String message}) {
    return NetworkResponse(
      data: null,
      succeeded: false,
      statusCode: 400,
      messages: [message],
    );
  }
}
