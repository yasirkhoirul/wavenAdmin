// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePackageRequest _$CreatePackageRequestFromJson(
  Map<String, dynamic> json,
) => CreatePackageRequest(
  title: json['title'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toInt(),
  benefits: (json['benefits'] as List<dynamic>)
      .map((e) => CreatePackageBenefit.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CreatePackageRequestToJson(
  CreatePackageRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'price': instance.price,
  'benefits': instance.benefits,
};

CreatePackageBenefit _$CreatePackageBenefitFromJson(
  Map<String, dynamic> json,
) => CreatePackageBenefit(
  type: json['type'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$CreatePackageBenefitToJson(
  CreatePackageBenefit instance,
) => <String, dynamic>{
  'type': instance.type,
  'description': instance.description,
};

CreatePackageResponse _$CreatePackageResponseFromJson(
  Map<String, dynamic> json,
) => CreatePackageResponse(message: json['message'] as String);

Map<String, dynamic> _$CreatePackageResponseToJson(
  CreatePackageResponse instance,
) => <String, dynamic>{'message': instance.message};

DeletePackageResponse _$DeletePackageResponseFromJson(
  Map<String, dynamic> json,
) => DeletePackageResponse(message: json['message'] as String);

Map<String, dynamic> _$DeletePackageResponseToJson(
  DeletePackageResponse instance,
) => <String, dynamic>{'message': instance.message};
