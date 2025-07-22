import 'dart:developer';

class LoggerUtil {
  static void debug(String message) {
    log(message, name: 'DEBUG');
  }

  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    log(message, name: 'ERROR', error: error, stackTrace: stackTrace);
  }

  // Logs the network request details
  static void logRequest(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) {
    log('Request: $url', name: 'NETWORK');
    if (headers != null) {
      log('Headers: $headers', name: 'NETWORK');
    }
    if (body != null) {
      log('Request Body: $body', name: 'NETWORK');
    }
  }

  // Logs the network response details
  static void logResponse(String url, {int? statusCode, dynamic responseBody}) {
    log('Response: $url', name: 'NETWORK');
    if (statusCode != null) {
      log('Status Code: $statusCode', name: 'NETWORK');
    }
    if (responseBody != null) {
      log('Response Body: $responseBody', name: 'NETWORK');
    }
  }
}
