import 'package:cholai_sdk/cholai_sdk.dart';
import 'package:flutter/material.dart';

class AppInfo {
  static String get kAppBaseUrl => CholAiSdk.cholAiBaseUrl;
  static String get kChatApi => '$kAppBaseUrl/api/chats/';
  static String get kContactApi => '$kAppBaseUrl/api/contacts/';
  static const String kAppName = 'CholAi SDK';
  static const String kAppDescription =
      'CholAi SDK provides a set of tools and services for building AI-powered chat applications.';
  static const String kAppAuthor = 'CholAi Team';
  static const String kAppLicense = 'MIT License';
  static const String kAppRepositoryUrl = '';
  static const String kFileApi = '';
  static const ThemeMode kThemeMode = ThemeMode.light;
}
