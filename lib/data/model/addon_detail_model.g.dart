// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addon_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddonDetailResponse _$AddonDetailResponseFromJson(Map<String, dynamic> json) =>
    AddonDetailResponse(
      message: json['message'] as String,
      data: AddonDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddonDetailResponseToJson(
  AddonDetailResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

AddonDetailData _$AddonDetailDataFromJson(Map<String, dynamic> json) =>
    AddonDetailData(
      id: json['id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toInt(),
      isActive: json['is_active'] as bool,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$AddonDetailDataToJson(AddonDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
    };

UpdateAddonRequest _$UpdateAddonRequestFromJson(Map<String, dynamic> json) =>
    UpdateAddonRequest(
      title: json['title'] as String,
      price: (json['price'] as num).toInt(),
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$UpdateAddonRequestToJson(UpdateAddonRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'price': instance.price,
      'is_active': instance.isActive,
    };

CreateAddonRequest _$CreateAddonRequestFromJson(Map<String, dynamic> json) =>
    CreateAddonRequest(
      title: json['title'] as String,
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$CreateAddonRequestToJson(CreateAddonRequest instance) =>
    <String, dynamic>{'title': instance.title, 'price': instance.price};

CreateAddonResponse _$CreateAddonResponseFromJson(Map<String, dynamic> json) =>
    CreateAddonResponse(message: json['message'] as String);

Map<String, dynamic> _$CreateAddonResponseToJson(
  CreateAddonResponse instance,
) => <String, dynamic>{'message': instance.message};

DeleteAddonResponse _$DeleteAddonResponseFromJson(Map<String, dynamic> json) =>
    DeleteAddonResponse(message: json['message'] as String);

Map<String, dynamic> _$DeleteAddonResponseToJson(
  DeleteAddonResponse instance,
) => <String, dynamic>{'message': instance.message};
