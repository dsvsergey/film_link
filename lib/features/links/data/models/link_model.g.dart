// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LinkModel _$LinkModelFromJson(Map<String, dynamic> json) => _LinkModel(
  id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  directoryId: (json['directory_id'] as num).toInt(),
  url: json['url'] as String,
  title: json['title'] as String?,
  description: json['description'] as String?,
  isArchived: json['is_archived'] as bool? ?? false,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$LinkModelToJson(_LinkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'directory_id': instance.directoryId,
      'url': instance.url,
      'title': instance.title,
      'description': instance.description,
      'is_archived': instance.isArchived,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
