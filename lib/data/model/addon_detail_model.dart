import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/addon_detail.dart';

part 'addon_detail_model.g.dart';

@JsonSerializable()
class AddonDetailResponse {
  final String message;
  final AddonDetailData data;

  const AddonDetailResponse({
    required this.message,
    required this.data,
  });

  factory AddonDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$AddonDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddonDetailResponseToJson(this);

  AddonDetail toEntity() {
    return data.toEntity();
  }
}

@JsonSerializable()
class AddonDetailData {
  final String id;
  final String title;
  final int price;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'created_at')
  final String createdAt;

  const AddonDetailData({
    required this.id,
    required this.title,
    required this.price,
    required this.isActive,
    required this.createdAt,
  });

  factory AddonDetailData.fromJson(Map<String, dynamic> json) =>
      _$AddonDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddonDetailDataToJson(this);

  AddonDetail toEntity() {
    return AddonDetail(
      id: id,
      title: title,
      price: price,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}

@JsonSerializable()
class UpdateAddonRequest {
  final String title;
  final int price;
  @JsonKey(name: 'is_active')
  final bool isActive;

  const UpdateAddonRequest({
    required this.title,
    required this.price,
    required this.isActive,
  });

  factory UpdateAddonRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateAddonRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAddonRequestToJson(this);
}

@JsonSerializable()
class CreateAddonRequest {
  final String title;
  final int price;

  const CreateAddonRequest({
    required this.title,
    required this.price,
  });

  factory CreateAddonRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAddonRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAddonRequestToJson(this);
}

@JsonSerializable()
class CreateAddonResponse {
  final String message;

  const CreateAddonResponse({
    required this.message,
  });

  factory CreateAddonResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAddonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAddonResponseToJson(this);
}

@JsonSerializable()
class DeleteAddonResponse {
  final String message;

  const DeleteAddonResponse({
    required this.message,
  });

  factory DeleteAddonResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteAddonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteAddonResponseToJson(this);
}
