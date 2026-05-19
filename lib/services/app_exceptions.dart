import 'dart:convert';
import 'package:construction_app/models/error_response_model.dart';

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;
  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad Request', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not responded in time', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'UnAuthorized request', url);
}

class ErrorParser {
  static String getCleanErrorMessage(dynamic error, String defaultMsg) {
    if (error is AppException) {
      final rawMsg = error.message;
      if (rawMsg != null && rawMsg.trim().startsWith('{')) {
        try {
          final Map<String, dynamic> decoded = jsonDecode(rawMsg);
          if (decoded.containsKey('errors')) {
            final errors = decoded['errors'];
            if (errors is Map<String, dynamic> && errors.isNotEmpty) {
              List<String> allErrors = [];
              errors.forEach((key, value) {
                if (value is List) {
                  allErrors.addAll(value.map((e) => e.toString()));
                } else {
                  allErrors.add(value.toString());
                }
              });
              if (allErrors.isNotEmpty) {
                return allErrors.join('\n');
              }
            }
          }
          if (decoded.containsKey('message')) {
            return decoded['message'].toString();
          }
        } catch (_) {}
      }
      return error.message ?? defaultMsg;
    } else if (error is ErrorResponseModel) {
      return error.errorMessage ?? defaultMsg;
    } else if (error is String) {
      return error;
    } else {
      try {
        final dynamic dynError = error;
        if (dynError.message != null && dynError.message is String) {
          return dynError.message;
        }
      } catch (_) {}
    }
    return defaultMsg;
  }
}
