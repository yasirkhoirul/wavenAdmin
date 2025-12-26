import 'package:json_annotation/json_annotation.dart';

part 'university_detail_model.g.dart';

@JsonSerializable()
class UniversityDetailResponse {
  final String message;
  final UniversityDetailData data;

  UniversityDetailResponse({
    required this.message,
    required this.data,
  });

  factory UniversityDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$UniversityDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityDetailResponseToJson(this);
}

@JsonSerializable()
class UniversityDetailData {
  final String id;
  final String name;
  @JsonKey(name: 'brief_name')
  final String briefName;
  final String address;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'created_at')
  final String createdAt;

  UniversityDetailData({
    required this.id,
    required this.name,
    required this.briefName,
    required this.address,
    required this.isActive,
    required this.createdAt,
  });
  

  factory UniversityDetailData.fromJson(Map<String, dynamic> json) =>
      _$UniversityDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityDetailDataToJson(this);
}

@JsonSerializable()
class UpdateUniversityRequest {
  final String name;
  @JsonKey(name: 'brief_name')
  final String briefName;
  final String address;
  @JsonKey(name: 'is_active')
  final bool isActive;

  UpdateUniversityRequest({
    required this.name,
    required this.briefName,
    required this.address,
    required this.isActive,
  });

  factory UpdateUniversityRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUniversityRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUniversityRequestToJson(this);
}

@JsonSerializable()
class UpdateUniversityResponse {
  final String message;

  UpdateUniversityResponse({required this.message});

  factory UpdateUniversityResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateUniversityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUniversityResponseToJson(this);
}
