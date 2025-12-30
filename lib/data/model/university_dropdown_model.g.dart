// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_dropdown_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversityDropdownResponse _$UniversityDropdownResponseFromJson(
  Map<String, dynamic> json,
) => UniversityDropdownResponse(
  message: json['message'] as String,
  metadata: json['metadata'] == null
      ? null
      : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  data: (json['data'] as List<dynamic>)
      .map((e) => UniversityItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UniversityDropdownResponseToJson(
  UniversityDropdownResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'data': instance.data,
};

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
  count: (json['count'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num?)?.toInt(),
);

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
  'count': instance.count,
  'total_pages': instance.totalPages,
  'page': instance.page,
  'limit': instance.limit,
};

UniversityItem _$UniversityItemFromJson(Map<String, dynamic> json) =>
    UniversityItem(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$UniversityItemToJson(UniversityItem instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
