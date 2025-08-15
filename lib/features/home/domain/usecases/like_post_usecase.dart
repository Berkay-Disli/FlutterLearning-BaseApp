import '../../../../models/post.dart';
import '../repositories/post_repository.dart';

/// Use case for liking/unliking posts
class LikePostUseCase {
  final PostRepository _repository;

  LikePostUseCase(this._repository);

  /// Like a post
  Future<Post> likePost(String postId) async {
    return await _repository.likePost(postId);
  }

  /// Unlike a post
  Future<Post> unlikePost(String postId) async {
    return await _repository.unlikePost(postId);
  }

  /// Toggle like state of a post
  Future<Post> toggleLike(String postId, bool isCurrentlyLiked) async {
    if (isCurrentlyLiked) {
      return await _repository.unlikePost(postId);
    } else {
      return await _repository.likePost(postId);
    }
  }
}
