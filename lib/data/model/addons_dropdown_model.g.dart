// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addons_dropdown_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddonsDropdownResponse _$AddonsDropdownResponseFromJson(
  Map<String, dynamic> json,
) => AddonsDropdownResponse(
  message: json['message'] as String,
  metadata: AddonsDropdownMetadata.fromJson(
    json['metadata'] as Map<String, dynamic>,
  ),
  data: (json['data'] as List<dynamic>)
      .map((e) => AddonItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AddonsDropdownResponseToJson(
  AddonsDropdownResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'data': instance.data,
};

AddonsDropdownMetadata _$AddonsDropdownMetadataFromJson(
  Map<String, dynamic> json,
) => AddonsDropdownMetadata(
  count: (json['count'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$AddonsDropdownMetadataToJson(
  AddonsDropdownMetadata instance,
) => <String, dynamic>{
  'count': instance.count,
  'total_pages': instance.totalPages,
  'page': instance.page,
  'limit': instance.limit,
};

AddonItem _$AddonItemFromJson(Map<String, dynamic> json) =>
    AddonItem(id: json['id'] as String, title: json['title'] as String);

Map<String, dynamic> _$AddonItemToJson(AddonItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
};
