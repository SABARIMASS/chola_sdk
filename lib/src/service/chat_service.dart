import 'dart:convert';

import 'package:cholai_sdk/src/constants/api_constants.dart';
import 'package:cholai_sdk/src/constants/app_strings.dart';
import 'package:cholai_sdk/src/model/chat_detail_api_data.dart';
import 'package:cholai_sdk/src/model/mark_message_api_data.dart';
import 'package:cholai_sdk/src/model/mark_messages_read_api_data.dart';
import 'package:cholai_sdk/src/model/send_message_api_data.dart';
import 'package:cholai_sdk/src/network/api_provider.dart';
import 'package:cholai_sdk/src/network/api_services/api_service.dart';
import 'package:get/get.dart';

class ChatService {
  static Future<ChatDetailsResponse> chatDetailRequestApi(
    ChatDetailsRequest request,
  ) async {
    try {
      final response = await apiProvider.httpRequest(
        resource: Resource(
          url: ApiConstants.userChatDetailUrl,
          request: jsonEncode(request.toJson()),
        ),
        requestType: RequestType.kPost,
      );

      return ChatDetailsResponse.fromJson(json.decode(response));
    } catch (e) {
      throw AppStrings.errorMessage.tr;
    }
  }

  static Future<SendMessageResponse> sendMessageApi(
    SendMessageRequestData request,
  ) async {
    try {
      final response = await apiProvider.httpRequest(
        resource: Resource(
          url: ApiConstants.sendMessageUrl,
          request: jsonEncode(request.toJson()),
        ),
        requestType: RequestType.kPost,
      );

      return SendMessageResponse.fromJson(json.decode(response));
    } catch (e) {
      throw AppStrings.errorMessage.tr;
    }
  }

  static Future<MarkMessagesReadResponse> markMessagesReadApi(
    MarkMessagesReadRequest request,
  ) async {
    try {
      final response = await apiProvider.httpRequest(
        resource: Resource(
          url: ApiConstants.markMessagesReadUrl,
          request: jsonEncode(request.toJson()),
        ),
        requestType: RequestType.kPost,
      );

      return MarkMessagesReadResponse.fromJson(json.decode(response));
    } catch (e) {
      throw AppStrings.errorMessage.tr;
    }
  }

  static Future<MarkMessageStatusResponse> markMessageReadApi(
    MarkMessageStatusRequest request,
  ) async {
    try {
      final response = await apiProvider.httpRequest(
        resource: Resource(
          url: ApiConstants.markMessageStatusUrl,
          request: jsonEncode(request.toJson()),
        ),
        requestType: RequestType.kPost,
      );

      return MarkMessageStatusResponse.fromJson(json.decode(response));
    } catch (e) {
      throw AppStrings.errorMessage.tr;
    }
  }
}
