// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DirectoryModel _$DirectoryModelFromJson(Map<String, dynamic> json) =>
    _DirectoryModel(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DirectoryModelToJson(_DirectoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
