class ChatUtils {
  static String getChatRoomId(String senderId, String receiverId) {
    return senderId.compareTo(receiverId) < 0
        ? "${senderId}_$receiverId"
        : "${receiverId}_$senderId";
  }
}
