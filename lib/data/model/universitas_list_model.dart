import 'package:json_annotation/json_annotation.dart';

part 'universitas_list_model.g.dart';

@JsonSerializable()
class UniversitasListModel {
  final String message;
  final UniversityMetadata? metadata;
  final List<UniversityData> data;

  UniversitasListModel({
    required this.message,
    required this.metadata,
    required this.data,
  });

  factory UniversitasListModel.fromJson(Map<String, dynamic> json) =>
      _$UniversitasListModelFromJson(json);

  Map<String, dynamic> toJson() => _$UniversitasListModelToJson(this);
}

@JsonSerializable()
class UniversityMetadata {
  final int count;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final int page;
  final int limit;

  UniversityMetadata({
    required this.count,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  factory UniversityMetadata.fromJson(Map<String, dynamic> json) =>
      _$UniversityMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityMetadataToJson(this);
}

@JsonSerializable()
class UniversityData {
  final String id;
  final String name;
  @JsonKey(name: 'brief_name')
  final String briefName;
  final String address;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'created_at')
  final String createdAt;

  UniversityData({
    required this.id,
    required this.name,
    required this.briefName,
    required this.address,
    required this.isActive,
    required this.createdAt,
  });

  factory UniversityData.fromJson(Map<String, dynamic> json) =>
      _$UniversityDataFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityDataToJson(this);
}