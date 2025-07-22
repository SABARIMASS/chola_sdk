import 'dart:convert';
import 'package:cholai_sdk/src/model/profile_create_api_data.dart';
import 'package:cholai_sdk/src/utils/logger_util.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/storage_keys.dart';

class StorageX {
  static final GetStorage storage = GetStorage();

  static void saveUserData(UserInfoData value) {
    try {
      String jsonData = json.encode(value.toJson());
      storage.write(StorageKeys.kUserInfo, jsonData);
    } catch (e) {
      LoggerUtil.error("saveUserDataError", error: e.toString());
    }
  }

  static Future<UserInfoData?> getUserData() async {
    try {
      String? jsonData = storage.read(StorageKeys.kUserInfo);
      if (jsonData != null) {
        Map<String, dynamic> jsonMap = jsonDecode(jsonData);
        return UserInfoData.fromJson(jsonMap);
      }
    } catch (e) {
      LoggerUtil.error("getUserDataError", error: e.toString());
      return null;
    }
    return null;
  }

  static void saveAccessToken(String id) {
    storage.write(StorageKeys.kAccessToken, id);
  }

  static String getAccessToken() {
    return storage.read(StorageKeys.kAccessToken) ?? "";
  }

  static void saveRefreshToken(String token) {
    storage.write(StorageKeys.kRefreshToken, token);
  }

  static String getRefreshToken() {
    return storage.read(StorageKeys.kRefreshToken) ?? "";
  }

  static void saveDeviceToken(String token) {
    storage.write(StorageKeys.deviceToken, token);
  }

  static String getDeviceToken() {
    return storage.read(StorageKeys.deviceToken) ?? "";
  }

  static void clearStorage() {
    storage.erase();
  }
}
