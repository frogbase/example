import 'dart:convert';

class ApiResponse {
  ApiResponse();

  bool success = false;
  int statusCode = 0;
  String message = '';
  int page = 1;
  int limit = 20;
  String? filter;
  dynamic data;

  factory ApiResponse.fromRawJson(String source) =>
      ApiResponse.fromJson(json.decode(source));

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse()
    ..success = json[_Json.success] ?? false
    ..statusCode = json[_Json.statusCode] ?? 0
    ..message = json[_Json.message] ?? 'No Message'
    ..page = json[_Json.page] ?? 1
    ..limit = json[_Json.limit] ?? 20
    ..filter = json[_Json.filter]
    ..data = json[_Json.data];

  @override
  String toString() =>
      'ApiResponse(isSuccess: $success, statusCode: $statusCode, message: $message, page: $page, limit: $limit, filter: $filter, data: $data)';
}

class _Json {
  static const String success = 'success';
  static const String statusCode = 'statusCode';
  static const String message = 'message';
  static const String page = 'page';
  static const String limit = 'limit';
  static const String filter = 'filter';
  static const String data = 'data';
}
