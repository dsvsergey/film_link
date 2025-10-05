import 'package:film_link/features/links/domain/entities/link_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'link_model.freezed.dart';
part 'link_model.g.dart';

@freezed
abstract class LinkModel with _$LinkModel {
  factory LinkModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'directory_id') required int directoryId,
    required String url,
    String? title,
    String? description,
    @Default(false) @JsonKey(name: 'is_archived') bool isArchived,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _LinkModel;

  factory LinkModel.fromJson(Map<String, dynamic> json) =>
      _$LinkModelFromJson(json);
}

extension LinkModelToEntity on LinkModel {
  LinkEntity toEntity() {
    return LinkEntity(
      id: id,
      userId: userId,
      directoryId: directoryId,
      url: url,
      title: title,
      description: description,
      isArchived: isArchived,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension LinkEntityToModel on LinkEntity {
  LinkModel toModel() {
    return LinkModel(
      id: id,
      userId: userId,
      directoryId: directoryId,
      url: url,
      title: title,
      description: description,
      isArchived: isArchived,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
