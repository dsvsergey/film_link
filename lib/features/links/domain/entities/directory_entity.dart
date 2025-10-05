import 'package:freezed_annotation/freezed_annotation.dart';

part 'directory_entity.freezed.dart';

@freezed
abstract class DirectoryEntity with _$DirectoryEntity {
  const factory DirectoryEntity({
    required int id,
    required int userId,
    required String name,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _DirectoryEntity;
}
