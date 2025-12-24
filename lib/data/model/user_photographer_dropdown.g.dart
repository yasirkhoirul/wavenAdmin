// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_photographer_dropdown.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotographerDropdownResponse _$PhotographerDropdownResponseFromJson(
  Map<String, dynamic> json,
) => PhotographerDropdownResponse(
  message: json['message'] as String,
  metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  data: (json['data'] as List<dynamic>)
      .map((e) => PhotographerItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PhotographerDropdownResponseToJson(
  PhotographerDropdownResponse instance,
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

PhotographerItem _$PhotographerItemFromJson(Map<String, dynamic> json) =>
    PhotographerItem(
      id: json['id'] as String,
      name: json['name'] as String,
      feePerHour: (json['fee_per_hour'] as num).toInt(),
    );

Map<String, dynamic> _$PhotographerItemToJson(PhotographerItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fee_per_hour': instance.feePerHour,
    };
