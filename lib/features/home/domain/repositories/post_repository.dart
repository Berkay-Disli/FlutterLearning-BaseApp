import '../../../../core/base/base_repository.dart';
import '../../../../models/post.dart';

/// Repository interface for post operations
/// Similar to Swift protocol-based repositories
abstract class PostRepository extends SearchableRepository<Post> {
  /// Get posts for home feed
  Future<List<Post>> getHomePosts();
  
  /// Like a post
  Future<Post> likePost(String postId);
  
  /// Unlike a post
  Future<Post> unlikePost(String postId);
  
  /// Retweet a post
  Future<Post> retweetPost(String postId);
  
  /// Unretweet a post
  Future<Post> unretweetPost(String postId);
  
  /// Get post details with replies
  Future<Post> getPostDetails(String postId);
  
  /// Reply to a post
  Future<Post> replyToPost(String postId, String replyText);
}
