class MarkMessagesReadRequest {
  String? userId;
  String? chatId;
  String? status;

  MarkMessagesReadRequest({this.userId, this.chatId, this.status});

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'chatId': chatId, 'status': status};
  }
}

class MarkMessagesReadResponse {
  final int status;
  final String message;

  MarkMessagesReadResponse({required this.status, required this.message});

  factory MarkMessagesReadResponse.fromJson(Map<String, dynamic> json) {
    return MarkMessagesReadResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
