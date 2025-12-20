// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListResponseAdmin _$UserListResponseAdminFromJson(
  Map<String, dynamic> json,
) => UserListResponseAdmin(
  message: json['message'] as String,
  metadata: json['metadata'] == null
      ? null
      : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserListResponseAdminToJson(
  UserListResponseAdmin instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'data': instance.data,
};
