import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'core/di/service_locator.dart';
import 'features/home/presentation/viewmodels/home_view_model.dart';
import 'navigation/main_tab_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await initializeDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => serviceLocator<HomeViewModel>(),
        ),
      ],
      child: CupertinoApp(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        home: const MainTabBar(),
      ),
    );
  }
}
