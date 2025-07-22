class SocketChatMessageData {
  final String chatId;
  final String messageId;
  final String senderId;
  final String receiverId;
  final String message;
  final int timestamp;
  final String status;

  SocketChatMessageData({
    required this.chatId,
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.status,
  });

  factory SocketChatMessageData.fromJson(Map<String, dynamic> json) {
    return SocketChatMessageData(
      chatId: json['chatId'],
      messageId: json['messageId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      timestamp: json['timestamp'],
      status: json['status'],
    );
  }
}
