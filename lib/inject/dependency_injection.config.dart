// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i6;
import 'package:flutter/material.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i12;

import '../app/imports.dart' as _i9;
import '../data/network/dio_provider.dart' as _i7;
import '../data/network/interceptors/auth_interceptor.dart' as _i3;
import '../data/network/interceptors/loggin_interceptor.dart' as _i13;
import '../data/network/rest_api.dart' as _i14;
import '../data/network/urls.dart' as _i15;
import '../domain/repository/movies_repository.dart' as _i17;
import '../views/details/details_page.dart' as _i4;
import '../views/details/details_page_viewmodel.dart' as _i18;
import '../views/factory/view_model_factory.dart' as _i16;
import '../views/favorite/favorite_movies_page.dart' as _i8;
import '../views/favorite/favorite_page_data.dart' as _i10;
import '../views/favorite/favorite_page_viewmodel.dart' as _i19;
import '../views/home/home_page.dart' as _i11;
import '../views/home/home_page_viewmodel.dart' as _i20;
import 'register_module.dart' as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.AuthInterceptor>(_i3.AuthInterceptor());
  gh.factory<_i4.DetailsPage>(() => _i4.DetailsPage(
        key: get<_i5.Key>(),
        id: get<String>(),
      ));
  gh.lazySingleton<_i6.Dio>(() => registerModule.dio);
  gh.factory<_i7.DioProvider>(() => _i7.DioProvider());
  gh.factory<_i8.FavoriteMoviesPage>(
      () => _i8.FavoriteMoviesPage(key: get<_i9.Key>()));
  gh.factory<_i10.FavoritePageData>(() => _i10.FavoritePageData());
  gh.factory<_i11.HomePage>(() => _i11.HomePage());
  gh.lazySingleton<_i12.Logger>(() => registerModule.logger);
  gh.singleton<_i13.LoggingInterceptor>(_i13.LoggingInterceptor.create());
  gh.factory<_i14.RestApi>(() => _i14.RestApi(get<_i6.Dio>()));
  gh.singleton<_i15.URLS>(_i15.URLS());
  gh.singleton<_i16.ViewModelFactory>(_i16.ViewModelFactoryImpl());
  gh.singleton<_i17.MoviesRepository>(
      _i17.MoviesRepository(get<_i14.RestApi>()));
  gh.factory<_i18.DetailsPageViewModel>(
      () => _i18.DetailsPageViewModel(get<_i17.MoviesRepository>()));
  gh.factory<_i19.FavoritePageViewModel>(
      () => _i19.FavoritePageViewModel(get<_i17.MoviesRepository>()));
  gh.factory<_i20.HomePageViewModel>(
      () => _i20.HomePageViewModel(get<_i17.MoviesRepository>()));
  return get;
}

class _$RegisterModule extends _i21.RegisterModule {}
