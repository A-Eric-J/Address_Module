import 'dart:convert';
import 'dart:developer';
import 'package:address_module/const_values/assets.dart';
import 'package:address_module/models/server_response.dart';
import 'package:address_module/services/cookie_service.dart';
import 'package:dio/dio.dart';

/// [WebService] is a service for every REST API request to the server
/// and we use Dio for interacting with network.
class WebService {
  CookieService? cookieService;

  WebService({this.cookieService});

  WebService setDependencies(
    CookieService cookieService,
  ) {
    this.cookieService = cookieService;
    log('Web service updated');
    return this;
  }

  final dio = Dio();

  Future<ServerResponse> getFunction(String url,
      {var body, bool mapToken = false}) async {
    log('requesting data from $url');
    Response? response;
    try {
      var headers = await cookieService!
          .header(withContentType: false, mapToken: mapToken);
      dio.options.sendTimeout = 50000;
      dio.options.connectTimeout = 50000;
      dio.options.receiveTimeout = 50000;

      response = await dio.get(url,
          options: Options(headers: headers, followRedirects: false));
    } on DioError catch (errorMessage) {
      response = errorMessage.response;
      log('request failed in get method');
    }
    return ServerResponse(response, debugMode: debugMode);
  }

  Future<ServerResponse> postFunction(
    String url, {
    bool withContentType = false,
    bool mapToken = false,
    var body,
  }) async {
    Response? response;
    try {
      var headers = await cookieService!
          .header(withContentType: withContentType, mapToken: mapToken);
      dio.options.sendTimeout = 50000;
      dio.options.connectTimeout = 50000;
      dio.options.receiveTimeout = 50000;
      response = await dio.post(
        url,
        options: Options(headers: headers, followRedirects: false),
        data: json.encode(body),
      );
    } on DioError catch (errorMessage) {
      response = errorMessage.response;
      log('request failed in post method');
    }

    return ServerResponse(response, debugMode: debugMode);
  }
}
