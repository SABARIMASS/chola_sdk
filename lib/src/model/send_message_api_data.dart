class SendMessageRequestData {
  String? senderId;
  String? receiverId;
  String? message;

  SendMessageRequestData({this.senderId, this.receiverId, this.message});

  Map<String, dynamic> toJson() {
    return {'senderId': senderId, 'receiverId': receiverId, 'message': message};
  }
}

class SendMessageResponse {
  int? status;
  String? message;
  SendMessageData? data;

  SendMessageResponse({this.status, this.message, this.data});

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) {
    return SendMessageResponse(
      status: json['status'],
      message: json['message'],
      data:
          json['data'] != null ? SendMessageData.fromJson(json['data']) : null,
    );
  }
}

class SendMessageData {
  String? messageId;
  String? chatId;
  String? senderId;
  String? receiverId;
  String? message;
  int? timestamp;
  String? status;

  SendMessageData({
    this.messageId,
    this.chatId,
    this.senderId,
    this.receiverId,
    this.message,
    this.timestamp,
    this.status,
  });

  factory SendMessageData.fromJson(Map<String, dynamic> json) {
    return SendMessageData(
      messageId: json['messageId'],
      chatId: json['chatId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      timestamp: json['timestamp'],
      status: json['status'],
    );
  }
}
