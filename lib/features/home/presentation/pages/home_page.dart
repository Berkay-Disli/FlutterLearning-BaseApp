import 'package:flutter/cupertino.dart';
import '../../../../core/constants/app_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Home'),
            backgroundColor: CupertinoColors.systemBackground.withOpacity(0.8),
            border: null,
            automaticallyImplyLeading: false,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 140),
                  const Icon(
                    CupertinoIcons.house_fill,
                    size: AppConstants.iconSize,
                    color: AppConstants.primaryColor,
                  ),
                  const SizedBox(height: AppConstants.defaultSpacing),
                  const Text(
                    'Welcome to Home',
                    style: AppConstants.titleStyle,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'This is your home page',
                    style: AppConstants.subtitleStyle,
                  ),
                  const SizedBox(height: AppConstants.largeSpacing),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
