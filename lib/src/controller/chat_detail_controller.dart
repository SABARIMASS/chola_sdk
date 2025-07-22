import 'package:cholai_sdk/cholai_sdk.dart';
import 'package:cholai_sdk/src/constants/app_strings.dart';
import 'package:cholai_sdk/src/model/chat_detail_api_data.dart';
import 'package:cholai_sdk/src/model/mark_messages_read_api_data.dart';
import 'package:cholai_sdk/src/model/message_status_listener_api_data.dart';
import 'package:cholai_sdk/src/model/socket_chat_message_data.dart';
import 'package:cholai_sdk/src/model/user_status_api_data.dart';
import 'package:cholai_sdk/src/service/chat_service.dart';
import 'package:cholai_sdk/src/service/contact_service.dart';
import 'package:cholai_sdk/src/utils/date_time_util.dart';
import 'package:cholai_sdk/src/utils/logger_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatDetailsController extends GetxController {
  Rx<ChatDetailsResponse> chatDetailsResponse = ChatDetailsResponse().obs;
  var chatId = ''.obs;
  var senderId = ''.obs;
  var senderName = ''.obs;
  var senderProfileImage = ''.obs;
  var receiverName = ''.obs;
  var receiverProfileImage = ''.obs;
  var receiverId = ''.obs;
  var receiverCountryCode = ''.obs;
  var receiverPhoneNumber = ''.obs;
  final chatTextcontroller = TextEditingController(text: '');
  var isTyping = false.obs;
  var isOnline = false.obs;
  var lastSeen = ''.obs;

  @override
  void onInit() {
    LoggerUtil.debug('ChatDetailsController onInit called');
    super.onInit();
  }

  void initialize({
    required String chatIdParam,
    required String senderIdParam,
    required String senderNameParam,
    required String senderProfileImageParam,
    required String receiverNameParam,
    required String receiverProfileImageParam,
    required String receiverIdParam,
    required String receiverPhoneNumberParam,
    required String receiverCountryCodeParam,
  }) {
    LoggerUtil.debug(
      'ChatDetailsController initialized with chatId: ${chatId.value}',
    );
    callChatDetailsApi(
      chatIdParam: chatIdParam,
      senderIdParam: senderIdParam,
      senderNameParam: senderNameParam,
      senderProfileImageParam: senderProfileImageParam,
      receiverIdParam: receiverIdParam,
      receiverNameParam: receiverNameParam,
      receiverProfileImageParam: receiverProfileImageParam,
      receiverPhoneNumberParam: receiverPhoneNumberParam,
      receiverCountryCodeParam: receiverCountryCodeParam,
    );
    listenToChatDetail(chatIdParam);
  }

  @override
  void onReady() {
    callUserStatusCheckApi();
    super.onReady();
  }

  @override
  void onClose() {
    SocketService().emitStopTyping(senderId.value, chatId.value);
    SocketService().leaveChat(chatId.value);

    super.onClose();
  }
}

extension ChatDetailsControllerApi on ChatDetailsController {
  void callChatDetailsApi({
    required String chatIdParam,
    required String senderIdParam,
    required String senderNameParam,
    required String senderProfileImageParam,
    required String receiverNameParam,
    required String receiverProfileImageParam,
    required String receiverIdParam,
    required String receiverPhoneNumberParam,
    required String receiverCountryCodeParam,
  }) {
    chatDetailsResponse.value.isLoading = true;
    final request = ChatDetailsRequest(chatId: chatIdParam);
    chatId.value = chatIdParam;
    senderId.value = senderIdParam;
    senderName.value = senderNameParam;
    senderProfileImage.value = senderProfileImageParam;
    receiverName.value = receiverNameParam;
    receiverProfileImage.value = receiverProfileImageParam;
    receiverId.value = receiverIdParam;
    receiverPhoneNumber.value = receiverPhoneNumberParam;
    receiverCountryCode.value = receiverCountryCodeParam;
    ChatService.chatDetailRequestApi(request)
        .then((response) {
          chatDetailsResponse.value = response;
          chatDetailsResponse.value.isLoading = false;
          chatDetailsResponse.refresh();
          if (response.status == 1) {
            ChatService.markMessagesReadApi(
                  MarkMessagesReadRequest(
                    chatId: request.chatId,
                    userId: receiverId.value,
                    status: "read",
                  ),
                )
                .then((markResponse) {
                  if (markResponse.status == 1) {
                    // LoggerUtil.debug(
                    //   'markMessagesReadApi ${markResponse.message}',
                    // );
                  } else {
                    // LoggerUtil.debug(
                    //   'markMessagesReadApi  marking messages as read: ${markResponse.message}',
                    // );
                  }
                })
                .onError((error, stackTrace) {
                  // LoggerUtil.debug(
                  //   'markMessagesReadApi Error markMessagesReadApi marking messages as read: $error',
                  // );
                });
          }
        })
        .onError((error, stackTrace) {
          chatDetailsResponse.value.status = -1;
          chatDetailsResponse.value.isLoading = false;
          chatDetailsResponse.value.message = AppStrings.errorMessage.tr;
          chatDetailsResponse.refresh();
        });
  }

  void callUserStatusCheckApi() {
    ContactService.checkUserStatus(UserStatusRequest(userId: receiverId.value))
        .then((status) {
          isOnline.value = status.data?.isOnline ?? false;
          lastSeen.value = status.data?.lastSeen ?? '';
          LoggerUtil.debug(
            'User status for ${receiverId.value}: isOnline: ${isOnline.value}, lastSeen: ${lastSeen.value}',
          );
        })
        .onError((error, stackTrace) {
          LoggerUtil.error('Error checking user status: $error');
          isOnline.value = false;
          lastSeen.value = '';
        });
  }
}

extension ChatDetailsControllerUtils on ChatDetailsController {
  void sendMessage() {
    if (chatDetailsResponse.value.data?.firstOrNull?.dateLabel == 'Today') {
      updateNewMessage(isAdd: false);
    } else {
      updateNewMessage(isAdd: true);
    }
    chatTextcontroller.clear();
    SocketService().emitStopTyping(senderId.value, chatId.value);
  }

  void updateNewMessage({bool isAdd = false}) {
    final chatText = chatTextcontroller.text.trim();
    final userId = senderId.value;
    final timestamp = DateTime.now().toIso8601String();
    if (userId.isEmpty) {
      return;
    }
    if (chatText.isEmpty) {
      return;
    }
    if (isAdd) {
      chatDetailsResponse.value.data?.insert(
        0,
        ChatDateGroup(
          dateLabel: 'Today',
          messages: [
            ChatMessage(
              senderId: userId,
              receiverId: receiverId.value,
              message: chatText,
              timestamp: timestamp,
              status: 'request',
            ),
          ],
        ),
      );
      chatDetailsResponse.refresh();
    } else {
      chatDetailsResponse.value.data?.first.messages?.add(
        ChatMessage(
          senderId: userId,
          receiverId: receiverId.value,
          message: chatText,
          timestamp: timestamp,
          status: 'request',
        ),
      );
      chatDetailsResponse.refresh();
    }
  }

  void updateMessage({
    required ChatMessage updatedMessage,
    required int index,
    required int gropupIndex,
  }) {
    if (chatId.value.isEmpty) {
      listenToChatDetail(updatedMessage.chatId);
    }
    chatId.value = updatedMessage.chatId ?? chatId.value;
    chatDetailsResponse.value.data?[gropupIndex].messages?[index] =
        updatedMessage;
    chatDetailsResponse.value.data?[gropupIndex].messages?[index].chatId =
        chatId.value;
    chatDetailsResponse.refresh();
    // LoggerUtil.debug(
    //   'Updated message: ${updatedMessage.message} at index: $index in group: $gropupIndex Message $index',
    // );
  }

  void onTextChanged(String text) {
    final userId = senderId.value;
    if (text.isNotEmpty) {
      SocketService().emitStartTyping(userId, chatId.value);
    } else {
      SocketService().emitStopTyping(userId, chatId.value);
    }
  }

  void listenToChatDetail([String? userChatId]) {
    final socket = SocketService().socketInstance;

    SocketService().joinChat(userChatId ?? chatId.value);

    socket.on('updateChatDetails', (data) {
      // LoggerUtil.debug('New message received: $data');
      SocketChatMessageData socketChatMessageData =
          SocketChatMessageData.fromJson(data);
      if (socketChatMessageData.chatId != chatId.value) {
        // LoggerUtil.debug(
        //   'Received message for different chatId: ${socketChatMessageData.chatId}',
        // );
        return;
      }
      if (chatDetailsResponse.value.data?.isEmpty ?? true) {
        // If the data is empty, initialize it with today's date
        chatDetailsResponse.value.data = [
          ChatDateGroup(dateLabel: 'Today', messages: []),
        ];
      }
      if (senderId.value == socketChatMessageData.senderId) {
        // LoggerUtil.debug(
        //   'Ignoring message from self: ${socketChatMessageData.senderId}',
        // );
        return;
      }
      if (socketChatMessageData.messageId.isEmpty) {
        // LoggerUtil.debug(
        //   'Ignoring message with empty messageId: ${socketChatMessageData.messageId}',
        // );
        return;
      }
      final todayDateGroupIndex = chatDetailsResponse.value.data?.indexWhere(
        (group) => group.dateLabel == 'Today',
      );

      if (todayDateGroupIndex != null && todayDateGroupIndex != -1) {
        // Group exists, add to it
        chatDetailsResponse.value.data![todayDateGroupIndex].messages?.add(
          ChatMessage(
            senderId: socketChatMessageData.senderId,
            receiverId: socketChatMessageData.receiverId,
            message: socketChatMessageData.message,
            timestamp: socketChatMessageData.timestamp.toString(),
            status: socketChatMessageData.status,
          ),
        );
      } else {
        // Group doesn't exist, create and add it
        final newTodayGroup = ChatDateGroup(
          dateLabel: 'Today',
          messages: [
            ChatMessage(
              senderId: socketChatMessageData.senderId,
              receiverId: socketChatMessageData.receiverId,
              message: socketChatMessageData.message,
              timestamp: socketChatMessageData.timestamp.toString(),
              status: socketChatMessageData.status,
            ),
          ],
        );
        chatDetailsResponse.value.data?.insert(0, newTodayGroup); // add to top
      }

      if (senderId.value != socketChatMessageData.senderId) {
        SocketService().emitMarkAsRead(
          socketChatMessageData.senderId,
          socketChatMessageData.receiverId,
          socketChatMessageData.chatId,
        );
      }

      chatDetailsResponse.refresh();

      //  else {
      //   // If no 'Today' group exists, create it
      //   // LoggerUtil.debug('No "Today" group found, creating a new one.');
      //   // LoggerUtil.debug(
      //   //   'Creating new ChatDateGroup with message: ${socketChatMessageData.message}',
      //   // );
      //   // LoggerUtil.debug(
      //   //   'ChatDetailsResponse before adding new group: ${chatDetailsResponse.value.data}',
      //   // );
      //   // LoggerUtil.debug(
      //   //   'ChatDetailsResponse data length before adding new group: ${chatDetailsResponse.value.data?.length}',
      //   // );
      //   // LoggerUtil.debug(
      //   //   'ChatDetailsResponse data first message: ${chatDetailsResponse.value.data?.first.messages?.firstOrNull?.message}',
      //   // );
      //   chatDetailsResponse.value.data = [
      //     ChatDateGroup(dateLabel: 'Today', messages: []),
      //   ];
      // }
    });

    socket.on('messageDeliveredAll', (data) {
      // LoggerUtil.debug('Message delivered event received: $data');
      final deliveredData = MessageStatusListener.fromJson(
        data as Map<String, dynamic>,
      );
      if (deliveredData.senderId == senderId.value &&
          deliveredData.chatId == chatId.value) {
        // Loop through all chat groups
        for (ChatDateGroup chatGroup in chatDetailsResponse.value.data ?? []) {
          // Check if there are any messages
          if (chatGroup.messages != null) {
            for (var message in chatGroup.messages!) {
              final isSameChat = message.chatId == deliveredData.chatId;
              final isFromSender = message.senderId == deliveredData.senderId;
              final notRead = message.status == 'sent';
              // LoggerUtil.debug(
              //   "CHAT GROUP delivered: ${chatGroup.dateLabel} - Message: ${message.message} - Status: ${message.status} user - ${message.senderId} == ${deliveredData.senderId}  send - $notRead isSameChat - $isSameChat ${message.chatId}",
              // );
              if (isSameChat && isFromSender && notRead) {
                message.status = 'delivered';

                // LoggerUtil.debug(
                //   'Updated message Changing delivered ${message.messageId} ${message.message} ${message.status} to delivered',
                // );
              }
            }
          }
        }
        chatDetailsResponse.refresh();
        // LoggerUtil.debug(
        //   'Updated message ARRAY delivered ${chatDetailsResponse.value.data?.first.messages?.lastOrNull?.message} -- ${chatDetailsResponse.value.data?.first.messages?.lastOrNull?.status} to delivered',
        // );
      }
    });

    socket.on('messageRead', (data) {
      //  LoggerUtil.debug('Message read event received: $data');
      final deliveredData = MessageStatusListener.fromJson(
        data as Map<String, dynamic>,
      );
      if (deliveredData.senderId == senderId.value &&
          deliveredData.chatId == chatId.value) {
        // Loop through all chat groups
        for (ChatDateGroup chatGroup in chatDetailsResponse.value.data ?? []) {
          // Check if there are any messages
          if (chatGroup.messages != null) {
            for (var message in chatGroup.messages!) {
              final isSameChat = message.chatId == deliveredData.chatId;
              final isFromSender = message.senderId == deliveredData.senderId;
              final notRead =
                  message.status == 'sent' || message.status == 'delivered';
              // LoggerUtil.debug(
              //   "CHAT GROUP read: ${chatGroup.dateLabel} - Message: ${message.message} - Status: ${message.status} user - ${message.senderId} == ${deliveredData.senderId}  send - $notRead isSameChat - $isSameChat ${message.chatId}",
              // );
              if (isSameChat && isFromSender && notRead) {
                message.status = 'read';
                // LoggerUtil.debug(
                //   'Updated message Changing read ${message.messageId} ${message.message} ${message.status} to delivered',
                // );
              }
            }
          }
        }
        chatDetailsResponse.refresh();
        // LoggerUtil.debug(
        //   'Updated message ARRAY  read ${chatDetailsResponse.value.data?.first.messages?.lastOrNull?.message} -- ${chatDetailsResponse.value.data?.first.messages?.lastOrNull?.status} to delivered',
        // );
      }
    });

    socket.on('userTyping', (data) {
      final typingUserId = data['senderId'];
      LoggerUtil.debug("User $typingUserId is typing...");
      if (typingUserId == receiverId.value) {
        isTyping.value = true;
      }

      // Show typing indicator for this user in chat
    });

    socket.on('userStoppedTyping', (data) {
      final userId = data['senderId'];
      LoggerUtil.debug("User $userId stopped typing...");
      if (userId == receiverId.value) {
        isTyping.value = false;
      }
      // Hide typing indicator
    });

    socket.on('updateUserStatus', (data) {
      final userId = data['userId'];
      final status = data['status'] ?? ''; // 'online' or 'offline'
      final lastSeen = data['lastSeen'] ?? ''; // only for offline
      LoggerUtil.debug("User $userId is $status. Last seen: $lastSeen");
      if (userId == receiverId.value) {
        isOnline.value = (status == 'online');
        this.lastSeen.value =
            DateTimeUtil.convertToLocalDateTimeString(lastSeen) ?? "";
      }
    });
  }
}
