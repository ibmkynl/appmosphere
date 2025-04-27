import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

abstract class AppError {
  final String message;

  const AppError(this.message);
}

class ServerError extends AppError {
  const ServerError(String message) : super(message);
}

class CacheError extends AppError {
  const CacheError(String message) : super(message);
}

class LocationError extends AppError {
  const LocationError(String message) : super(message);
}

class NetworkError extends AppError {
  const NetworkError(String message) : super(message);
}

class UnexpectedError extends AppError {
  const UnexpectedError(String message) : super(message);
}

class ErrorNotification {
  static void show(BuildContext context, AppError error) {
    final snackBar = SnackBar(
      content: Text(error.message.i18n()),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
