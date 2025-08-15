import '../../../../models/post.dart';
import '../repositories/post_repository.dart';

/// Use case for getting posts
/// Similar to Swift use cases/interactors
class GetPostsUseCase {
  final PostRepository _repository;

  GetPostsUseCase(this._repository);

  /// Execute the use case
  Future<List<Post>> execute() async {
    return await _repository.getHomePosts();
  }
}
