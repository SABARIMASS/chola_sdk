import 'package:cholai_sdk/src/config/color_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final double radius;
  final Color? iconColor;
  final Color? backgroudColor;
  final double iconSize;
  final VoidCallback? onTap;
  final Color shadowColor;
  final double shadowBlurRadius;
  final Offset shadowOffset;
  final EdgeInsetsGeometry? padding;
  final BoxShape shape;
  final double circleRadius;
  final Color? borderColor;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.radius = 20,
    this.iconColor,
    this.iconSize = 20,
    this.onTap,
    this.shadowColor = Colors.black26,
    this.shadowBlurRadius = 10.0,
    this.shadowOffset = const Offset(0, 4),
    this.padding,
    this.circleRadius = 8,
    this.backgroudColor,
    this.borderColor,
    this.shape = BoxShape.circle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? Colors.transparent),
        borderRadius:
            shape == BoxShape.rectangle
                ? BorderRadius.circular(circleRadius)
                : null,
        color: backgroudColor ?? ColorConfig.backgroundColor,
        shape: shape == BoxShape.circle ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder:
              shape == BoxShape.rectangle ? null : const CircleBorder(),
          borderRadius:
              shape == BoxShape.rectangle
                  ? BorderRadius.circular(circleRadius)
                  : BorderRadius.zero,
          onTap: onTap,
          child: Padding(
            padding: padding ?? EdgeInsets.all(1.r),
            child: Center(
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor ?? ColorConfig.iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
