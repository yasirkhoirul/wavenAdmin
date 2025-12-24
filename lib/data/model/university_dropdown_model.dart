import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/university_dropdown.dart';

part 'university_dropdown_model.g.dart';

@JsonSerializable()
class UniversityDropdownResponse {
  final String message;
  final Metadata metadata;
  final List<UniversityItem> data;

  UniversityDropdownResponse({
    required this.message,
    required this.metadata,
    required this.data,
  });

  factory UniversityDropdownResponse.fromJson(Map<String, dynamic> json) =>
      _$UniversityDropdownResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityDropdownResponseToJson(this);

  UniversityDropdown toEntity() {
    return UniversityDropdown(
      message: message,
      count: metadata.count,
      totalPages: metadata.totalPages,
      page: metadata.page,
      limit: metadata.limit,
      universities: data.map((item) => item.toEntity()).toList(),
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
class UniversityItem {
  final String id;
  final String name;

  UniversityItem({
    required this.id,
    required this.name,
  });

  factory UniversityItem.fromJson(Map<String, dynamic> json) =>
      _$UniversityItemFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityItemToJson(this);

  University toEntity() {
    return University(
      id: id,
      name: name,
    );
  }
}
