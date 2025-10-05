/// Base class for all exceptions in the application
class AppException implements Exception {
  final String message;
  
  const AppException(this.message);
  
  @override
  String toString() => message;
}

/// Server-related exceptions
class ServerException extends AppException {
  const ServerException([super.message = 'Server error occurred']);
}

/// Cache-related exceptions
class CacheException extends AppException {
  const CacheException([super.message = 'Cache error occurred']);
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException([super.message = 'Network error occurred']);
}

/// Authentication-related exceptions
class AuthException extends AppException {
  const AuthException([super.message = 'Authentication error occurred']);
}

/// Validation-related exceptions
class ValidationException extends AppException {
  const ValidationException([super.message = 'Validation error occurred']);
}

/// Not found exceptions
class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Resource not found']);
}
