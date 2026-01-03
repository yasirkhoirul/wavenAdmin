// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'porto_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortoListResponse _$PortoListResponseFromJson(Map<String, dynamic> json) =>
    PortoListResponse(
      message: json['message'] as String,
      metadata: json['metadata'] == null
          ? null
          : PortoMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map((e) => PortoData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PortoListResponseToJson(PortoListResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'data': instance.data,
    };

PortoMetadata _$PortoMetadataFromJson(Map<String, dynamic> json) =>
    PortoMetadata(
      count: (json['count'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$PortoMetadataToJson(PortoMetadata instance) =>
    <String, dynamic>{
      'count': instance.count,
      'page': instance.page,
      'limit': instance.limit,
    };

PortoData _$PortoDataFromJson(Map<String, dynamic> json) =>
    PortoData(id: json['id'] as String, url: json['url'] as String);

Map<String, dynamic> _$PortoDataToJson(PortoData instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
};
