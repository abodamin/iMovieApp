// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i7;
import 'package:flutter/material.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i11;

import '../data/network/dio_provider.dart' as _i8;
import '../data/network/interceptors/auth_interceptor.dart' as _i3;
import '../data/network/interceptors/loggin_interceptor.dart' as _i12;
import '../data/network/rest_api.dart' as _i13;
import '../data/network/urls.dart' as _i14;
import '../views/details/details_page.dart' as _i4;
import '../views/details/details_page_viewmodel.dart' as _i6;
import '../views/factory/view_model_factory.dart' as _i15;
import '../views/home/home_page.dart' as _i9;
import '../views/home/home_page_viewmodel.dart' as _i10;
import 'register_module.dart' as _i16; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i6.DetailsPageViewModel>(() => _i6.DetailsPageViewModel());
  gh.lazySingleton<_i7.Dio>(() => registerModule.dio);
  gh.factory<_i8.DioProvider>(() => _i8.DioProvider());
  gh.factory<_i9.HomePage>(() => _i9.HomePage());
  gh.factory<_i10.HomePageViewModel>(() => _i10.HomePageViewModel());
  gh.lazySingleton<_i11.Logger>(() => registerModule.logger);
  gh.singleton<_i12.LoggingInterceptor>(_i12.LoggingInterceptor.create());
  gh.factory<_i13.RestApi>(() => _i13.RestApi(get<_i7.Dio>()));
  gh.singleton<_i14.URLS>(_i14.URLS());
  gh.singleton<_i15.ViewModelFactory>(_i15.ViewModelFactoryImpl());
  return get;
}

class _$RegisterModule extends _i16.RegisterModule {}
