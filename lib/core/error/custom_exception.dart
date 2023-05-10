import 'package:project_architecture/core/error/custom_error.dart';
import 'package:project_architecture/core/navigator/iflutter_navigator.dart';
import 'package:project_architecture/core/snackbar/show_snackbar.dart';
import 'package:project_architecture/features/app/data/data_source/local_keys.dart';
import 'package:project_architecture/features/app/domain/repositories/local_storage_repo.dart';
import 'package:project_architecture/features/app/presentation/login/view/login_screen.dart';

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

class UnauthorizedException extends CustomException {
  UnauthorizedException(
      this.customError, this.iFlutterNavigator, this.localStorageRepo)
      : super() {
    if (localStorageRepo.read(key: tokenDB) != null) {
      ShowSnackBar(
        message: customError.message ?? unknownError,
        navigator: iFlutterNavigator,
        error: true,
      );
      iFlutterNavigator.popUntil((route) => route.isFirst);
      iFlutterNavigator.pushReplacement(LoginScreen.route());
      localStorageRepo.removeAll();
    }
  }
  final CustomError customError;
  final IFlutterNavigator iFlutterNavigator;
  final LocalStorageRepo localStorageRepo;
}

class InvalidInputException extends CustomException {
  InvalidInputException(this.customError, this.iFlutterNavigator) : super() {
    ShowSnackBar(
        message: customError.message ?? unknownError,
        navigator: iFlutterNavigator,
        error: true);
  }
  final CustomError customError;
  final IFlutterNavigator iFlutterNavigator;
}

class FetchDataException extends CustomException {
  FetchDataException(this.customError, this.iFlutterNavigator) : super() {
    ShowSnackBar(
        message: customError.message ?? unknownError,
        navigator: iFlutterNavigator,
        error: true);
  }
  final CustomError customError;
  final IFlutterNavigator iFlutterNavigator;
}

class AppException extends CustomException {
  AppException(this.customError, this.iFlutterNavigator) : super() {
    ShowSnackBar(
        message: customError.message ?? unknownError,
        navigator: iFlutterNavigator,
        error: true);
  }
  final CustomError customError;
  final IFlutterNavigator iFlutterNavigator;
}
