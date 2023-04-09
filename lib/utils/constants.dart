import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xFFa33b3e);
  static const secondaryColor = Color(0xFF03DAC5);
  static const primaryBackgroundColor = Color(0xFFFFFFFF);
  static const secondaryBackgroundColor = Color(0xFFf6f7f6);
  static const primaryTextColor = Color(0xFF333333);
  static const secondaryTextColor = Color.fromARGB(215, 51, 51, 51);
  static const headingTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
  );
  static const secondaryHeadingTextStyle = TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: secondaryTextColor);
  static const bodyTextStyle = TextStyle(
    fontSize: 16,
    color: primaryTextColor,
  );
  static const secondaryBodyTextStyle = TextStyle(
    fontSize: 16,
    color: secondaryTextColor,
  );
}
