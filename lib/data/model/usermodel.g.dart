// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListResponse _$UserListResponseFromJson(Map<String, dynamic> json) =>
    UserListResponse(
      message: json['message'] as String,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      data:json['data'] is! List? json['data'] == null
          ? null
          : UserDataWrapper.fromJson(json['data'] as Map<String, dynamic>):UserDataWrapper(totalUser: 0, activeUser: 0, listUser: []),
    );

Map<String, dynamic> _$UserListResponseToJson(UserListResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'data': instance.data,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
  count: (json['count'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
  'count': instance.count,
  'total_pages': instance.totalPages,
  'page': instance.page,
  'limit': instance.limit,
};

UserDataWrapper _$UserDataWrapperFromJson(Map<String, dynamic> json) =>
    UserDataWrapper(
      totalUser: (json['total_user'] as num).toInt(),
      activeUser: (json['active_user'] as num).toInt(),
      listUser: (json['data'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserDataWrapperToJson(UserDataWrapper instance) =>
    <String, dynamic>{
      'total_user': instance.totalUser,
      'active_user': instance.activeUser,
      'data': instance.listUser,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  username: json['username'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  isActive: json['is_active'] as bool,
  phoneNumber: json['phone_number'] as String?,
  universityName: json['university_name'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'name': instance.name,
  'email': instance.email,
  'is_active': instance.isActive,
  'phone_number': instance.phoneNumber,
  'university_name': instance.universityName,
};
