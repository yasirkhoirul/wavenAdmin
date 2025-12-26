// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageListModel _$PackageListModelFromJson(Map<String, dynamic> json) =>
    PackageListModel(
      message: json['message'] as String,
      metadata: PackageMetadata.fromJson(
        json['metadata'] as Map<String, dynamic>,
      ),
      data: (json['data'] as List<dynamic>)
          .map((e) => PackageData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageListModelToJson(PackageListModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'data': instance.data,
    };

PackageMetadata _$PackageMetadataFromJson(Map<String, dynamic> json) =>
    PackageMetadata(
      count: (json['count'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$PackageMetadataToJson(PackageMetadata instance) =>
    <String, dynamic>{
      'count': instance.count,
      'total_pages': instance.totalPages,
      'page': instance.page,
      'limit': instance.limit,
    };

PackageData _$PackageDataFromJson(Map<String, dynamic> json) => PackageData(
  id: json['id'] as String,
  title: json['title'] as String,
  price: (json['price'] as num).toInt(),
  bannerUrl: json['banner_url'] as String,
  description: json['description'] as String,
  benefits: json['benefits'],
);

Map<String, dynamic> _$PackageDataToJson(PackageData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'banner_url': instance.bannerUrl,
      'description': instance.description,
      'benefits': instance.benefits,
    };
