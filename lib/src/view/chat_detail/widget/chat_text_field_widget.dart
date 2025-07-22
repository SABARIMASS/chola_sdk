import 'package:cholai_sdk/src/config/app_info.dart';
import 'package:cholai_sdk/src/config/app_style.dart';
import 'package:cholai_sdk/src/config/color_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatTextWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  const ChatTextWidget({
    super.key,
    required this.controller,
    required this.hint,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      keyboardAppearance:
          AppInfo.kThemeMode == ThemeMode.light
              ? Brightness.light
              : Brightness.dark,
      onTap: onTap,
      cursorHeight: 15.h,
      controller: controller,
      style: TextStyle(
        color: ColorConfig.textColor,
        fontSize: AppFontSize.small.value,
        fontWeight: AppFontWeight.semibold.value,
      ),
      keyboardType: TextInputType.multiline, // Supports multi-line input
      textInputAction: TextInputAction.newline, // Moves to next line on Enter
      maxLines: 7, // Expands dynamically
      minLines: 1,
      expands: false,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: ColorConfig.hintTextColor,
          fontSize: AppFontSize.small.value,
          fontWeight: AppFontWeight.semibold.value,
        ),
        hintText: hint,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 0.w,
        ), // Adds padding
      ),
      cursorColor: ColorConfig.cursorColor, // Customize cursor color
    );
  }
}
