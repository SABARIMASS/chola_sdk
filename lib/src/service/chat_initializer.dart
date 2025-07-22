import 'package:cholai_sdk/cholai_sdk.dart';
import 'package:cholai_sdk/src/config/color_config.dart';
import 'package:cholai_sdk/src/model/profile_create_api_data.dart';
import 'package:cholai_sdk/src/service/user_service.dart';
import 'package:cholai_sdk/src/utils/chat_utills.dart';
import 'package:cholai_sdk/src/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CholAiSdk {
  static final CholAiSdk _instance = CholAiSdk._internal();
  factory CholAiSdk() => _instance;
  CholAiSdk._internal();

  static late String _userId;
  static late String cholAiBaseUrl;
  static bool _isPreInitialized = false;

  /// SDK system pre-initialization
  static Future<void> preInit() async {
    if (_isPreInitialized) return;

    await GetStorage.init();

    // Optional: flag that you can check later if needed
    _isPreInitialized = true;
    ColorConfig.initialize();
  }

  // Call this inside build() of app for UI-specific init (optional)
  static void initScreenUtil({
    required Size designSize,
    required BuildContext context,
  }) {
    ScreenUtil.init(
      context,
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
    );
  }

  /// Call this function at the start with userId and fcmToken
  static Future<void> initialize({
    required String userId,
    required String fcmToken,
    required String baseUrl,
  }) async {
    await preInit();
    _userId = userId;
    cholAiBaseUrl = baseUrl;
    await _checkValidUser(userId);
    await _updateFcmToken(userId, fcmToken);
    SocketService().connectSocket(userId);
    LoggerUtil.debug('Chat initialized for $_userId');
  }

  static Future<void> _updateFcmToken(String userId, String fcmToken) async {
    try {
      final response = '';
      // await http.post(
      //   url,
      //   body: {'userId': userId, 'fcmToken': fcmToken},
      // );

      if (response == '200') {
        LoggerUtil.debug('FCM Token updated successfully');
      } else {
        LoggerUtil.debug('Failed to update FCM token');
      }
    } catch (e) {
      LoggerUtil.error('Error updating FCM token: $e');
    }
  }

  /// Get the current chat user id anywhere
  static String get userId => _userId;

  static _checkValidUser(String chatUserId) {
    if (!Get.isRegistered<UserService>()) {
      Get.put(UserService());
    }
    final controller = Get.find<UserService>();
    controller.logInUserInfo(UserInfoData(userId: chatUserId));
  }

  /// Public Widget Factory
  static Widget getChatDetailView({
    Key? key,
    required String senderIdParam,
    required String senderNameParam,
    required String senderProfileImageParam,
    required String receiverNameParam,
    required String receiverProfileImageParam,
    required String receiverIdParam,
    required String receiverPhoneNumberParam,
    required String receiverCountryCodeParam,
  }) {
    // Ensure controller is registered
    if (!Get.isRegistered<ChatDetailsController>()) {
      Get.put(ChatDetailsController());
    }
    final controller = Get.find<ChatDetailsController>();
    final chatId = ChatUtils.getChatRoomId(senderIdParam, receiverIdParam);
    controller.initialize(
      chatIdParam: chatId,
      senderIdParam: senderIdParam,
      senderNameParam: senderNameParam,
      senderProfileImageParam: senderProfileImageParam,
      receiverIdParam: receiverIdParam,
      receiverNameParam: receiverNameParam,
      receiverProfileImageParam: receiverProfileImageParam,
      receiverPhoneNumberParam: receiverPhoneNumberParam,
      receiverCountryCodeParam: receiverCountryCodeParam,
    );
    LoggerUtil.debug('ChatDetailView initialized with userId: $chatId');
    // Return the ChatDetailView widget
    return ChatDetailView(key: key);
  }
}
