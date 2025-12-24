// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_addons_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailAddonsResponse _$DetailAddonsResponseFromJson(
  Map<String, dynamic> json,
) => DetailAddonsResponse(
  message: json['message'] as String,
  data: DetailAddonsData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DetailAddonsResponseToJson(
  DetailAddonsResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

DetailAddonsData _$DetailAddonsDataFromJson(Map<String, dynamic> json) =>
    DetailAddonsData(
      id: json['id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toInt(),
      isActive: json['is_active'] as bool,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$DetailAddonsDataToJson(DetailAddonsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
    };
