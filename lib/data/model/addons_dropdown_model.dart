import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/addons_dropdown.dart';

part 'addons_dropdown_model.g.dart';

@JsonSerializable()
class AddonsDropdownResponse {
  final String message;
  final AddonsDropdownMetadata metadata;
  final List<AddonItem> data;

  AddonsDropdownResponse({
    required this.message,
    required this.metadata,
    required this.data,
  });

  factory AddonsDropdownResponse.fromJson(Map<String, dynamic> json) =>
      _$AddonsDropdownResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddonsDropdownResponseToJson(this);

  AddonsDropdown toEntity() {
    return AddonsDropdown(
      message: message,
      count: metadata.count,
      totalPages: metadata.totalPages,
      page: metadata.page,
      limit: metadata.limit,
      addons: data.map((item) => item.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class AddonsDropdownMetadata {
  final int count;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final int page;
  final int limit;

  AddonsDropdownMetadata({
    required this.count,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  factory AddonsDropdownMetadata.fromJson(Map<String, dynamic> json) =>
      _$AddonsDropdownMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$AddonsDropdownMetadataToJson(this);
}

@JsonSerializable()
class AddonItem {
  final String id;
  final String title;

  AddonItem({
    required this.id,
    required this.title,
  });

  factory AddonItem.fromJson(Map<String, dynamic> json) =>
      _$AddonItemFromJson(json);

  Map<String, dynamic> toJson() => _$AddonItemToJson(this);

  AddonDropdownItem toEntity() {
    return AddonDropdownItem(
      id: id,
      title: title,
    );
  }
}
