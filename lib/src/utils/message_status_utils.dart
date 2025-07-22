import 'package:cholai_sdk/src/helpers/enums.dart';
import 'package:cholai_sdk/src/utils/logger_util.dart';

class MessageUtills {
  static MessageStatus getMessageStatusFromString(
    String userId,
    String senderId,
    String status,
  ) {
    if (userId == senderId) {
      switch (status.toLowerCase()) {
        case 'read':
          return MessageStatus.read;
        case 'sent':
          return MessageStatus.sent;
        case 'delivered':
          LoggerUtil.debug("STATUS $status");
          return MessageStatus.delivered;
        case 'received':
          return MessageStatus.received;
        case 'request':
          return MessageStatus.request;
        default:
          return MessageStatus.none;
      }
    } else {
      return MessageStatus.none;
    }
  }
}
