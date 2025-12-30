import 'package:json_annotation/json_annotation.dart';

part 'create_package_model.g.dart';

@JsonSerializable()
class CreatePackageRequest {
  final String title;
  final String description;
  final int price;
  final List<CreatePackageBenefit> benefits;

  CreatePackageRequest({
    required this.title,
    required this.description,
    required this.price,
    required this.benefits,
  });

  factory CreatePackageRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePackageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePackageRequestToJson(this);
}

@JsonSerializable()
class CreatePackageBenefit {
  final String type;
  final String description;

  CreatePackageBenefit({
    required this.type,
    required this.description,
  });

  factory CreatePackageBenefit.fromJson(Map<String, dynamic> json) =>
      _$CreatePackageBenefitFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePackageBenefitToJson(this);
}

@JsonSerializable()
class CreatePackageResponse {
  final String message;

  CreatePackageResponse({
    required this.message,
  });

  factory CreatePackageResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePackageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePackageResponseToJson(this);
}

@JsonSerializable()
class DeletePackageResponse {
  final String message;

  DeletePackageResponse({
    required this.message,
  });

  factory DeletePackageResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePackageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePackageResponseToJson(this);
}
