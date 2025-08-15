import '../../../../models/post.dart';
import '../repositories/post_repository.dart';

/// Use case for retweeting/unretweeting posts
class RetweetPostUseCase {
  final PostRepository _repository;

  RetweetPostUseCase(this._repository);

  /// Retweet a post
  Future<Post> retweetPost(String postId) async {
    return await _repository.retweetPost(postId);
  }

  /// Unretweet a post
  Future<Post> unretweetPost(String postId) async {
    return await _repository.unretweetPost(postId);
  }

  /// Toggle retweet state of a post
  Future<Post> toggleRetweet(String postId, bool isCurrentlyRetweeted) async {
    if (isCurrentlyRetweeted) {
      return await _repository.unretweetPost(postId);
    } else {
      return await _repository.retweetPost(postId);
    }
  }
}
