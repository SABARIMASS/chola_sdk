import 'package:cholai_sdk/src/config/color_config.dart';
import 'package:cholai_sdk/src/view/chat_detail/widget/chat_text_field_widget.dart';
import 'package:cholai_sdk/src/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBottomWidget extends StatefulWidget {
  const ChatBottomWidget({
    super.key,
    required this.controller,
    required this.resetingChat,
    required this.sendOnTap,
    required this.onStopStreaming,
    required this.isStreaming,
    this.onTap,
    this.onChanged,
  });
  final TextEditingController controller;
  final bool resetingChat;
  final void Function() sendOnTap;
  final void Function()? onTap;
  final void Function() onStopStreaming;
  final bool isStreaming;
  final void Function(String)? onChanged;
  @override
  ChatBottomWidgetState createState() => ChatBottomWidgetState();
}

class ChatBottomWidgetState extends State<ChatBottomWidget> {
  bool isSendEnabled = false;
  bool isMultiLine = false;
  bool isSpeechToText = false;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChatBottomWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.resetingChat == true) {
      isSpeechToText = false;
    }
  }

  void _onTextChanged() {
    setState(() {
      isSendEnabled = widget.controller.text.trim().isNotEmpty;

      // Check if text exceeds one line
      final textSpan = TextSpan(
        text: widget.controller.text,
        style: TextStyle(fontSize: 16.sp),
      );
      final textPainter = TextPainter(
        text: textSpan,
        maxLines: null,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(maxWidth: MediaQuery.of(context).size.width * 0.7);

      isMultiLine = textPainter.computeLineMetrics().length > 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorConfig.backgroundColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(12.r),
          topStart: Radius.circular(12.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1), // Fixed opacity
            offset: const Offset(0, -2), // Negative Y offset for top shadow
            blurRadius: 4, // Softness of shadow
            spreadRadius: 2, // Spread of shadow
          ),
        ],
      ),
      child:
      // isSpeechToText
      //     ? VoiceRecorderWidget(
      //       onResult: (text) {
      //         if (text != null) {
      //           LoggerUtil.debug("SPEECH TO TEXT : Converted text: $text");
      //           widget.controller.text = text;
      //           isSpeechToText = false;
      //           setState(() {});
      //           // Use the transcribed text
      //         } else {
      //           LoggerUtil.debug("SPEECH TO TEXT : Recording cancelled.");
      //           isSpeechToText = false;
      //           setState(() {});
      //         }
      //       },
      //     )
      //     :
      Row(
        spacing: 8.w,
        crossAxisAlignment:
            isMultiLine ? CrossAxisAlignment.end : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ChatTextWidget(
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              controller: widget.controller,
              hint: 'Type a message',
            ),
          ),
          // !widget.isStreaming
          //     ? CustomIconButton(
          //       radius: 16.r,
          //       iconSize: 16.r,
          //       icon: Icons.mic_outlined,

          //       shape: BoxShape.circle,
          //       onTap: () {
          //         isSpeechToText = true;
          //         setState(() {});
          //       },
          //     )
          //     : SizedBox.shrink(),
          // widget.isStreaming
          //     ? CustomIconButton(
          //       backgroudColor: Theme.of(context).appTheme.kPrimaryTextColor,
          //       iconSize: 16.r,
          //       radius: 16.r,
          //       iconColor: Theme.of(context).appTheme.kIconSecondaryColor,
          //       icon: Icons.stop,

          //       shape: BoxShape.rectangle,
          //       onTap: widget.onStopStreaming, // Disable when empty
          //     )
          //     :
          Opacity(
            opacity: isSendEnabled ? 1.0 : 0.5,
            child: CustomIconButton(
              iconSize: 16.r,
              radius: 16.r,
              icon: Icons.send_outlined,

              shape: BoxShape.circle,
              onTap:
                  isSendEnabled ? widget.sendOnTap : null, // Disable when empty
            ),
          ),
        ],
      ),
    );
  }
}
