import 'dart:io';
import 'package:cholai_sdk/src/config/color_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({this.color, this.size, super.key});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? LoadingAnimationWidget.discreteCircle(
          color: color ?? ColorConfig.primaryColor,
          size: size ?? 30,
        )
        : CupertinoActivityIndicator(
          radius: 16.r,
          color: color ?? ColorConfig.primaryColor,
        );
  }
}

class ImageLoader extends StatelessWidget {
  const ImageLoader({this.color, this.size, super.key});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.threeRotatingDots(
      color: color ?? Colors.black,
      size: size ?? 30,
    );
  }
}

class DotLoader extends StatelessWidget {
  const DotLoader({this.color, this.size, super.key});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: color ?? Colors.black,
      size: size ?? 30,
    );
  }
}
