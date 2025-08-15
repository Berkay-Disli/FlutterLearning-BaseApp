import 'package:flutter/material.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../models/post.dart';
import '../../domain/usecases/like_post_usecase.dart';
import '../../domain/usecases/retweet_post_usecase.dart';

/// ViewModel for Post Details screen
/// Similar to Swift MVVM ViewModels
class PostDetailsViewModel extends BaseViewModel {
  final LikePostUseCase _likePostUseCase;
  final RetweetPostUseCase _retweetPostUseCase;
  
  Post _post;
  final TextEditingController replyController = TextEditingController();
  final FocusNode replyFocusNode = FocusNode();
  List<Map<String, String>> _replies = [];

  PostDetailsViewModel({
    required Post post,
    required LikePostUseCase likePostUseCase,
    required RetweetPostUseCase retweetPostUseCase,
  }) : _post = post,
       _likePostUseCase = likePostUseCase,
       _retweetPostUseCase = retweetPostUseCase {
    _initializeReplies();
    replyController.addListener(_onReplyTextChanged);
  }

  /// Current post
  Post get post => _post;
  
  /// Replies to the post
  List<Map<String, String>> get replies => _replies;
  
  /// Whether reply button should be enabled
  bool get isReplyButtonEnabled => replyController.text.trim().isNotEmpty;

  /// Initialize mock replies
  void _initializeReplies() {
    _replies = [
      {'username': 'John Doe', 'content': 'Great post! Thanks for sharing.', 'timestamp': '1h'},
      {'username': 'Jane Smith', 'content': 'This is really helpful information.', 'timestamp': '2h'},
      {'username': 'Mike Johnson', 'content': 'I agree with your points here.', 'timestamp': '3h'},
      {'username': 'Sarah Wilson', 'content': 'Interesting perspective on this topic.', 'timestamp': '4h'},
      {'username': 'David Brown', 'content': 'Thanks for the detailed explanation.', 'timestamp': '5h'},
      {'username': 'Lisa Davis', 'content': 'This resonates with my experience.', 'timestamp': '6h'},
      {'username': 'Tom Miller', 'content': 'Well said! Looking forward to more posts.', 'timestamp': '7h'},
      {'username': 'Amy Garcia', 'content': 'This is exactly what I needed to know.', 'timestamp': '8h'},
      {'username': 'Chris Rodriguez', 'content': 'Great insights, thank you!', 'timestamp': '9h'},
      {'username': 'Emma Martinez', 'content': 'I learned something new today.', 'timestamp': '10h'},
    ];
  }

  /// Handle reply text changes
  void _onReplyTextChanged() {
    notifyListeners();
  }

  /// Toggle like state of the post
  Future<void> toggleLike() async {
    await executeAsync(() async {
      final updatedPost = await _likePostUseCase.toggleLike(
        _post.id, 
        _post.isLiked,
      );
      _post = updatedPost;
      logDebug('Post ${_post.isLiked ? 'liked' : 'unliked'}: ${_post.id}');
    });
  }

  /// Toggle retweet state of the post
  Future<void> toggleRetweet() async {
    await executeAsync(() async {
      final updatedPost = await _retweetPostUseCase.toggleRetweet(
        _post.id, 
        _post.isRetweeted,
      );
      _post = updatedPost;
      logDebug('Post ${_post.isRetweeted ? 'retweeted' : 'unretweeted'}: ${_post.id}');
    });
  }

  /// Post a reply
  Future<void> postReply() async {
    if (!isReplyButtonEnabled) return;

    final replyText = replyController.text.trim();
    if (replyText.isEmpty) return;

    await executeAsync(() async {
      // In a real app, this would call the repository to post the reply
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Add the reply to the local list
      _replies.insert(0, {
        'username': 'Current User',
        'content': replyText,
        'timestamp': 'now',
      });
      
      // Update the post's reply count
      _post = _post.copyWith(
        replyCount: _post.replyCount + 1,
      );
      
      // Clear the reply input
      replyController.clear();
      
      logDebug('Reply posted: $replyText');
    });
  }

  /// Focus the reply input
  void focusReplyInput() {
    replyFocusNode.requestFocus();
  }

  @override
  void dispose() {
    replyController.dispose();
    replyFocusNode.dispose();
    super.dispose();
  }
}
