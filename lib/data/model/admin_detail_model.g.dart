// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminDetailResponse _$AdminDetailResponseFromJson(Map<String, dynamic> json) =>
    AdminDetailResponse(
      message: json['message'] as String,
      data: AdminDetailModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdminDetailResponseToJson(
  AdminDetailResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

AdminDetailModel _$AdminDetailModelFromJson(Map<String, dynamic> json) =>
    AdminDetailModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String?,
      isActive: json['is_active'] as bool,
      createdAt: _createdAtFromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$AdminDetailModelToJson(AdminDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'is_active': instance.isActive,
      'created_at': _createdAtToJson(instance.createdAt),
    };
