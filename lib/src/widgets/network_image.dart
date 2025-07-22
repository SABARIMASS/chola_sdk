import 'package:cached_network_image/cached_network_image.dart';
import 'package:cholai_sdk/src/constants/image_assets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CommonCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final Widget? errorWidget;
  final bool isCircle;
  final Function()? onTap;

  const CommonCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.errorWidget,
    this.isCircle = false,
    this.onTap, // Default is rectangle
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = InkWell(
      onTap: onTap,
      borderRadius: isCircle ? null : BorderRadius.circular(8.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: height,
                width: width,
                color: Colors.white,
              ),
            ),
        errorWidget:
            (context, url, error) =>
                errorWidget ??
                Image.asset(
                  Assets.noImages,
                  height: height ?? 50.0,
                  width: height ?? 50.0,
                ),
      ),
    );

    // If `isCircle` is true, wrap the image with a Circular widget
    return isCircle
        ? ClipOval(child: imageWidget)
        : imageWidget; // Return the image as-is if it's not a circle
  }
}
