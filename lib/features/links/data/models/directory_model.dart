import 'package:film_link/features/links/domain/entities/directory_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'directory_model.freezed.dart';
part 'directory_model.g.dart';

@freezed
abstract class DirectoryModel with _$DirectoryModel {
  const factory DirectoryModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    required String name,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _DirectoryModel;

  factory DirectoryModel.fromJson(Map<String, dynamic> json) =>
      _$DirectoryModelFromJson(json);
}

extension DirectoryModelToEntity on DirectoryModel {
  DirectoryEntity toEntity() {
    return DirectoryEntity(
      id: id,
      userId: userId,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension DirectoryEntityToModel on DirectoryEntity {
  DirectoryModel toModel() {
    return DirectoryModel(
      id: id,
      userId: userId,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
