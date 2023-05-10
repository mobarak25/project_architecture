import 'package:project_architecture/core/error/custom_error.dart';
import 'package:project_architecture/core/navigator/iflutter_navigator.dart';
import 'package:project_architecture/core/snackbar/show_snackbar.dart';

const String unknownError = 'Unknown Error';

class CustomException implements Exception {
  const CustomException({this.message, this.prefix});

  final String? message;
  final String? prefix;

  @override
  String toString() {
    return '$prefix $message';
  }
}

class NotFoundException extends CustomException {
  NotFoundException(this.customError, this.iFlutterNavigator) : super() {
    ShowSnackBar(
        message: customError.message ?? unknownError,
        navigator: iFlutterNavigator,
        error: true);
  }
  final CustomError customError;
  final IFlutterNavigator iFlutterNavigator;
}
