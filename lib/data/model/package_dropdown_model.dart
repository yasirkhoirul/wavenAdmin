import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/package_dropdown.dart';

part 'package_dropdown_model.g.dart';

@JsonSerializable()
class PackageDropdownResponse {
  final String message;
  final Metadata metadata;
  final List<PackageItem> data;

  PackageDropdownResponse({
    required this.message,
    required this.metadata,
    required this.data,
  });

  factory PackageDropdownResponse.fromJson(Map<String, dynamic> json) =>
      _$PackageDropdownResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDropdownResponseToJson(this);

  PackageDropdown toEntity() {
    return PackageDropdown(
      message: message,
      count: metadata.count,
      totalPages: metadata.totalPages,
      page: metadata.page,
      limit: metadata.limit,
      packages: data.map((item) => item.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class Metadata {
  final int count;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final int page;
  final int limit;

  Metadata({
    required this.count,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class PackageItem {
  final String id;
  final String title;

  PackageItem({
    required this.id,
    required this.title,
  });

  factory PackageItem.fromJson(Map<String, dynamic> json) =>
      _$PackageItemFromJson(json);

  Map<String, dynamic> toJson() => _$PackageItemToJson(this);

  Package toEntity() {
    return Package(
      id: id,
      title: title,
    );
  }
}
