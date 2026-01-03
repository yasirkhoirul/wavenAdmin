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


PengaturanData _$PengaturanDataFromJson(Map<String, dynamic> json) =>
    PengaturanData(json['is_active'] as bool);

