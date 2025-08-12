import 'package:flutter/cupertino.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'navigation/main_tab_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      home: const MainTabBar(),
    );
  }
}
