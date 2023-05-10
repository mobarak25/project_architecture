import 'dart:convert';
import 'dart:io';

import 'package:project_architecture/core/error/custom_error.dart';
import 'package:project_architecture/core/error/custom_exception.dart';
import 'package:project_architecture/core/injection/injection.dart';
import 'package:project_architecture/core/navigator/iflutter_navigator.dart';
import 'package:project_architecture/features/app/data/data_source/local_keys.dart';
import 'package:project_architecture/features/app/data/data_source/remote_constants.dart';
import 'package:http/http.dart' as http;
import 'package:project_architecture/features/app/domain/entities/entities_map/entities_map.dart';
import 'package:project_architecture/features/app/domain/repositories/local_storage_repo.dart';

const fetchDataException = 'Failed To Fetch Data';

class RemoteGatewayBase {
  const RemoteGatewayBase();
  String get _baseUrl => baseUrl;

  LocalStorageRepo get _localStorageRepo => getIt<LocalStorageRepo>();

  Future<T?> postMethod<T, K>(
      {required String endpoind, dynamic data, String? token}) async {
    final fullEndpoint = _baseUrl + endpoind;
    dynamic responseJson;
    final headers = _createHeaders(token);

    try {
      final body = jsonEncode(data);
      final response = await http.post(Uri.parse(fullEndpoint),
          headers: headers, body: body);
      responseJson = _handleHTTPResponse(response);
      if (responseJson != null) {
        return fromJson<T, K>(responseJson);
      }
    } on SocketException {
      FetchDataException(
          CustomError(message: fetchDataException), getIt<IFlutterNavigator>());
      //Implement pending response system by push notification. Or we can send a GUID withing the api,
      //and the GUID will store to local, while the connectivity available the api will call again
    }

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
        NotFoundException(error(body), navigator);
        break;
      case 401:
      case 403:
        UnauthorizedException(error(body), navigator, _localStorageRepo);
        break;
      case 422:
        InvalidInputException(error(body), navigator);
        break;
      case 500:
      default:
        FetchDataException(
            CustomError(
                message:
                    'An error occurred while communicating with the server with StatusCode $statusCode'),
            navigator);
        break;
    }
  }

  CustomError error(String body) {
    return CustomError.fromJson(jsonDecode(body));
  }

  static T fromJson<T, K>(dynamic json) {
    if (json is Iterable) {
      return _fromJsonList<K>(json) as T;
    }
    return EntityMap.mapModal<T, K>(json) as T;

    // final classMirror = reflector.reflectType(T) as ClassMirror;
    // final data = classMirror.newInstance("fromJson", [json]);
    // return data as T;
  }

  static List<K>? _fromJsonList<K>(Iterable<dynamic> jsonList) {
    return jsonList.map<K>((dynamic json) => fromJson<K, void>(json)).toList();
  }
}
