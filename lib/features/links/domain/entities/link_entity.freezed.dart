// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'link_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LinkEntity {

 int get id; int get userId; int get directoryId; String get url; String? get title; String? get description; bool get isArchived; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of LinkEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkEntityCopyWith<LinkEntity> get copyWith => _$LinkEntityCopyWithImpl<LinkEntity>(this as LinkEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.directoryId, directoryId) || other.directoryId == directoryId)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,directoryId,url,title,description,isArchived,createdAt,updatedAt);

@override
String toString() {
  return 'LinkEntity(id: $id, userId: $userId, directoryId: $directoryId, url: $url, title: $title, description: $description, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $LinkEntityCopyWith<$Res>  {
  factory $LinkEntityCopyWith(LinkEntity value, $Res Function(LinkEntity) _then) = _$LinkEntityCopyWithImpl;
@useResult
$Res call({
 int id, int userId, int directoryId, String url, String? title, String? description, bool isArchived, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$LinkEntityCopyWithImpl<$Res>
    implements $LinkEntityCopyWith<$Res> {
  _$LinkEntityCopyWithImpl(this._self, this._then);

  final LinkEntity _self;
  final $Res Function(LinkEntity) _then;

/// Create a copy of LinkEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? directoryId = null,Object? url = null,Object? title = freezed,Object? description = freezed,Object? isArchived = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,directoryId: null == directoryId ? _self.directoryId : directoryId // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LinkEntity].
extension LinkEntityPatterns on LinkEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinkEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinkEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinkEntity value)  $default,){
final _that = this;
switch (_that) {
case _LinkEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinkEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LinkEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int userId,  int directoryId,  String url,  String? title,  String? description,  bool isArchived,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LinkEntity() when $default != null:
return $default(_that.id,_that.userId,_that.directoryId,_that.url,_that.title,_that.description,_that.isArchived,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int userId,  int directoryId,  String url,  String? title,  String? description,  bool isArchived,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _LinkEntity():
return $default(_that.id,_that.userId,_that.directoryId,_that.url,_that.title,_that.description,_that.isArchived,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int userId,  int directoryId,  String url,  String? title,  String? description,  bool isArchived,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _LinkEntity() when $default != null:
return $default(_that.id,_that.userId,_that.directoryId,_that.url,_that.title,_that.description,_that.isArchived,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _LinkEntity implements LinkEntity {
   _LinkEntity({required this.id, required this.userId, required this.directoryId, required this.url, this.title, this.description, this.isArchived = false, required this.createdAt, this.updatedAt});
  

@override final  int id;
@override final  int userId;
@override final  int directoryId;
@override final  String url;
@override final  String? title;
@override final  String? description;
@override@JsonKey() final  bool isArchived;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of LinkEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkEntityCopyWith<_LinkEntity> get copyWith => __$LinkEntityCopyWithImpl<_LinkEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.directoryId, directoryId) || other.directoryId == directoryId)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,directoryId,url,title,description,isArchived,createdAt,updatedAt);

@override
String toString() {
  return 'LinkEntity(id: $id, userId: $userId, directoryId: $directoryId, url: $url, title: $title, description: $description, isArchived: $isArchived, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$LinkEntityCopyWith<$Res> implements $LinkEntityCopyWith<$Res> {
  factory _$LinkEntityCopyWith(_LinkEntity value, $Res Function(_LinkEntity) _then) = __$LinkEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int userId, int directoryId, String url, String? title, String? description, bool isArchived, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$LinkEntityCopyWithImpl<$Res>
    implements _$LinkEntityCopyWith<$Res> {
  __$LinkEntityCopyWithImpl(this._self, this._then);

  final _LinkEntity _self;
  final $Res Function(_LinkEntity) _then;

/// Create a copy of LinkEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? directoryId = null,Object? url = null,Object? title = freezed,Object? description = freezed,Object? isArchived = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_LinkEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,directoryId: null == directoryId ? _self.directoryId : directoryId // ignore: cast_nullable_to_non_nullable
as int,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
