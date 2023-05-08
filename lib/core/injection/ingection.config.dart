// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: always_use_package_imports, prefer_const_constructors, cascade_invocations, comment_references, require_trailing_commas

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as i1;
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart' as i2;
import 'package:project_architecture/features/app/data/repositories/local_storage_repo_impl.dart';
import 'package:project_architecture/features/app/domain/repositories/local_storage_repo.dart';

/// initializes the registration of provided dependencies inside of [GetIt]

i1.GetIt $initGetIt(i1.GetIt sl,
    {String? environment, i2.EnvironmentFilter? environmentFilter}) {
  final gh = i2.GetItHelper(sl, environment, environmentFilter);

  //gh.lazySingleton<IFlutterNavigator>(() => FlutterNavigator());

  gh.lazySingleton(() => GetStorage());
  gh.lazySingleton<LocalStorageRepo>(() => LocalStorageRepoImpl(sl()));

  // gh.lazySingleton(() => ImagePicker());

  // gh.lazySingleton(() => InternetConnectionChecker());
  // gh.lazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // gh.lazySingleton<ApiRepo>(() => ApiRepoImpl(sl()));

  // gh.lazySingleton<GetLocationRepo>(() => GetLocationRepoImpl());

  return sl;
}
