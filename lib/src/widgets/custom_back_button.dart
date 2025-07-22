import 'package:cholai_sdk/src/config/color_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  final bool withCircle;
  final VoidCallback? onTap;
  final Color? color;
  const CustomBackButton({
    super.key,
    this.withCircle = false,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            Get.back();
          },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          splashColor: Colors.grey.withValues(alpha: 0.5),
          onTap:
              onTap ??
              () {
                Get.back();
              },
          child: Container(
            decoration:
                withCircle
                    ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConfig.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    )
                    : null,
            padding: EdgeInsets.all(withCircle ? 8.r : 8.r),
            child: Icon(
              CupertinoIcons.back,
              color: color ?? ColorConfig.iconColor,
              size: 26.r,
            ),
          ),
        ),
      ),
    );
  }
}
