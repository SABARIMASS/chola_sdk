import 'package:flutter/material.dart';

class ColorConfig {
  /// Base colors
  static late Color primaryColor;
  static late Color secondaryColor;
  static late Color textColor;
  static late Color backgroundColor;
  static late Color dateLabelColor;
  static late Color hintTextColor;
  static late Color whiteColor;
  static late Color blackColor;
  static late Color cursorColor;
  static late Color iconColor;
  static late Color iconLightColor;

  /// Chat-specific colors
  static late Color userMessageBubbleColor;
  static late Color receiverMessageBubbleColor;
  static late Color inputFieldColor;
  static late Color typingIndicatorColor;

  /// Initialization function with defaults
  static void initialize({
    Color? primary,
    Color? secondary,
    Color? text,
    Color? background,
    Color? dateLabel,
    Color? hintText,
    Color? white,
    Color? black,
    Color? cursor,
    Color? icon,
    Color? iconLight,
    Color? userBubble,
    Color? receiverBubble,
    Color? inputField,
    Color? typingIndicator,
  }) {
    primaryColor = primary ?? Colors.blue;
    secondaryColor = secondary ?? Colors.green;
    textColor = text ?? Colors.black;
    backgroundColor = background ?? Colors.white;
    dateLabelColor = dateLabel ?? Colors.blueGrey;
    hintTextColor = hintText ?? Colors.grey;
    whiteColor = white ?? Colors.white;
    blackColor = black ?? Colors.black;
    cursorColor = cursor ?? Colors.blueAccent;
    iconColor = icon ?? Colors.grey;
    iconLightColor = iconLight ?? Colors.lightBlueAccent;
    userMessageBubbleColor = userBubble ?? Colors.blue.shade100;
    receiverMessageBubbleColor = receiverBubble ?? Colors.grey.shade200;
    inputFieldColor = inputField ?? Colors.white;
    typingIndicatorColor = typingIndicator ?? Colors.greenAccent;
  }
}
