import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:project_architecture/features/app/domain/entities/entities_map/entities_map.dart';
import 'package:project_architecture/features/app/domain/repositories/local_storage_repo.dart';

@LazySingleton(as: LocalStorageRepo)
class LocalStorageRepoImpl implements LocalStorageRepo {
  LocalStorageRepoImpl(this.storage);
  final GetStorage storage;

  @override
  Future<void> write({required String key, required String value}) async {
    await storage.write(key, value);
  }

  @override
  Future<void> writeModal({required String key, required dynamic value}) async {
    await storage.write(key, jsonEncode(value));
  }

  @override
  String? read({required String key}) {
    return storage.read(key);
  }

  @override
  Future<T?> readModal<T>({required String key, required T value}) async {
    dynamic data;
    final json = await storage.read(key);
    if (json != null) {
      data = EntityMap.mapModal<T, void>(jsonDecode(json)) as T;
    }
    return data;
  }

  @override
  Future<void> remove({required String key}) async {
    return await storage.remove(key);
  }

  @override
  void removeAll() {
    storage.erase();
  }
}
