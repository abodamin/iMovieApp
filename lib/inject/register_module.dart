
import 'package:dio/dio.dart';
import 'package:i_movie_app/data/network/dio_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';


@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => DioProvider.createInstance();

  @lazySingleton
  Logger get logger => Logger();

}