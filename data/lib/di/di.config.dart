// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:data/data_source/local/define.dart' as _i24;
import 'package:data/data_source/local/local_data_source.dart' as _i19;
import 'package:data/data_source/local/preference/app_preferences.dart' as _i17;
import 'package:data/data_source/local/preference/define.dart' as _i20;
import 'package:data/data_source/remote/api/error/http_request_exception_mapper.dart'
    as _i10;
import 'package:data/data_source/remote/api/services/refresh_token_service.dart'
    as _i12;
import 'package:data/data_source/remote/api/services/user_service.dart' as _i16;
import 'package:data/data_source/remote/firebase/firebase_auth_service.dart'
    as _i5;
import 'package:data/data_source/remote/firebase/firebase_chat_database.dart'
    as _i6;
import 'package:data/data_source/remote/firebase/firebase_storage.dart' as _i9;
import 'package:data/data_source/remote/firebase/firestore/user_firestore_service.dart'
    as _i15;
import 'package:data/data_source/remote/firebase/remote_config/firebase_remote_config.dart'
    as _i8;
import 'package:data/data_source/remote/firebase_auth_remote_data_source.dart'
    as _i18;
import 'package:data/data_source/remote/firebase_chat_remote_data_source.dart'
    as _i7;
import 'package:data/data_source/remote/remote_data_source.dart' as _i21;
import 'package:data/data_source/repository_impl.dart' as _i23;
import 'package:data/di/local_module.dart' as _i25;
import 'package:data/model/define.dart' as _i11;
import 'package:data/model/mapper/error_response_detail_mapper.dart' as _i3;
import 'package:data/model/mapper/error_response_mapper.dart' as _i4;
import 'package:data/model/mapper/user_data_mapper.dart' as _i14;
import 'package:domain/domain.dart' as _i22;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.factory<_i3.ErrorResponseDetailMapper>(
        () => _i3.ErrorResponseDetailMapper());
    gh.factory<_i4.ErrorResponseMapper>(
        () => _i4.ErrorResponseMapper(gh<_i3.ErrorResponseDetailMapper>()));
    gh.lazySingleton<_i5.FirebaseAuthService>(() => _i5.FirebaseAuthService());
    gh.lazySingleton<_i6.FirebaseChatDatabase>(
        () => _i6.FirebaseChatDatabase());
    gh.lazySingleton<_i7.FirebaseChatRemoteDataSource>(() =>
        _i7.FirebaseChatRemoteDataSource(
            database: gh<_i6.FirebaseChatDatabase>()));
    gh.lazySingleton<_i8.FirebaseRemoteConfigService>(
        () => _i8.FirebaseRemoteConfigService());
    gh.lazySingleton<_i9.FirebaseStorageService>(
        () => _i9.FirebaseStorageService());
    gh.factory<_i10.HttpRequestExceptionMapper>(
        () => _i10.HttpRequestExceptionMapper(gh<_i11.ErrorResponseMapper>()));
    gh.lazySingleton<_i12.RefreshTokenService>(
        () => _i12.RefreshTokenService());
    await gh.factoryAsync<_i13.SharedPreferences>(
      () => injectableModule.prefs,
      preResolve: true,
    );
    gh.factory<_i14.UserDataMapper>(() => _i14.UserDataMapper());
    gh.lazySingleton<_i15.UserFireStoreService>(
        () => _i15.UserFireStoreService());
    gh.lazySingleton<_i16.UserService>(() => _i16.UserService());
    gh.lazySingleton<_i17.AppPreferences>(
        () => _i17.AppPreferences(gh<_i13.SharedPreferences>()));
    gh.lazySingleton<_i18.FirebaseAuthRemoteDataSource>(() =>
        _i18.FirebaseAuthRemoteDataSource(
            authService: gh<_i5.FirebaseAuthService>()));
    gh.lazySingleton<_i19.LocalDataSource>(
        () => _i19.LocalDataSource(gh<_i20.AppPreferences>()));
    gh.lazySingleton<_i21.RemoteDataSource>(() => _i21.RemoteDataSource(
          gh<_i16.UserService>(),
          gh<_i11.UserDataMapper>(),
        ));
    gh.lazySingleton<_i22.AppRepository>(() => _i23.RepositoryImpl(
          gh<_i24.LocalDataSource>(),
          gh<_i21.RemoteDataSource>(),
        ));
    return this;
  }
}

class _$InjectableModule extends _i25.InjectableModule {}
