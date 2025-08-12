import 'package:flutter/cupertino.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static CupertinoThemeData get lightTheme {
    return const CupertinoThemeData(
      primaryColor: AppConstants.primaryColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppConstants.backgroundColor,
    );
  }
  
  static CupertinoThemeData get darkTheme {
    return const CupertinoThemeData(
      primaryColor: AppConstants.primaryColor,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: CupertinoColors.systemBackground,
    );
  }
}
