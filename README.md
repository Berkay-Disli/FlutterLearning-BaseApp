# Flutter MVVM Architecture

This Flutter app follows the MVVM (Model-View-ViewModel) architecture pattern, similar to Swift MVVM practices.

## Architecture Overview

### 📁 Project Structure

```
lib/
├── core/
│   ├── base/
│   │   ├── base_view_model.dart      # Base ViewModel class
│   │   └── base_repository.dart      # Base repository interfaces
│   ├── di/
│   │   └── service_locator.dart      # Dependency injection setup
│   ├── constants/
│   ├── theme/
│   └── utils/
├── features/
│   └── home/
│       ├── data/
│       │   └── repositories/
│       │       └── post_repository_impl.dart
│       ├── domain/
│       │   ├── repositories/
│       │   │   └── post_repository.dart
│       │   └── usecases/
│       │       ├── get_posts_usecase.dart
│       │       ├── like_post_usecase.dart
│       │       └── retweet_post_usecase.dart
│       └── presentation/
│           ├── pages/
│           │   ├── home_page.dart
│           │   └── post_details_screen.dart
│           ├── viewmodels/
│           │   ├── home_view_model.dart
│           │   └── post_details_view_model.dart
│           └── widgets/
│               └── post_row.dart
├── models/
│   └── post.dart
├── services/
│   └── api_service.dart
└── main.dart
```

## 🏗️ Architecture Layers

### 1. **Presentation Layer** (UI)
- **Pages**: Flutter widgets that represent screens
- **ViewModels**: Business logic and state management
- **Widgets**: Reusable UI components

### 2. **Domain Layer** (Business Logic)
- **Use Cases**: Single responsibility business operations
- **Repository Interfaces**: Contracts for data operations

### 3. **Data Layer** (Data Management)
- **Repository Implementations**: Concrete data access logic
- **Services**: External API calls and data sources

## 🔧 Key Components

### BaseViewModel
```dart
abstract class BaseViewModel extends ChangeNotifier {
  bool get isLoading;
  String? get errorMessage;
  
  void setLoading(bool loading);
  void setError(String? error);
  Future<T?> executeAsync<T>(Future<T> Function() operation);
}
```

### Repository Pattern
```dart
abstract class PostRepository extends SearchableRepository<Post> {
  Future<List<Post>> getHomePosts();
  Future<Post> likePost(String postId);
  Future<Post> retweetPost(String postId);
}
```

### Use Cases
```dart
class GetPostsUseCase {
  final PostRepository _repository;
  
  Future<List<Post>> execute() async {
    return await _repository.getHomePosts();
  }
}
```

## 🚀 Dependency Injection

Using **GetIt** for dependency injection:

```dart
final GetIt serviceLocator = GetIt.instance;

// Register dependencies
serviceLocator.registerLazySingleton<PostRepository>(
  () => PostRepositoryImpl(serviceLocator<ApiService>()),
);

serviceLocator.registerFactory(() => HomeViewModel(
  getPostsUseCase: serviceLocator<GetPostsUseCase>(),
));
```

## 📱 State Management

Using **Provider** for reactive state management:

```dart
Consumer<HomeViewModel>(
  builder: (context, viewModel, child) {
    return ListView.builder(
      itemCount: viewModel.posts.length,
      itemBuilder: (context, index) {
        return PostRow(post: viewModel.posts[index]);
      },
    );
  },
)
```

## 🔄 Data Flow

1. **UI** → **ViewModel**: User interactions trigger ViewModel methods
2. **ViewModel** → **Use Case**: ViewModel calls Use Cases for business logic
3. **Use Case** → **Repository**: Use Cases interact with repositories
4. **Repository** → **Service**: Repositories use services for data access
5. **Service** → **API**: Services make HTTP calls to external APIs

## 🎯 Benefits

- **Separation of Concerns**: Clear boundaries between UI, business logic, and data
- **Testability**: Each layer can be tested independently
- **Maintainability**: Easy to modify and extend
- **Reusability**: Components can be reused across features
- **Scalability**: Easy to add new features following the same pattern

## 🧪 Testing Strategy

- **Unit Tests**: ViewModels, Use Cases, Repositories
- **Widget Tests**: UI components
- **Integration Tests**: End-to-end user flows

## 📦 Dependencies

- `provider`: State management
- `get_it`: Dependency injection
- `rxdart`: Reactive programming
- `logger`: Logging
- `http`: API calls

## 🔄 Migration from Previous Architecture

The app has been refactored from a simple widget-based approach to a proper MVVM architecture:

- ✅ Removed business logic from UI widgets
- ✅ Introduced ViewModels for state management
- ✅ Implemented repository pattern for data access
- ✅ Added use cases for business operations
- ✅ Set up dependency injection
- ✅ Added proper error handling and loading states
