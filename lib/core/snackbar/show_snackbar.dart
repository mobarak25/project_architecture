import 'package:flutter/material.dart';
import 'package:project_architecture/core/navigator/iflutter_navigator.dart';

class ShowSnackBar {
  ShowSnackBar(
      {required this.message,
      required this.navigator,
      bool error = false,
      Color? color})
      : super() {
    _showSnackBar(message, navigator.context, error, color);
  }

  final String message;
  final IFlutterNavigator navigator;
}

void _showSnackBar(
    String message, BuildContext context, bool error, Color? color) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color ?? (error ? Colors.red : Colors.green),
        action: SnackBarAction(
          label: "Ok",
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
}
