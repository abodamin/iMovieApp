import 'package:dio/dio.dart';
import 'package:i_movie_app/app/Globals.dart';
import 'package:i_movie_app/data/network/interceptors/auth_interceptor.dart';
import 'package:i_movie_app/data/network/interceptors/loggin_interceptor.dart';
import 'package:i_movie_app/data/network/urls.dart';
import 'package:injectable/injectable.dart';


@injectable
class DioProvider {
  const DioProvider();

  static const Map<String, String> _header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    // 'token': '$mUserToken',
    // 'client-secret': 'xyz',
    // 'client-id': 'abc',
    // 'package-name': 'com.sasa.abc',
    // 'platform': 'android',
  };

  static Dio createInstance() {
    Dio _dio = Dio();
    print("___init Dio >> ");
    _dio.options = BaseOptions(
      baseUrl: URLS.BASE_URL,
      receiveTimeout: 5000,
      connectTimeout: 5000,
      sendTimeout: 50000,
      headers: _header,
    );

    _dio.interceptors.addAll([
      AuthInterceptor(),
      LoggingInterceptor.create(),
    ]);

    return _dio;
  }
}
