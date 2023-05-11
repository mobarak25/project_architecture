import 'package:project_architecture/core/utils/utilities.dart';

abstract class ApiRepo {
  Future<T?> post<T, K>({
    required String endpoint,
    dynamic body,
    required T responseModal,
    String? token,
  });

  Future<T?> get<T, K>({
    required String endpoint,
    dynamic body,
    required T responseModal,
    String? token,
  });

  Future<T?> multipart<T, K>({
    required String endpoint,
    Map<String, String>? body,
    List<ImageFile> files,
    required T responseModal,
    String? token,
  });
}
