import 'package:film_link/core/constants/storage_keys.dart';
import 'package:film_link/core/error/exceptions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Local data source for authentication tokens
abstract class AuthLocalDataSource {
  Future<void> saveAccessToken(String token);
  Future<void> saveRefreshToken(String token);
  Future<void> saveUserId(String userId);
  Future<void> saveUserEmail(String email);
  
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<String?> getUserId();
  Future<String?> getUserEmail();
  
  Future<void> clearTokens();
}

/// Implementation of AuthLocalDataSource using FlutterSecureStorage
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  
  AuthLocalDataSourceImpl({required this.secureStorage});
  
  @override
  Future<void> saveAccessToken(String token) async {
    try {
      await secureStorage.write(key: StorageKeys.accessToken, value: token);
    } catch (e) {
      throw CacheException('Failed to save access token: ${e.toString()}');
    }
  }
  
  @override
  Future<void> saveRefreshToken(String token) async {
    try {
      await secureStorage.write(key: StorageKeys.refreshToken, value: token);
    } catch (e) {
      throw CacheException('Failed to save refresh token: ${e.toString()}');
    }
  }
  
  @override
  Future<void> saveUserId(String userId) async {
    try {
      await secureStorage.write(key: StorageKeys.userId, value: userId);
    } catch (e) {
      throw CacheException('Failed to save user ID: ${e.toString()}');
    }
  }
  
  @override
  Future<void> saveUserEmail(String email) async {
    try {
      await secureStorage.write(key: StorageKeys.userEmail, value: email);
    } catch (e) {
      throw CacheException('Failed to save user email: ${e.toString()}');
    }
  }
  
  @override
  Future<String?> getAccessToken() async {
    try {
      return await secureStorage.read(key: StorageKeys.accessToken);
    } catch (e) {
      throw CacheException('Failed to get access token: ${e.toString()}');
    }
  }
  
  @override
  Future<String?> getRefreshToken() async {
    try {
      return await secureStorage.read(key: StorageKeys.refreshToken);
    } catch (e) {
      throw CacheException('Failed to get refresh token: ${e.toString()}');
    }
  }
  
  @override
  Future<String?> getUserId() async {
    try {
      return await secureStorage.read(key: StorageKeys.userId);
    } catch (e) {
      throw CacheException('Failed to get user ID: ${e.toString()}');
    }
  }
  
  @override
  Future<String?> getUserEmail() async {
    try {
      return await secureStorage.read(key: StorageKeys.userEmail);
    } catch (e) {
      throw CacheException('Failed to get user email: ${e.toString()}');
    }
  }
  
  @override
  Future<void> clearTokens() async {
    try {
      await Future.wait([
        secureStorage.delete(key: StorageKeys.accessToken),
        secureStorage.delete(key: StorageKeys.refreshToken),
        secureStorage.delete(key: StorageKeys.userId),
        secureStorage.delete(key: StorageKeys.userEmail),
      ]);
    } catch (e) {
      throw CacheException('Failed to clear tokens: ${e.toString()}');
    }
  }
}
