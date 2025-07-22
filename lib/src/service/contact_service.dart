import 'dart:convert';
import 'package:cholai_sdk/src/constants/api_constants.dart';
import 'package:cholai_sdk/src/constants/app_strings.dart';
import 'package:cholai_sdk/src/model/user_status_api_data.dart';
import 'package:cholai_sdk/src/network/api_provider.dart';
import 'package:cholai_sdk/src/network/api_services/api_service.dart';
import 'package:get/get.dart';

class ContactService {
  static Future<UserStatusResponse> checkUserStatus(
    UserStatusRequest request,
  ) async {
    try {
      final response = await apiProvider.httpRequest(
        resource: Resource(
          url: ApiConstants.checkUserStatusUrl,
          request: jsonEncode(request.toJson()),
        ),
        requestType: RequestType.kPost,
      );

      return UserStatusResponse.fromJson(json.decode(response));
    } catch (e) {
      throw AppStrings.errorMessage.tr;
    }
  }
}
