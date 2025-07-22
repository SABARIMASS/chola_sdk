import 'package:cholai_sdk/src/config/app_style.dart';
import 'package:cholai_sdk/src/config/color_config.dart';
import 'package:cholai_sdk/src/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
//REFER THE STYLES FROM THAT CHAT VIEW IN THAT FOLDER HAVE THE FILES FROM THAT REFER AND GIVE NEW CODE

class ChatDialogFunctions {
  static profileDialogWidget(
    BuildContext context,
    String name,
    String imageUrl,
    String phoneNumber,
  ) {
    return Get.dialog(
      AlertDialog(
        backgroundColor: ColorConfig.backgroundColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80.r,
              backgroundColor: ColorConfig.primaryColor,
              child: CommonCachedNetworkImage(
                height: 120.h,
                width: 150.w,
                imageUrl: imageUrl,
                isCircle: true,
                errorWidget: Icon(
                  HugeIcons.strokeRoundedUser,
                  color: ColorConfig.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 10),

            Text(
              phoneNumber,
              style: TextStyle(
                color: ColorConfig.textColor,
                fontSize: AppFontSize.small.value,
                fontWeight: AppFontWeight.bold.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
