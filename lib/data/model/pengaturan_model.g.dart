// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pengaturan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PengaturanModel _$PengaturanModelFromJson(Map<String, dynamic> json) =>
    PengaturanModel(
      json['message'] as String,
      PengaturanData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PengaturanModelToJson(PengaturanModel instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

PengaturanData _$PengaturanDataFromJson(Map<String, dynamic> json) =>
    PengaturanData(json['is_active'] as bool);

Map<String, dynamic> _$PengaturanDataToJson(PengaturanData instance) =>
    <String, dynamic>{'is_active': instance.isActive};
