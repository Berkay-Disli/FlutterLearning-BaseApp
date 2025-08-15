import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../models/post.dart';
import '../viewmodels/post_details_view_model.dart';

class PostDetailsScreen extends StatefulWidget {
  final Post post;

  const PostDetailsScreen({super.key, required this.post});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late PostDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = serviceLocator<PostDetailsViewModel>(param1: widget.post);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<PostDetailsViewModel>(
        builder: (context, viewModel, child) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Post'),
              backgroundColor: CupertinoColors.systemBackground.withOpacity(0.8),
              border: null,
            ),
            child: CustomScrollView(
              slivers: [
                // Add top padding to account for navigation bar
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.top + 44, // Navigation bar height
                  ),
                ),
                // Main post content
                SliverToBoxAdapter(child: _buildMainPost(viewModel)),
                // Reply input section
                SliverToBoxAdapter(child: _buildReplyInput(viewModel)),
                // Replies section
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildReplyItem(viewModel, index),
                    childCount: viewModel.replies.length,
                  ),
                ),
                // Bottom padding
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainPost(PostDetailsViewModel viewModel) {
    final post = viewModel.post;
    
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 6),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.separator, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with avatar, username, and timestamp
          Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey5,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    post.username.isNotEmpty ? post.username[0].toUpperCase() : 'U',
                    style: const TextStyle(
                      color: CupertinoColors.label,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Username and timestamp
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: CupertinoColors.label,
                      ),
                    ),
                    Text(
                      post.timestamp,
                      style: const TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // More options button
              CupertinoButton(
                onPressed: () {
                  _showActionSheet();
                },
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.ellipsis,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Post content
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 20,
              color: CupertinoColors.label,
              height: 1.4,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            post.subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: CupertinoColors.secondaryLabel,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          // Action buttons with counts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButtonWithCount(
                icon: CupertinoIcons.chat_bubble,
                count: post.replyCount,
                label: 'Reply',
                onPressed: () {
                  viewModel.focusReplyInput();
                },
              ),
              _buildActionButtonWithCount(
                icon: CupertinoIcons.arrow_2_circlepath,
                count: post.retweetCount,
                label: 'Retweet',
                isActive: post.isRetweeted,
                onPressed: () {
                  viewModel.toggleRetweet();
                },
              ),
              _buildActionButtonWithCount(
                icon: CupertinoIcons.heart,
                count: post.likeCount,
                label: 'Like',
                isActive: post.isLiked,
                onPressed: () {
                  viewModel.toggleLike();
                },
              ),
              _buildActionButtonWithCount(
                icon: CupertinoIcons.share,
                count: 0,
                label: 'Share',
                onPressed: () {
                  _showShareSheet();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtonWithCount({
    required IconData icon,
    required int count,
    required String label,
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 22,
            color: isActive
                ? (icon == CupertinoIcons.heart
                      ? CupertinoColors.systemRed
                      : CupertinoColors.systemGreen)
                : CupertinoColors.systemGrey,
          ),
          if (count > 0) ...[
            const SizedBox(width: 4),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 14,
                color: isActive
                    ? (icon == CupertinoIcons.heart
                          ? CupertinoColors.systemRed
                          : CupertinoColors.systemGreen)
                    : CupertinoColors.systemGrey,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReplyInput(PostDetailsViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.separator, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey5,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'U',
                style: TextStyle(
                  color: CupertinoColors.label,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Reply input
          Expanded(
            child: CupertinoTextField(
              controller: viewModel.replyController,
              focusNode: viewModel.replyFocusNode,
              placeholder: 'Post your reply',
              maxLines: null,
              decoration: null,
            ),
          ),
          const SizedBox(width: 12),
          // Reply button
          CupertinoButton(
            onPressed: viewModel.isReplyButtonEnabled ? () => viewModel.postReply() : null,
            sizeStyle: CupertinoButtonSize.medium,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            color: viewModel.isReplyButtonEnabled
                ? CupertinoColors.activeBlue
                : CupertinoColors.systemGrey4,
            borderRadius: BorderRadius.circular(40),
            child: Text(
              'Reply',
              style: TextStyle(
                color: viewModel.isReplyButtonEnabled
                    ? CupertinoColors.white
                    : CupertinoColors.systemGrey,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplyItem(PostDetailsViewModel viewModel, int index) {
    final reply = viewModel.replies[index];

    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.separator, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey5,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    reply['username']![0].toUpperCase(),
                    style: const TextStyle(
                      color: CupertinoColors.label,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Reply content
              Text(
                reply['username']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: CupertinoColors.label,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                reply['timestamp']!,
                style: const TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            reply['content']!,
            style: const TextStyle(
              fontSize: 14,
              color: CupertinoColors.label,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildReplyActionButton(
                icon: CupertinoIcons.chat_bubble,
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              _buildReplyActionButton(
                icon: CupertinoIcons.arrow_2_circlepath,
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              _buildReplyActionButton(
                icon: CupertinoIcons.heart,
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              _buildReplyActionButton(
                icon: CupertinoIcons.share,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReplyActionButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Icon(icon, size: 16, color: CupertinoColors.systemGrey),
    );
  }

  void _showActionSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Post Actions'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // Add to bookmarks
            },
            child: const Text('Add to Bookmarks'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // Copy link
            },
            child: const Text('Copy Link'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // Report post
            },
            isDestructiveAction: true,
            child: const Text('Report Post'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  void _showShareSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Share Post'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // Share via message
            },
            child: const Text('Share via Message'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // Share via email
            },
            child: const Text('Share via Email'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              // Copy link
            },
            child: const Text('Copy Link'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}
