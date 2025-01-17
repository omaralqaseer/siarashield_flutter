class ResponseAPI {
  int code;
  final Map<String, dynamic> response;
  bool? isError;
  dynamic isCacheError;
  dynamic error;

  ResponseAPI(this.code, this.response, {this.isError, this.isCacheError, this.error});
}
