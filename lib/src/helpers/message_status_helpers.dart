import 'package:cholai_sdk/src/helpers/enums.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class MessageStatusHelper {
  static IconData? getStatusIcon(MessageStatus? status) {
    switch (status) {
      case MessageStatus.sent:
        return HugeIcons.strokeRoundedTick01;
      case MessageStatus.received:
        return HugeIcons.strokeRoundedTickDouble01;
      case MessageStatus.delivered:
        return HugeIcons.strokeRoundedTickDouble01;
      case MessageStatus.read:
        return HugeIcons.strokeRoundedTickDouble01; // styled with blue color
      case MessageStatus.request:
        return HugeIcons.strokeRoundedTimer01; // timer icon for request
      default:
        return null;
    }
  }

  static Color? getStatusColor(MessageStatus? status) {
    switch (status) {
      case MessageStatus.read:
        return Colors.blue;
      case MessageStatus.sent:
      case MessageStatus.received:
      case MessageStatus.delivered:
        return Colors.grey;
      case MessageStatus.request:
        return Colors.grey;
      default:
        return null;
    }
  }

  static Color? getChatDetailStatusColor(MessageStatus? status) {
    switch (status) {
      case MessageStatus.read:
        return Colors.blue;
      case MessageStatus.sent:
        return Colors.white;
      case MessageStatus.received:
        return Colors.white;
      case MessageStatus.delivered:
        return Colors.white;
      case MessageStatus.request:
        return Colors.white;
      default:
        return null;
    }
  }
}
