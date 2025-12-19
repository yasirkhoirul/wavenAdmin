// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detial_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailResponse _$UserDetailResponseFromJson(Map<String, dynamic> json) =>
    UserDetailResponse(
      message: json['message'] as String,
      data: UserDetailModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDetailResponseToJson(UserDetailResponse instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

UserDetailModel _$UserDetailModelFromJson(Map<String, dynamic> json) =>
    UserDetailModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String?,
      universityName: json['university_name'] as String?,
      universityBriefName: json['university_brief_name'] as String?,
      createdAt: _createdAtFromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$UserDetailModelToJson(UserDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'university_name': instance.universityName,
      'university_brief_name': instance.universityBriefName,
      'created_at': _createdAtToJson(instance.createdAt),
    };
