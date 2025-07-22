import 'package:cholai_sdk/src/config/color_config.dart';
import 'package:cholai_sdk/src/widgets/app_loader.dart';
import 'package:cholai_sdk/src/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginationLoader extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final bool? showMessage;

  const PaginationLoader({
    super.key,
    required this.isLoading,
    this.errorMessage,
    this.onRetry,
    this.showMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: const Center(child: AppLoader()),
      );
    } else if (errorMessage != null &&
        errorMessage!.isNotEmpty &&
        showMessage == true) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: CustomIconButton(
          radius: 8.r,
          iconColor: ColorConfig.iconLightColor,
          onTap: onRetry,
          icon: Icons.refresh,
        ),
      );
    }
    return const SizedBox.shrink(); // No loading or error state
  }
}
