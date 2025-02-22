class ResponseApi<T> {
  final int? status;
  final String message;
  final T? data;

  ResponseApi({
    required this.status,
    required this.message,
    this.data,
  });
}
