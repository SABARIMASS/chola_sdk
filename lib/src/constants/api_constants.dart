import 'package:cholai_sdk/src/config/app_info.dart';

class ApiConstants {
  static String get checkUserStatusUrl => "${AppInfo.kContactApi}user-status";
  static String get userChatDetailUrl => "${AppInfo.kChatApi}chat-details";
  static String get sendMessageUrl => "${AppInfo.kChatApi}send-message";
  static String get markMessagesReadUrl =>
      "${AppInfo.kChatApi}mark-messages_read";
  static String get markMessageStatusUrl =>
      "${AppInfo.kContactApi}mark-message_status";
  static var uploadTempUrl = '${AppInfo.kFileApi}upload-temp';
}
