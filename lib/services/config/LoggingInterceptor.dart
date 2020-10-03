import 'package:TimeTracker/utils/widgets/global_dialogs.dart';
import 'package:dio/dio.dart';

class LoggingInterceptors extends Interceptor {
  DateTime start;

  @override
  Future<dynamic> onRequest(RequestOptions options) {
    GlobalDialogs.displayLoading();
    start = DateTime.now();
    print(
        "--> REQUEST ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
    print("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    if (options.queryParameters != null) {
      print("queryParameters:");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
    }
    print("Requested at: ${start.millisecondsSinceEpoch}");
    if (options.data != null) {
      print("Body: ${options.data}");
    }
    print(
        "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
    return super.onRequest(options);
  }

  @override
  Future<dynamic> onError(DioError dioError) {
    GlobalDialogs.popContext();
    GlobalDialogs.displayConnectionError(dioError.response.statusCode);
    DateTime now = DateTime.now();
    print(
        "<-- ERROR ${dioError.message} ${(dioError.request != null ? (dioError.request.baseUrl + dioError.request.path) : 'URL')}");
    print("Headers:");
    if (dioError.response?.request != null) {
      dioError.response.request.headers?.forEach((k, v) {
        print('$k: $v');
      });
    }
    print("Request ended at: ${now.millisecondsSinceEpoch}");
    print(
        "Time taken: ${now.millisecondsSinceEpoch - start.millisecondsSinceEpoch} ms");
    print(
        "${dioError.response != null && dioError.response.data != null ? dioError.response.data : dioError.error != null ? dioError.message : 'Unknown Error'}");
    print("<-- End error");

    print(dioError.toString());

    return super.onError(dioError);
  }

  @override
  Future<dynamic> onResponse(Response response) {
    GlobalDialogs.popContext();
    DateTime now = DateTime.now();
    print(
        "<-- RESPONSE ${response?.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
    print("Response Headers:");
    response.headers?.forEach((k, v) => print('$k: $v'));

    print("Request Headers:");
    response.request.headers?.forEach((k, v) {
      print('$k: $v');
    });
    print("Request ended at: ${now.millisecondsSinceEpoch}");
    print(
        "Time taken: ${now.millisecondsSinceEpoch - start.millisecondsSinceEpoch} ms");
    print("Response: ${response.data}");
    print("<-- END HTTP");

    return super.onResponse(response);
  }
}
