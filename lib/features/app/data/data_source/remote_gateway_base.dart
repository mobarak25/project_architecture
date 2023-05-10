import 'dart:convert';

import 'package:project_architecture/core/injection/injection.dart';
import 'package:project_architecture/core/navigator/iflutter_navigator.dart';
import 'package:project_architecture/features/app/data/data_source/local_keys.dart';
import 'package:project_architecture/features/app/data/data_source/remote_constants.dart';
import 'package:http/http.dart' as http;
import 'package:project_architecture/features/app/domain/repositories/local_storage_repo.dart';

const String noInternetConnection = 'No Internet Connection';

class RemoteGatewayBase {
  const RemoteGatewayBase();
  String get _baseUrl => baseUrl;

  LocalStorageRepo get _localStorageRepo => getIt<LocalStorageRepo>();

  Future<T?> postMethod<T, K>(
      {required String endpoind,
      dynamic data,
      required T responseModal,
      String? token}) async {
    final fullEndpoint = _baseUrl + endpoind;
    dynamic responseJson;
    final headers = _createHeaders(token);

    try {
      final body = jsonEncode(data);
      final response = await http.post(Uri.parse(fullEndpoint),
          headers: headers, body: body);
      responseJson = _handleHTTPResponse(response);
    } on Exception {}

    return null;
  }

  Map<String, String>? _createHeaders(String? token) {
    return <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${token ?? _localStorageRepo.read(key: tokenDB) ?? ''}',
    };
  }

  dynamic _handleHTTPResponse(http.Response response) {
    return _handleResponse(response.statusCode, response.body);
  }

  _handleResponse(int statusCode, String body) {
    final navigator = getIt<IFlutterNavigator>();

    switch (statusCode) {
      case 200:
        return jsonDecode(body);
      case 400:
      case 404:
        break;

      default:
        break;
    }
  }
}
