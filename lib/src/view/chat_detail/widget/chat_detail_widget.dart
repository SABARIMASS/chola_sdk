import 'package:cholai_sdk/src/config/app_style.dart';
import 'package:cholai_sdk/src/config/color_config.dart';
import 'package:cholai_sdk/src/helpers/enums.dart';
import 'package:cholai_sdk/src/helpers/message_status_helpers.dart';
import 'package:cholai_sdk/src/model/chat_detail_api_data.dart';
import 'package:cholai_sdk/src/model/send_message_api_data.dart';
import 'package:cholai_sdk/src/service/chat_service.dart';
import 'package:cholai_sdk/src/utils/logger_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatMessageBubble extends StatefulWidget {
  final String? message;
  final String? timestamp;
  final bool isMe;
  final MessageStatus status;
  final ChatMessage messageData;
  final Function(ChatMessage updatedMessage) updatedMessage;
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.timestamp,
    required this.isMe,
    required this.status,
    required this.messageData,
    required this.updatedMessage,
  });

  @override
  State<ChatMessageBubble> createState() => _ChatMessageBubbleState();
}

class _ChatMessageBubbleState extends State<ChatMessageBubble> {
  late MessageStatus _status;

  @override
  void initState() {
    _status = widget.status;
    _sendNewMessage();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChatMessageBubble oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.status != widget.status) {
      LoggerUtil.debug(
        "Status Updated from ${oldWidget.status} to ${widget.status}",
      );
      // Update the status if it has changed
      setState(() {
        _status = widget.status;
      });
    }
  }

  void _sendNewMessage() {
    LoggerUtil.debug(
      "New Message Received ${widget.messageData.status}-${widget.messageData.message}",
    );
    if (widget.messageData.status != 'request') {
      return;
    } else {
      ChatService.sendMessageApi(
            SendMessageRequestData(
              message: widget.message,
              senderId: widget.messageData.senderId,
              receiverId: widget.messageData.receiverId,
            ),
          )
          .then((response) {
            if (response.status == 1) {
              ChatMessage updatedMessage = ChatMessage(
                chatId: widget.messageData.chatId,
                message: widget.message,
                senderId: widget.messageData.senderId,
                receiverId: widget.messageData.receiverId,
                status: response.data?.status ?? 'sent',
                timestamp: DateTime.now().toIso8601String(),
                messageId: response.data?.messageId,
              );

              widget.updatedMessage(updatedMessage);
            } else if (response.status == -1) {
            } else {
              _sendNewMessage();
            }
          })
          .onError((error, stackTrace) {
            _sendNewMessage();
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final alignment =
        widget.isMe ? Alignment.centerRight : Alignment.centerLeft;
    final color = widget.isMe ? Colors.green[300] : Colors.grey[300];
    final textColor =
        widget.isMe ? ColorConfig.whiteColor : ColorConfig.blackColor;

    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
            bottomLeft: Radius.circular(widget.isMe ? 8.r : 0),
            bottomRight: Radius.circular(widget.isMe ? 0 : 8.r),
          ),
        ),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      MediaQuery.of(context).size.width * 0.8, // upper limit
                ),
                child: Text(
                  widget.message ?? "",
                  style: TextStyle(
                    fontWeight: AppFontWeight.medium.value,
                    color: textColor,
                    fontSize: AppFontSize.small.value,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.timestamp ?? '',
                    style: TextStyle(
                      fontWeight: AppFontWeight.normal.value,
                      color: textColor,
                      fontSize: AppFontSize.extraSmall.value,
                    ),
                  ),
                  !widget.isMe
                      ? SizedBox.shrink()
                      : Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Icon(
                          MessageStatusHelper.getStatusIcon(_status),
                          size: 14.r,
                          color: MessageStatusHelper.getChatDetailStatusColor(
                            _status,
                          ),
                        ),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
