import 'package:injectable/injectable.dart';
import 'package:project_architecture/core/network_info/network_info.dart';
import 'package:project_architecture/core/utils/utilities.dart';
import 'package:project_architecture/features/app/data/data_source/remote_gateway_base.dart';
import 'package:project_architecture/features/app/domain/repositories/api_repo.dart';

const String noInternetConnection = 'No Internet Connection';

@LazySingleton(as: ApiRepo)
class ApiRepoImpl extends RemoteGatewayBase implements ApiRepo {
  const ApiRepoImpl(this.networkInfo);
  final NetworkInfo networkInfo;
  @override
  Future<T?> post<T, K>(
      {required String endpoint,
      dynamic body,
      required T responseModal,
      String? token}) async {
    dynamic data;
    if (await networkInfo.isConnected) {
      data = postMethod<T, void>(
        endpoind: endpoint,
        data: body,
        responseModal: responseModal,
        token: token,
      );
    }
    return data;
  }

  @override
  Future<T?> get<T, K>(
      {required String endpoint,
      body,
      required T responseModal,
      String? token}) {
    throw UnimplementedError();
  }

  @override
  Future<T?> multipart<T, K>(
      {required String endpoint,
      Map<String, dynamic>? body,
      List<ImageFile>? files,
      required T responseModal,
      String? token}) {
    throw UnimplementedError();
  }
}
