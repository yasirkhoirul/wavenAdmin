import 'package:json_annotation/json_annotation.dart';

part 'package_list_model.g.dart';

@JsonSerializable()
class PackageListModel {
  final String message;
  final PackageMetadata? metadata;
  final List<PackageData> data;

  PackageListModel({
    required this.message,
    required this.metadata,
    required this.data,
  });

  factory PackageListModel.fromJson(Map<String, dynamic> json) =>
      _$PackageListModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackageListModelToJson(this);
}

@JsonSerializable()
class PackageMetadata {
  final int count;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final int page;
  final int limit;

  PackageMetadata({
    required this.count,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  factory PackageMetadata.fromJson(Map<String, dynamic> json) =>
      _$PackageMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$PackageMetadataToJson(this);
}

@JsonSerializable()
class PackageData {
  final String id;
  final String title;
  final int price;
  @JsonKey(name: 'banner_url')
  final String bannerUrl;
  final String description;
  final dynamic benefits;

  PackageData({
    required this.id,
    required this.title,
    required this.price,
    required this.bannerUrl,
    required this.description,
    this.benefits,
  });

  factory PackageData.fromJson(Map<String, dynamic> json) =>
      _$PackageDataFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDataToJson(this);
}
