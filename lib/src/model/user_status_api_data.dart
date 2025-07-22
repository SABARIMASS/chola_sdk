import 'package:cholai_sdk/src/utils/date_time_util.dart';

class UserStatusRequest {
  final String userId;

  UserStatusRequest({required this.userId});

  Map<String, dynamic> toJson() {
    return {'userId': userId};
  }
}

class UserStatusResponse {
  final int status;
  final String message;
  final UserStatusData? data;

  UserStatusResponse({required this.status, required this.message, this.data});

  factory UserStatusResponse.fromJson(Map<String, dynamic> json) {
    return UserStatusResponse(
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? UserStatusData.fromJson(json['data']) : null,
    );
  }
}

class UserStatusData {
  final String userId;
  final bool isOnline;
  final String? lastSeen;
  final String userStatus;

  UserStatusData({
    required this.userId,
    required this.isOnline,
    this.lastSeen,
    required this.userStatus,
  });

  factory UserStatusData.fromJson(Map<String, dynamic> json) {
    return UserStatusData(
      userId: json['userId'] ?? '',
      isOnline: json['isOnline'] ?? false,
      lastSeen:
          json['lastSeen'] != null
              ? DateTimeUtil.convertToLocalDateTimeString(json['lastSeen'])
              : null,

      userStatus: json['userStatus'] ?? '',
    );
  }
}
