// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'universitas_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversitasListModel _$UniversitasListModelFromJson(
  Map<String, dynamic> json,
) => UniversitasListModel(
  message: json['message'] as String,
  metadata: json['metadata'] == null
      ? null
      : UniversityMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
  data: (json['data'] as List<dynamic>)
      .map((e) => UniversityData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UniversitasListModelToJson(
  UniversitasListModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'data': instance.data,
};

UniversityMetadata _$UniversityMetadataFromJson(Map<String, dynamic> json) =>
    UniversityMetadata(
      count: (json['count'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$UniversityMetadataToJson(UniversityMetadata instance) =>
    <String, dynamic>{
      'count': instance.count,
      'total_pages': instance.totalPages,
      'page': instance.page,
      'limit': instance.limit,
    };

UniversityData _$UniversityDataFromJson(Map<String, dynamic> json) =>
    UniversityData(
      id: json['id'] as String,
      name: json['name'] as String,
      briefName: json['brief_name'] as String,
      address: json['address'] as String,
      isActive: json['is_active'] as bool,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$UniversityDataToJson(UniversityData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brief_name': instance.briefName,
      'address': instance.address,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
    };
