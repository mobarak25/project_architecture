import 'package:project_architecture/features/app/domain/entities/default_response.dart';

class EntityMap {
  static T? mapModal<T, K>(dynamic josnData) {
    switch (T) {
      case DefaultResponse:
        return DefaultResponse.fromJson(josnData) as T;

      default:
        throw Exception('Unknown class');
    }
  }
}
