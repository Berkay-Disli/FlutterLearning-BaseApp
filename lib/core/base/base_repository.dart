/// Base repository interface for data operations
/// Similar to Swift protocol-based repositories
abstract class BaseRepository<T> {
  /// Get all items
  Future<List<T>> getAll();
  
  /// Get item by ID
  Future<T?> getById(String id);
  
  /// Create new item
  Future<T> create(T item);
  
  /// Update existing item
  Future<T> update(T item);
  
  /// Delete item by ID
  Future<bool> delete(String id);
}

/// Repository interface for search operations
abstract class SearchableRepository<T> extends BaseRepository<T> {
  /// Search items by query
  Future<List<T>> search(String query);
}

/// Repository interface for pagination
abstract class PaginatedRepository<T> extends BaseRepository<T> {
  /// Get items with pagination
  Future<List<T>> getPaginated({int page = 1, int limit = 20});
}
