// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversityDetailResponse _$UniversityDetailResponseFromJson(
  Map<String, dynamic> json,
) => UniversityDetailResponse(
  message: json['message'] as String,
  data: UniversityDetailData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UniversityDetailResponseToJson(
  UniversityDetailResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

UniversityDetailData _$UniversityDetailDataFromJson(
  Map<String, dynamic> json,
) => UniversityDetailData(
  id: json['id'] as String,
  name: json['name'] as String,
  briefName: json['brief_name'] as String,
  address: json['address'] as String,
  isActive: json['is_active'] as bool,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$UniversityDetailDataToJson(
  UniversityDetailData instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'brief_name': instance.briefName,
  'address': instance.address,
  'is_active': instance.isActive,
  'created_at': instance.createdAt,
};

UpdateUniversityRequest _$UpdateUniversityRequestFromJson(
  Map<String, dynamic> json,
) => UpdateUniversityRequest(
  name: json['name'] as String,
  briefName: json['brief_name'] as String,
  address: json['address'] as String,
  isActive: json['is_active'] as bool,
);

Map<String, dynamic> _$UpdateUniversityRequestToJson(
  UpdateUniversityRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'brief_name': instance.briefName,
  'address': instance.address,
  'is_active': instance.isActive,
};

UpdateUniversityResponse _$UpdateUniversityResponseFromJson(
  Map<String, dynamic> json,
) => UpdateUniversityResponse(message: json['message'] as String);

Map<String, dynamic> _$UpdateUniversityResponseToJson(
  UpdateUniversityResponse instance,
) => <String, dynamic>{'message': instance.message};
