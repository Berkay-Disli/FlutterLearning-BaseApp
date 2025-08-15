import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Base ViewModel class that all ViewModels should extend
/// Similar to Swift MVVM patterns with observable properties
abstract class BaseViewModel extends ChangeNotifier {
  final Logger _logger = Logger();
  bool _isLoading = false;
  String? _errorMessage;
  bool _disposed = false;

  /// Loading state
  bool get isLoading => _isLoading;
  
  /// Error message
  String? get errorMessage => _errorMessage;
  
  /// Whether the ViewModel has been disposed
  bool get isDisposed => _disposed;

  /// Set loading state and notify listeners
  void setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  /// Set error message and notify listeners
  void setError(String? error) {
    if (_errorMessage != error) {
      _errorMessage = error;
      notifyListeners();
    }
  }

  /// Clear error message
  void clearError() {
    setError(null);
  }

  /// Execute an async operation with loading state management
  Future<T?> executeAsync<T>(Future<T> Function() operation) async {
    try {
      setLoading(true);
      clearError();
      final result = await operation();
      return result;
    } catch (e) {
      _logger.e('Error in executeAsync: $e');
      setError(e.toString());
      return null;
    } finally {
      setLoading(false);
    }
  }

  /// Safe notify listeners that checks if disposed
  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  /// Log debug message
  void logDebug(String message) {
    _logger.d(message);
  }

  /// Log error message
  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
