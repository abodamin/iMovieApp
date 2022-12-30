// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i7;
import 'package:flutter/material.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i14;

import '../app/imports.dart' as _i10;
import '../data/local_models/local_storage_provider.dart' as _i13;
import '../data/network/dio_provider.dart' as _i8;
import '../data/network/interceptors/auth_interceptor.dart' as _i3;
import '../data/network/interceptors/loggin_interceptor.dart' as _i15;
import '../data/network/rest_api.dart' as _i16;
import '../data/network/urls.dart' as _i20;
import '../domain/repository/movies_repository.dart' as _i23;
import '../domain/repository/storage_repository.dart' as _i19;
import '../views/details/details_page.dart' as _i4;
import '../views/details/details_page_data.dart' as _i6;
import '../views/details/details_page_viewmodel.dart' as _i25;
import '../views/factory/view_model_factory.dart' as _i21;
import '../views/favorite/favorite_movies_page.dart' as _i9;
import '../views/favorite/favorite_page_data.dart' as _i11;
import '../views/favorite/favorite_page_viewmodel.dart' as _i22;
import '../views/home/home_page.dart' as _i12;
import '../views/home/home_page_viewmodel.dart' as _i26;
import '../views/search/search_page_data.dart' as _i18;
import '../views/search/search_page_viewmodel.dart' as _i24;
import '../views/search/search_result_page.dart' as _i17;
import 'register_module.dart' as _i27; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i6.DetailsPageData>(() => _i6.DetailsPageData());
  gh.lazySingleton<_i7.Dio>(() => registerModule.dio);
  gh.factory<_i8.DioProvider>(() => _i8.DioProvider());
  gh.factory<_i9.FavoriteMoviesPage>(
      () => _i9.FavoriteMoviesPage(key: get<_i10.Key>()));
  gh.factory<_i11.FavoritePageData>(() => _i11.FavoritePageData());
  gh.factory<_i12.HomePage>(() => _i12.HomePage());
  gh.factory<_i13.LocalStorageProvider>(() => _i13.LocalStorageProvider());
  gh.lazySingleton<_i14.Logger>(() => registerModule.logger);
  gh.singleton<_i15.LoggingInterceptor>(_i15.LoggingInterceptor.create());
  gh.factory<_i16.RestApi>(() => _i16.RestApi(get<_i7.Dio>()));
  gh.factory<_i17.SearchPage>(() => _i17.SearchPage(key: get<_i10.Key>()));
  gh.factory<_i18.SearchPageData>(() => _i18.SearchPageData(
        searchKeyword: get<String>(),
        didStartSearching: get<bool>(),
        showResults: get<bool>(),
        genreIDs: get<List<int>>(),
      ));
  gh.singleton<_i19.StorageRepository>(_i19.StorageRepository());
  gh.singleton<_i20.URLS>(_i20.URLS());
  gh.singleton<_i21.ViewModelFactory>(_i21.ViewModelFactoryImpl());
  gh.factory<_i22.FavoritePageViewModel>(
      () => _i22.FavoritePageViewModel(get<_i19.StorageRepository>()));
  gh.singleton<_i23.MoviesRepository>(
      _i23.MoviesRepository(get<_i16.RestApi>()));
  gh.factory<_i24.SearchPageViewModel>(
      () => _i24.SearchPageViewModel(get<_i23.MoviesRepository>()));
  gh.factory<_i25.DetailsPageViewModel>(() => _i25.DetailsPageViewModel(
        get<_i23.MoviesRepository>(),
        get<_i19.StorageRepository>(),
      ));
  gh.factory<_i26.HomePageViewModel>(
      () => _i26.HomePageViewModel(get<_i23.MoviesRepository>()));
  return get;
}

class _$RegisterModule extends _i27.RegisterModule {}
