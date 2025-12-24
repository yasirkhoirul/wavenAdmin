import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/detail_addons.dart';

part 'detail_addons_model.g.dart';

@JsonSerializable()
class DetailAddonsResponse {
  final String message;
  final DetailAddonsData data;

  DetailAddonsResponse({
    required this.message,
    required this.data,
  });

  factory DetailAddonsResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailAddonsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailAddonsResponseToJson(this);

  DetailAddons toEntity() {
    return DetailAddons(
      message: message,
      id: data.id,
      title: data.title,
      price: data.price,
      isActive: data.isActive,
      createdAt: data.createdAt,
    );
  }
}

@JsonSerializable()
class DetailAddonsData {
  final String id;
  final String title;
  final int price;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'created_at')
  final String createdAt;

  DetailAddonsData({
    required this.id,
    required this.title,
    required this.price,
    required this.isActive,
    required this.createdAt,
  });

  factory DetailAddonsData.fromJson(Map<String, dynamic> json) =>
      _$DetailAddonsDataFromJson(json);

  Map<String, dynamic> toJson() => _$DetailAddonsDataToJson(this);
}
