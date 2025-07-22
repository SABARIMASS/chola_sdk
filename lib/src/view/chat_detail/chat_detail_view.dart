import 'package:cholai_sdk/cholai_sdk.dart';
import 'package:cholai_sdk/src/config/app_style.dart';
import 'package:cholai_sdk/src/config/color_config.dart';
import 'package:cholai_sdk/src/model/chat_detail_api_data.dart';
import 'package:cholai_sdk/src/utils/date_time_util.dart';
import 'package:cholai_sdk/src/utils/message_status_utils.dart';
import 'package:cholai_sdk/src/view/chat_detail/widget/chat_bottom_widget.dart';
import 'package:cholai_sdk/src/view/chat_detail/widget/chat_detail_widget.dart';
import 'package:cholai_sdk/src/widgets/app_bar_title_widget.dart';
import 'package:cholai_sdk/src/widgets/custom_app_bar.dart';
import 'package:cholai_sdk/src/widgets/network_image.dart';
import 'package:cholai_sdk/src/widgets/paginated_list.dart';
import 'package:cholai_sdk/src/widgets/profile_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class ChatDetailView extends GetView<ChatDetailsController> {
  const ChatDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    CholAiSdk.initScreenUtil(
      context: context,
      designSize: const Size(375, 812), // e.g., iPhone 11 size
    );
    return Scaffold(
      appBar: _myAppBarWidget(context),
      body: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://i.pinimg.com/736x/25/81/e8/2581e82afdd1a5e1170b15b511c2f951.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: PaginatedListView(
                  reverse: true,
                  listEmptyWidget: SizedBox.shrink(),
                  isLoading: controller.chatDetailsResponse.value.isLoading,
                  backgroundColor: Colors.transparent,
                  itemCount:
                      controller.chatDetailsResponse.value.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final dateGroup =
                        controller.chatDetailsResponse.value.data![index];
                    final messages = dateGroup.messages ?? [];
                    return Column(
                      key: ValueKey(index),
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _dateLabelWidget(dateGroup),
                        ..._messagesWidget(messages, index),
                      ],
                    );
                  },
                  separator: SizedBox.shrink(),
                ),
              ),
              ChatBottomWidget(
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 500));
                },
                onChanged: controller.onTextChanged,
                controller: controller.chatTextcontroller,
                isStreaming: false,
                resetingChat: false,
                sendOnTap: () {
                  controller.sendMessage();
                },
                onStopStreaming: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Iterable<Widget> _messagesWidget(
    List<ChatMessage> messages,
    int gropupIndex,
  ) {
    return messages.asMap().entries.map((entry) {
      final index = entry.key;
      final msg = entry.value;

      return ChatMessageBubble(
        key: ValueKey(msg.messageId ?? '${msg.timestamp}-$index'),
        message: msg.message,
        timestamp: DateTimeUtil.chatDetailFormatTime(
          DateTime.tryParse(msg.timestamp ?? '') ?? DateTime.now(),
        ),
        isMe: msg.senderId == controller.senderId.value,
        status: MessageUtills.getMessageStatusFromString(
          controller.senderId.value,
          msg.senderId ?? '',
          msg.status ?? '',
        ),
        messageData: messages[index],
        updatedMessage: (updatedMessage) {
          controller.updateMessage(
            updatedMessage: updatedMessage,
            gropupIndex: gropupIndex,
            index: index,
          );
        },
      );
    });
  }

  Widget _dateLabelWidget(ChatDateGroup dateGroup) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: ColorConfig.primaryColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        dateGroup.dateLabel ?? '',
        style: TextStyle(
          fontWeight: AppFontWeight.semibold.value,
          color: ColorConfig.whiteColor,
          fontSize: AppFontSize.extraSmall.value,
        ),
      ),
    );
  }

  MyAppBar _myAppBarWidget(BuildContext context) {
    return MyAppBar(
      title: AppBarTitleWidget(
        padding: EdgeInsets.only(left: 0.w, right: 8.w),
        titleWidget: Expanded(
          child: Row(
            children: [
              CommonCachedNetworkImage(
                onTap: () {
                  ChatDialogFunctions.profileDialogWidget(
                    context,
                    controller.receiverName.value,
                    controller.receiverProfileImage.value,
                    "${controller.receiverCountryCode.value} ${controller.receiverPhoneNumber.value}",
                  );
                },
                height: 30.h,
                width: 35.w,
                imageUrl: controller.receiverProfileImage.value,
                isCircle: true,
                errorWidget: Icon(
                  HugeIcons.strokeRoundedUser,
                  color: ColorConfig.primaryColor,
                ),
              ),

              SizedBox(width: 10.w),
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.receiverName.value,
                      style: TextStyle(
                        color: ColorConfig.primaryColor,
                        fontSize: AppFontSize.medium.value,
                        fontWeight: AppFontWeight.bold.value,
                      ),
                    ),
                    controller.isTyping.value
                        ? Text(
                          "typing...",
                          style: TextStyle(
                            color: ColorConfig.hintTextColor,
                            fontSize: AppFontSize.small.value,
                            fontWeight: AppFontWeight.medium.value,
                          ),
                        )
                        : controller.isOnline.value
                        ? Text(
                          "online",
                          style: TextStyle(
                            color: ColorConfig.hintTextColor,
                            fontSize: AppFontSize.small.value,
                            fontWeight: AppFontWeight.medium.value,
                          ),
                        )
                        : controller.lastSeen.value.isNotEmpty
                        ? Text(
                          "last seen ${DateTimeUtil.getChatListTime(controller.lastSeen.value).toLowerCase()}",
                          style: TextStyle(
                            color: ColorConfig.hintTextColor,
                            fontSize: AppFontSize.extraSmall.value,
                            fontWeight: AppFontWeight.medium.value,
                          ),
                        )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
