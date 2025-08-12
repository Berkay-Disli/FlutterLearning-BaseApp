import 'package:flutter/cupertino.dart';

class AppConstants {
  // App Information
  static const String appName = 'API Test Flutter';
  static const String appVersion = '1.0.0';
  
  // Colors
  static const Color primaryColor = CupertinoColors.systemBlue;
  static const Color backgroundColor = CupertinoColors.white;
  static const Color textColor = CupertinoColors.label;
  static const Color secondaryTextColor = CupertinoColors.systemGrey;
  
  // Dimensions
  static const double defaultPadding = 16.0;
  static const double defaultSpacing = 20.0;
  static const double largeSpacing = 100.0;
  static const double iconSize = 100.0;
  
  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    color: CupertinoColors.systemGrey,
  );
}
