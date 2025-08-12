import 'package:flutter/cupertino.dart';
import '../../../../core/constants/app_constants.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Search'),
            backgroundColor: CupertinoColors.systemBackground.withOpacity(0.8),
            border: null,
            automaticallyImplyLeading: false,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppConstants.defaultPadding, 
                0, 
                AppConstants.defaultPadding, 
                AppConstants.defaultPadding
              ),
              child: Column(
                children: <Widget>[
                  CupertinoSearchTextField(
                    placeholder: 'Search for something...',
                    onChanged: (String value) {
                      // Handle search input
                    },
                  ),
                  const SizedBox(height: 140),
                  const Icon(
                    CupertinoIcons.search,
                    size: AppConstants.iconSize,
                    color: AppConstants.secondaryTextColor,
                  ),
                  const SizedBox(height: AppConstants.defaultSpacing),
                  const Text(
                    'Search Page',
                    style: AppConstants.titleStyle,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Use the search bar above to find what you\'re looking for',
                    style: AppConstants.subtitleStyle,
                    textAlign: TextAlign.center,
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
