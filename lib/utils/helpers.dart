import 'package:flutter/cupertino.dart';
import 'dart:async'; // Added missing import for Timer

class Helpers {
  // Format date to readable string
  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Format date to relative time (e.g., "2 hours ago")
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  // Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Show alert dialog
  static void showAlert(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            if (cancelText != null)
              CupertinoDialogAction(
                child: Text(cancelText),
                onPressed: () {
                  Navigator.of(context).pop();
                  onCancel?.call();
                },
              ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(confirmText ?? 'OK'),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
            ),
          ],
        );
      },
    );
  }

  // Debounce function for search
  static Function debounce(Function func, Duration wait) {
    Timer? timer;
    return (dynamic args) {
      timer?.cancel();
      timer = Timer(wait, () => func(args));
    };
  }
}
