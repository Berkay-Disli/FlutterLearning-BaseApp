import '../../../../core/base/base_view_model.dart';
import '../../../../models/post.dart';
import '../../domain/usecases/get_posts_usecase.dart';

/// ViewModel for Home page
/// Similar to Swift MVVM ViewModels
class HomeViewModel extends BaseViewModel {
  final GetPostsUseCase _getPostsUseCase;
  
  List<Post> _posts = [];
  bool _hasMorePosts = true;
  int _currentPage = 1;

  HomeViewModel({required GetPostsUseCase getPostsUseCase}) 
      : _getPostsUseCase = getPostsUseCase;

  /// Posts to display
  List<Post> get posts => _posts;
  
  /// Whether there are more posts to load
  bool get hasMorePosts => _hasMorePosts;
  
  /// Current page number
  int get currentPage => _currentPage;

  /// Load posts for the home feed
  Future<void> loadPosts({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _posts.clear();
      _hasMorePosts = true;
    }

    if (!_hasMorePosts || isLoading) return;

    await executeAsync(() async {
      final newPosts = await _getPostsUseCase.execute();
      
      if (refresh) {
        _posts = newPosts;
      } else {
        _posts.addAll(newPosts);
      }
      
      // In a real app, you'd check if there are more posts based on API response
      _hasMorePosts = newPosts.isNotEmpty;
      _currentPage++;
      
      logDebug('Loaded ${newPosts.length} posts. Total: ${_posts.length}');
    });
  }

  /// Refresh posts
  Future<void> refreshPosts() async {
    await loadPosts(refresh: true);
  }

  /// Load more posts (pagination)
  Future<void> loadMorePosts() async {
    await loadPosts();
  }

  /// Update a post in the list (e.g., after like/unlike)
  void updatePost(Post updatedPost) {
    final index = _posts.indexWhere((post) => post.id == updatedPost.id);
    if (index != -1) {
      _posts[index] = updatedPost;
      notifyListeners();
    }
  }

  /// Get post by ID
  Post? getPostById(String id) {
    try {
      return _posts.firstWhere((post) => post.id == id);
    } catch (e) {
      return null;
    }
  }
}
