// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) =>
    UpdateUserRequest(
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      universityId: json['university_id'] as String?,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$UpdateUserRequestToJson(UpdateUserRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'university_id': instance.universityId,
      'is_active': instance.isActive,
    };

UpdateUserResponse _$UpdateUserResponseFromJson(Map<String, dynamic> json) =>
    UpdateUserResponse(message: json['message'] as String);

Map<String, dynamic> _$UpdateUserResponseToJson(UpdateUserResponse instance) =>
    <String, dynamic>{'message': instance.message};
