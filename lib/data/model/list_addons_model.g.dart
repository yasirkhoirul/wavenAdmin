// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_addons_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAddonsResponse _$ListAddonsResponseFromJson(Map<String, dynamic> json) =>
    ListAddonsResponse(
      message: json['message'] as String,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map((e) => AddonItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListAddonsResponseToJson(ListAddonsResponse instance) =>
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

AddonItem _$AddonItemFromJson(Map<String, dynamic> json) => AddonItem(
  id: json['id'] as String,
  title: json['title'] as String,
  price: (json['price'] as num).toInt(),
  isActive: json['is_active'] as bool,
);

Map<String, dynamic> _$AddonItemToJson(AddonItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'price': instance.price,
  'is_active': instance.isActive,
};
