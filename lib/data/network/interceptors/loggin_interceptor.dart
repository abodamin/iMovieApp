import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';


@singleton
class LoggingInterceptor extends Interceptor {

  final Logger _logger;
  LoggingInterceptor( this._logger);

  @factoryMethod
  factory LoggingInterceptor.create(){
    final Logger _logger = Logger();
    return LoggingInterceptor(_logger);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d("""

    onRequest -------->>
    options: ${options}
    path: ${options.path} ,
    data: ${options.data} ,
    headers: ${options.headers} ,
    extra: ${options.extra} ,

 """);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("""
    <<-------- onResponse
    statusCode: ${response.statusCode} ,
    realUri: ${response.realUri} ,
    data: ${response.data} ,
    <<-------- END onResponse
     """);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _logger.e("""
    
    <<-------- onError
    error: ${err.error} ,
    type: ${err.type} ,
    message: ${err.message} ,
    response: ${err.response} ,
    stackTrace: ${err.stackTrace} ,

     """);

    super.onError(err, handler);
  }
}
