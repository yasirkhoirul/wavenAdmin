

import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/pnegaturan.dart';

part 'pengaturan_model.g.dart';

@JsonSerializable()
class PengaturanModel {
  final String message;
  final PengaturanData data;
  const PengaturanModel(this.message,this.data);
  factory PengaturanModel.fromJson(Map<String,dynamic> json)=> _$PengaturanModelFromJson(json);
}

@JsonSerializable()
class PengaturanData{
  @JsonKey(name: "is_active")
  final bool isActive;
  const PengaturanData(this.isActive);
  
  factory PengaturanData.fromJson(Map<String,dynamic> json) => _$PengaturanDataFromJson(json);
  Pengaturan toEntity(){
    return Pengaturan(isActive);
  }
}