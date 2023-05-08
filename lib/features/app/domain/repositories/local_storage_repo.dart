abstract class LocalStorageRepo {
  Future<void> write({required String key, required String value});
  Future<void> writeModal({required String key, required dynamic value});
  String? read({required String key});
  Future<T?> readModal<T>({required String key, required T value});
  Future<void> remove({required String key});
  void removeAll();
}
