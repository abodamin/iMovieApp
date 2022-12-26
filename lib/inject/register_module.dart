
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:i_movie_app/data/local_models/local_storage_manager.dart';
import 'package:i_movie_app/data/local_models/local_storage_provider.dart';
import 'package:i_movie_app/data/network/dio_provider.dart';
import 'package:i_movie_app/domain/repository/movies_repository.dart';
import 'package:i_movie_app/domain/repository/storage_repository.dart';
import 'package:i_movie_app/views/details/details_page_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => DioProvider.createInstance();

  @lazySingleton
  Logger get logger => Logger();

  // @lazySingleton
  // Future<File> get fileAccess => LocalStorageProvider.createInstance();

  // @lazySingleton
  // Future<StorageRepository> get storageRepo => StorageRepository.createInstace();

}