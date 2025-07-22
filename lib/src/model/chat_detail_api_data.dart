import 'package:cholai_sdk/src/utils/date_time_util.dart';

class ChatDetailsRequest {
  final String chatId;

  ChatDetailsRequest({required this.chatId});

  Map<String, dynamic> toJson() {
    final now = DateTime.now();
    final timeZoneOffset = now.timeZoneOffset;
    final offsetHours = timeZoneOffset.inHours;
    final offsetMinutes = timeZoneOffset.inMinutes.remainder(60);
    final formattedOffset =
        '${offsetHours >= 0 ? '+' : '-'}${offsetHours.abs().toString().padLeft(2, '0')}:${offsetMinutes.abs().toString().padLeft(2, '0')}';

    return {'chatId': chatId, "timeZone": formattedOffset};
  }
}

class ChatDetailsResponse {
  bool isLoading = false;
  int? status;
  String? message;
  List<ChatDateGroup>? data;

  ChatDetailsResponse({
    this.status,
    this.message,
    this.data,
    this.isLoading = false,
  });

  factory ChatDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ChatDetailsResponse(
      status: json['status'],
      message: json['message'],
      data:
          (json['data'] as List?)
              ?.map((e) => ChatDateGroup.fromJson(e))
              .toList(),
    );
  }
}

class ChatDateGroup {
  String? dateLabel;
  List<ChatMessage>? messages;

  ChatDateGroup({this.dateLabel, this.messages});

  factory ChatDateGroup.fromJson(Map<String, dynamic> json) {
    return ChatDateGroup(
      dateLabel: json['dateLabel'],
      messages:
          (json['messages'] as List?)
              ?.map((e) => ChatMessage.fromJson(e))
              .toList(),
    );
  }
}

class ChatMessage {
  String? id;
  String? messageId;
  String? chatId;
  String? senderId;
  String? receiverId;
  String? message;
  String? status;
  String? timestamp;
  String? createdAt;
  String? updatedAt;
  int? v;

  ChatMessage({
    this.id,
    this.messageId,
    this.chatId,
    this.senderId,
    this.receiverId,
    this.message,
    this.status,
    this.timestamp,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['_id'],
      messageId: json['messageId'],
      chatId: json['chatId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      status: json['status'],
      timestamp: DateTimeUtil.convertToLocalDateTimeString(json['timestamp']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
  ChatMessage copyWith({
    String? messageId,
    String? senderId,
    String? receiverId,
    String? message,
    String? status,
  }) {
    return ChatMessage(
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
