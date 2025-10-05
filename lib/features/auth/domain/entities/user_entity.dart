import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

/// User entity representing authenticated user
@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    String? displayName,
    String? avatarUrl,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _UserEntity;
}
