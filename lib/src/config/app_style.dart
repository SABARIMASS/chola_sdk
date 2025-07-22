import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppFontSize {
  extraSmall, // 10
  small, // 12
  medium, // 14
  large, // 16
  extraLarge, // 18
  extraextralarge, // 20
  huge, // 22
  extraHuge, // 24
}

extension FontSizeHelper on AppFontSize {
  double get value {
    switch (this) {
      case AppFontSize.extraSmall:
        return 10.sp;
      case AppFontSize.small:
        return 12.sp;
      case AppFontSize.medium:
        return 14.sp;
      case AppFontSize.large:
        return 16.sp;
      case AppFontSize.extraLarge:
        return 18.sp;
      case AppFontSize.extraextralarge:
        return 20.sp;
      case AppFontSize.huge:
        return 22.sp;
      case AppFontSize.extraHuge:
        return 24.sp;
    }
  }
}

enum AppFontWeight { light, normal, bold, semibold, medium, large }

extension FontWeightHelper on AppFontWeight {
  FontWeight get value {
    switch (this) {
      case AppFontWeight.light:
        return FontWeight.w300;
      case AppFontWeight.normal:
        return FontWeight.w400;
      case AppFontWeight.bold:
        return FontWeight.w700;
      case AppFontWeight.large:
        return FontWeight.w800;
      case AppFontWeight.medium:
        return FontWeight.w500;
      case AppFontWeight.semibold:
        return FontWeight.w600;
    }
  }
}
