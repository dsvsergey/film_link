import 'package:freezed_annotation/freezed_annotation.dart';

part 'link_entity.freezed.dart';

@freezed
abstract class LinkEntity with _$LinkEntity {
  factory LinkEntity({
    required int id,
    required int userId,
    required int directoryId,
    required String url,
    String? title,
    String? description,
    @Default(false) bool isArchived,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _LinkEntity;
}
