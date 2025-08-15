import 'package:get_it/get_it.dart';
import '../../services/api_service.dart';
import '../../features/home/data/repositories/post_repository_impl.dart';
import '../../features/home/domain/repositories/post_repository.dart';
import '../../features/home/domain/usecases/get_posts_usecase.dart';
import '../../features/home/domain/usecases/like_post_usecase.dart';
import '../../features/home/domain/usecases/retweet_post_usecase.dart';
import '../../features/home/presentation/viewmodels/home_view_model.dart';
import '../../features/home/presentation/viewmodels/post_details_view_model.dart';
import '../../models/post.dart';

/// Global service locator for dependency injection
/// Similar to Swift dependency injection containers
final GetIt serviceLocator = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // Services
  serviceLocator.registerLazySingleton<ApiService>(() => ApiService());
  
  // Repositories
  serviceLocator.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(serviceLocator<ApiService>()),
  );
  
  // Use Cases
  serviceLocator.registerLazySingleton(() => GetPostsUseCase(serviceLocator<PostRepository>()));
  serviceLocator.registerLazySingleton(() => LikePostUseCase(serviceLocator<PostRepository>()));
  serviceLocator.registerLazySingleton(() => RetweetPostUseCase(serviceLocator<PostRepository>()));
  
  // ViewModels
  serviceLocator.registerFactory(() => HomeViewModel(
    getPostsUseCase: serviceLocator<GetPostsUseCase>(),
  ));
  
  serviceLocator.registerFactoryParam<PostDetailsViewModel, Post, void>(
    (post, _) => PostDetailsViewModel(
      post: post,
      likePostUseCase: serviceLocator<LikePostUseCase>(),
      retweetPostUseCase: serviceLocator<RetweetPostUseCase>(),
    ),
  );
}
