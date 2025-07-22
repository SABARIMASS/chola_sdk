import 'package:cholai_sdk/src/local_storage/storage_service.dart';
import 'package:cholai_sdk/src/utils/logger_util.dart';
import 'package:get/get.dart';
import 'api_provider_data/authorization_api_data.dart';

enum RequestType { kGet, kPost, kPut, kDelete }

class ApiProvider extends GetConnect {
  String token = '';

  @override
  void onInit() {
    super.onInit();
    httpClient.maxAuthRetries = 2;
  }

  Future<String> httpRequest({
    RequestType requestType = RequestType.kPost,
    required Resource resource,
    bool encryptParams = true,
    bool decryptResponse = false,
    Map<String, String>? queryParam,
    Duration? timeout,
    bool disablePrintLog = false,
    bool anonEnable = false,
    FormData? formData,
    OrganizationHeader? userVerifyHeader,
  }) async {
    httpClient.timeout = timeout ?? const Duration(seconds: 60);

    token = StorageX.getAccessToken();

    LoggerUtil.logRequest(
      resource.url,
      headers: defaultApiHeaders(token, userVerifyHeader),
      body: resource.request,
    );
    switch (requestType) {
      case RequestType.kGet:
        final response = await _get(resource, queryParam, userVerifyHeader);
        LoggerUtil.logResponse(
          resource.url,
          statusCode: response.statusCode,
          responseBody: response.bodyString,
        );
        return response.bodyString ?? "";

      case RequestType.kPut:
        final response = await _put(resource, queryParam, userVerifyHeader);
        LoggerUtil.logResponse(
          resource.url,
          statusCode: response.statusCode,
          responseBody: response.bodyString,
        );
        return response.bodyString ?? "";

      case RequestType.kDelete:
        final response = await _delete(resource, queryParam, userVerifyHeader);
        LoggerUtil.logResponse(
          resource.url,
          statusCode: response.statusCode,
          responseBody: response.bodyString,
        );
        return response.bodyString ?? "";

      case RequestType.kPost:
        if (formData != null) {
          final response = await _postFormData(
            resource.url,
            formData,
            userVerifyHeader,
          );
          LoggerUtil.logResponse(
            resource.url,
            statusCode: response.statusCode,
            responseBody: response.bodyString,
          );
          return response.bodyString ?? "";
        } else {
          final response = await _post(resource, queryParam, userVerifyHeader);
          LoggerUtil.logResponse(
            resource.url,
            statusCode: response.statusCode,
            responseBody: response.bodyString,
          );
          return response.bodyString ?? "";
        }
    }
  }
}

extension ApiMethods on ApiProvider {
  Future<Response> _delete(
    Resource resource,
    Map<String, String>? queryParam,
    OrganizationHeader? userVerifyHeader,
  ) {
    return httpClient.delete(
      resource.url,
      query: queryParam,
      headers: defaultApiHeaders(token, userVerifyHeader),
    );
  }

  Future<Response> _put(
    Resource resource,
    Map<String, String>? queryParam,
    OrganizationHeader? userVerifyHeader,
  ) {
    return httpClient.put(
      resource.url,
      body: resource.request,
      query: queryParam,
      headers: defaultApiHeaders(token, userVerifyHeader),
    );
  }

  Future<Response> _post(
    Resource resource,
    Map<String, String>? queryParam,
    OrganizationHeader? userVerifyHeader,
  ) {
    return httpClient.post(
      resource.url,
      body: resource.request,
      query: queryParam,
      headers: defaultApiHeaders(token, userVerifyHeader),
    );
  }

  Future<Response> _postFormData(
    String url,
    FormData formData,
    OrganizationHeader? userVerifyHeader,
  ) {
    return httpClient.post(
      url,
      body: formData,
      // headers: defaultApiHeaders(token, userVerifyHeader, form: true),
    );
  }

  Future<Response> _get(
    Resource resource,
    Map<String, String>? queryParam,
    OrganizationHeader? userVerifyHeader,
  ) {
    return httpClient.get(
      resource.url,
      query: queryParam,
      headers: defaultApiHeaders(token, userVerifyHeader),
    );
  }
}

class Resource<T> {
  final String url;
  final String request;
  final T Function(Response response)? parse;

  Resource({required this.url, required this.request, this.parse});
}

Map<String, String> defaultApiHeaders(
  String token,
  OrganizationHeader? userVerifyHeader, {
  bool form = false,
}) {
  // String bearerToken = userVerifyHeader?.token ?? token;

  return {
    'Content-Type': form ? 'multipart/form-data' : 'application/json',
    // 'Authorization': 'Bearer $bearerToken',
  };
}
