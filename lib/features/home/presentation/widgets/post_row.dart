import 'package:apitestflutter/features/home/presentation/pages/post_details_screen.dart';
import 'package:flutter/cupertino.dart';
import '../../../../models/post.dart';

class PostRow extends StatelessWidget {
  final Post post;

  const PostRow({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.separator,
            width: 0.5,
          ),
        ),
      ),
      child: CupertinoButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => PostDetailsScreen(post: post),
            ),
          );
        },
        padding: EdgeInsets.all(0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with username and timestamp
          Row(
            children: [
              // Avatar placeholder
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey5,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                  post.username.isNotEmpty ? post.username[0].toUpperCase() : 'U',
                  style: TextStyle(
                    color: CupertinoColors.label,
                    fontSize: 15,
                    fontWeight: FontWeight.w700
                  ),
                  maxLines: 1,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Username and timestamp
              Expanded(
                child: Row(
                      children: [
                        Text(
                          post.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: CupertinoColors.label,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          post.timestamp,
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
              ),
              // More options button
              CupertinoButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.ellipsis,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Title
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 16,
              color: CupertinoColors.label,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 2),
          // Subtitle
          Text(
            post.subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: CupertinoColors.secondaryLabel,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          // Bottom action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Reply button
              _buildActionButton(
                icon: CupertinoIcons.chat_bubble,
                label: 'Reply',
                onPressed: () {},
              ),
              // Retweet button
              _buildActionButton(
                icon: CupertinoIcons.arrow_2_circlepath,
                label: 'Retweet',
                onPressed: () {},
              ),
              // Like button
              _buildActionButton(
                icon: CupertinoIcons.heart,
                label: 'Like',
                onPressed: () {},
              ),
              // Share button
              _buildActionButton(
                icon: CupertinoIcons.share,
                label: 'Share',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
        )
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: CupertinoColors.systemGrey,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ],
      ),
    );
  }
}