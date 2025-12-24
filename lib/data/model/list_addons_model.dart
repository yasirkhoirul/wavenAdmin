import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/list_addons.dart';

part 'list_addons_model.g.dart';

@JsonSerializable()
class ListAddonsResponse {
  final String message;
  final Metadata metadata;
  final List<AddonItem> data;

  ListAddonsResponse({
    required this.message,
    required this.metadata,
    required this.data,
  });

  factory ListAddonsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListAddonsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListAddonsResponseToJson(this);

  ListAddons toEntity() {
    return ListAddons(
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
class AddonItem {
  final String id;
  final String title;
  final int price;
  @JsonKey(name: 'is_active')
  final bool isActive;

  AddonItem({
    required this.id,
    required this.title,
    required this.price,
    required this.isActive,
  });

  factory AddonItem.fromJson(Map<String, dynamic> json) =>
      _$AddonItemFromJson(json);

  Map<String, dynamic> toJson() => _$AddonItemToJson(this);

  Addon toEntity() {
    return Addon(
      id: id,
      title: title,
      price: price,
      isActive: isActive,
    );
  }
}
