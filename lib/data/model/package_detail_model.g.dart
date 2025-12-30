// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageDetailResponse _$PackageDetailResponseFromJson(
  Map<String, dynamic> json,
) => PackageDetailResponse(
  message: json['message'] as String,
  data: PackageDetailData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PackageDetailResponseToJson(
  PackageDetailResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

PackageDetailData _$PackageDetailDataFromJson(Map<String, dynamic> json) =>
    PackageDetailData(
      id: json['id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toInt(),
      bannerUrl: json['banner_url'] as String,
      description: json['description'] as String,
      isActive: json['is_active'] as bool,
      createdAt: json['created_at'] as String,
      benefits: (json['benefits'] as List<dynamic>)
          .map((e) => PackageBenefit.fromJson(e as Map<String, dynamic>))
          .toList(),
      gambarDetail: (json['gambarDetail'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$PackageDetailDataToJson(PackageDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'gambarDetail': instance.gambarDetail,
      'banner_url': instance.bannerUrl,
      'description': instance.description,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'benefits': instance.benefits,
    };

PackageBenefit _$PackageBenefitFromJson(Map<String, dynamic> json) =>
    PackageBenefit(
      id: json['id'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$PackageBenefitToJson(PackageBenefit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'type': instance.type,
    };
