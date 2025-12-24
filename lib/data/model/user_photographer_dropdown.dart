import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/photographer_dropdown.dart';

part 'user_photographer_dropdown.g.dart';

@JsonSerializable()
class PhotographerDropdownResponse {
  final String message;
  final Metadata metadata;
  final List<PhotographerItem> data;

  PhotographerDropdownResponse({
    required this.message,
    required this.metadata,
    required this.data,
  });

  factory PhotographerDropdownResponse.fromJson(Map<String, dynamic> json) =>
      _$PhotographerDropdownResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhotographerDropdownResponseToJson(this);

  PhotographerDropdown toEntity() {
    return PhotographerDropdown(
      message: message,
      count: metadata.count,
      totalPages: metadata.totalPages,
      page: metadata.page,
      limit: metadata.limit,
      photographers: data.map((item) => item.toEntity()).toList(),
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
class PhotographerItem {
  final String id;
  final String name;
  @JsonKey(name: 'fee_per_hour')
  final int feePerHour;

  PhotographerItem({
    required this.id,
    required this.name,
    required this.feePerHour,
  });

  factory PhotographerItem.fromJson(Map<String, dynamic> json) =>
      _$PhotographerItemFromJson(json);

  Map<String, dynamic> toJson() => _$PhotographerItemToJson(this);

  PhotographerDropdownItem toEntity() {
    return PhotographerDropdownItem(
      id: id,
      name: name,
      feePerHour: feePerHour,
    );
  }
}
