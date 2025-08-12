import 'package:flutter/cupertino.dart';
import '../../core/constants/app_constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.exclamationmark_triangle,
            size: 64,
            color: CupertinoColors.systemRed,
          ),
          const SizedBox(height: AppConstants.defaultSpacing),
          Text(
            message,
            style: AppConstants.subtitleStyle,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppConstants.defaultSpacing),
            CupertinoButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: AppConstants.iconSize,
            color: AppConstants.secondaryTextColor,
          ),
          const SizedBox(height: AppConstants.defaultSpacing),
          Text(
            title,
            style: AppConstants.titleStyle,
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: AppConstants.subtitleStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
