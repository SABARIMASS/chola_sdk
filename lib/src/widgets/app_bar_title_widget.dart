import 'package:cholai_sdk/src/config/app_style.dart';
import 'package:cholai_sdk/src/config/color_config.dart';
import 'package:cholai_sdk/src/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarTitleWidget extends StatelessWidget {
  final bool withCircle;
  final VoidCallback? onTap;
  final String? title;
  final bool? disableBackButton;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;
  final List<Widget>? actions;
  final AlignmentGeometry alignment;
  final Widget? titleWidget;
  final EdgeInsetsGeometry? titlePadding;
  final Color? backIconColor;

  const AppBarTitleWidget({
    super.key,
    this.withCircle = false,
    this.onTap,
    this.title,
    this.titleStyle,
    this.padding,
    this.actions,
    this.disableBackButton,
    this.alignment = Alignment.center,
    this.titleWidget,
    this.titlePadding,
    this.backIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ??
          EdgeInsets.only(
            left: disableBackButton == true ? 14.w : 3.w,
            right: 16.w,
          ),
      child: Row(
        children: [
          disableBackButton != true
              ? Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: CustomBackButton(
                  color: backIconColor,
                  withCircle: withCircle,
                  onTap:
                      onTap ??
                      () {
                        Navigator.of(context).pop();
                      },
                ),
              )
              : const SizedBox(width: 0),
          titleWidget ??
              Expanded(
                child: Align(
                  alignment: alignment,
                  child: Padding(
                    padding: titlePadding ?? const EdgeInsets.all(0),
                    child: Text(
                      title ?? "",
                      style:
                          titleStyle ??
                          TextStyle(
                            color: ColorConfig.textColor,
                            fontSize: AppFontSize.medium.value,
                            fontWeight: AppFontWeight.bold.value,
                          ),
                    ),
                  ),
                ),
              ),
          if (actions != null) ...actions!,
          if (actions == null) ...[SizedBox(width: 14.w)],
        ],
      ),
    );
  }
}
