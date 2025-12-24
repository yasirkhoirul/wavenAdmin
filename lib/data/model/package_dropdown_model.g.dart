// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_dropdown_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageDropdownResponse _$PackageDropdownResponseFromJson(
  Map<String, dynamic> json,
) => PackageDropdownResponse(
  message: json['message'] as String,
  metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  data: (json['data'] as List<dynamic>)
      .map((e) => PackageItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PackageDropdownResponseToJson(
  PackageDropdownResponse instance,
) => <String, dynamic>{
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

PackageItem _$PackageItemFromJson(Map<String, dynamic> json) =>
    PackageItem(id: json['id'] as String, title: json['title'] as String);

Map<String, dynamic> _$PackageItemToJson(PackageItem instance) =>
    <String, dynamic>{'id': instance.id, 'title': instance.title};
