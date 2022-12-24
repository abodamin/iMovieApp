// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i8;

import '../data/network/dio_provider.dart' as _i5;
import '../data/network/interceptors/auth_interceptor.dart' as _i3;
import '../data/network/interceptors/loggin_interceptor.dart' as _i9;
import '../data/network/rest_api.dart' as _i10;
import '../data/network/urls.dart' as _i11;
import '../views/factory/view_model_factory.dart' as _i12;
import '../views/home/home_page.dart' as _i6;
import '../views/home/home_page_viewmodel.dart' as _i7;
import 'register_module.dart' as _i13; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i4.Dio>(() => registerModule.dio);
  gh.factory<_i5.DioProvider>(() => _i5.DioProvider());
  gh.factory<_i6.HomePage>(() => _i6.HomePage());
  gh.factory<_i7.HomePageViewModel>(() => _i7.HomePageViewModel());
  gh.lazySingleton<_i8.Logger>(() => registerModule.logger);
  gh.singleton<_i9.LoggingInterceptor>(_i9.LoggingInterceptor.create());
  gh.factory<_i10.RestApi>(() => _i10.RestApi(get<_i4.Dio>()));
  gh.singleton<_i11.URLS>(_i11.URLS());
  gh.singleton<_i12.ViewModelFactory>(_i12.ViewModelFactoryImpl());
  return get;
}

class _$RegisterModule extends _i13.RegisterModule {}
