import 'package:cholai_sdk/src/utils/date_time_util.dart';

class ChatListRequestData {
  final String userId;

  ChatListRequestData({required this.userId});

  Future<Map<String, dynamic>> toJson() async {
    return {'userId': userId};
  }
}

class ChatListResponse {
  bool? isLoading;
  int? status;
  String? message;
  List<Chat>? data;

  // Constructor to create instances directly
  ChatListResponse({this.isLoading, this.status, this.message, this.data});

  // fromJson to create instance from JSON
  ChatListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      for (var v in json['data']) {
        data!.add(Chat.fromJson(v));
      }
    }
  }
}

class Chat {
  String? chatId;
  Message? lastMessage;
  int? unreadCount;
  User? receiver;
  User? sender;

  Chat({
    this.chatId,
    this.lastMessage,
    this.unreadCount,
    this.receiver,
    this.sender,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: json['chatId'],
      lastMessage:
          json['lastMessage'] != null
              ? Message.fromJson(json['lastMessage'])
              : null,
      unreadCount: json['unreadCount'],
      receiver:
          json['opponent'] != null ? User.fromJson(json['opponent']) : null,
      sender: json['sender'] != null ? User.fromJson(json['sender']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'lastMessage': lastMessage?.toJson(),
      'unreadCount': unreadCount,
      'receiver': receiver?.toJson(),
      'sender': sender?.toJson(),
    };
  }
}

class Message {
  String? text;
  String? status;
  String? time;
  String? senderId;
  String? receiverId;

  Message({this.text, this.status, this.time, this.senderId, this.receiverId});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      status: json['status'],
      time: DateTimeUtil.convertToLocalDateTimeString(json['time']),

      senderId: json['senderId'],
      receiverId: json['receiverId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'status': status,
      'time': time,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }
}

class User {
  String? sId;
  String? name;
  String? profileImage;
  String? phoneNumber;
  String? countryCode;

  User({
    this.name,
    this.profileImage,
    this.sId,
    this.phoneNumber,
    this.countryCode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      profileImage: json['profileImage'],
      sId: json['id'],
      phoneNumber: json['phoneNumber'],
      countryCode: json['countryCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'profileImage': profileImage, 'id': sId};
  }
}
