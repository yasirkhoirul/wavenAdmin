import 'package:json_annotation/json_annotation.dart';

part 'package_detail_model.g.dart';

@JsonSerializable()
class PackageDetailResponse {
  final String message;
  final PackageDetailData data;

  PackageDetailResponse({
    required this.message,
    required this.data,
  });

  factory PackageDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PackageDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDetailResponseToJson(this);
}

@JsonSerializable()
class PackageDetailData {
  final String id;
  final String title;
  final int price;
  
  @JsonKey(name: 'banner_url')
  final String bannerUrl;
  
  final String description;
  
  @JsonKey(name: 'is_active')
  final bool isActive;
  
  @JsonKey(name: 'created_at')
  final String createdAt;
  
  final List<PackageBenefit> benefits;

  PackageDetailData({
    required this.id,
    required this.title,
    required this.price,
    required this.bannerUrl,
    required this.description,
    required this.isActive,
    required this.createdAt,
    required this.benefits,
  });

  factory PackageDetailData.fromJson(Map<String, dynamic> json) =>
      _$PackageDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDetailDataToJson(this);
}

@JsonSerializable()
class PackageBenefit {
  final String id;
  final String description;
  final String type;

  PackageBenefit({
    required this.id,
    required this.description,
    required this.type,
  });

  factory PackageBenefit.fromJson(Map<String, dynamic> json) =>
      _$PackageBenefitFromJson(json);

  Map<String, dynamic> toJson() => _$PackageBenefitToJson(this);
}
