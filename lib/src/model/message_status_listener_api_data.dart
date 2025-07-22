//senderId, receiverId, chatId for these from json in dart data class

class MessageStatusListener {
  final String senderId;
  final String receiverId;
  final String chatId;

  MessageStatusListener({
    required this.senderId,
    required this.receiverId,
    required this.chatId,
  });

  factory MessageStatusListener.fromJson(Map<String, dynamic> json) {
    return MessageStatusListener(
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      chatId: json['chatId'] ?? '',
    );
  }
}
