// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_photographer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFotograferListResponse _$UserFotograferListResponseFromJson(
  Map<String, dynamic> json,
) => UserFotograferListResponse(
  message: json['message'] as String,
  metadata: json['metadata'] == null
      ? null
      : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => UserPhotographerModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserFotograferListResponseToJson(
  UserFotograferListResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'data': instance.data,
};

UserPhotographerModel _$UserPhotographerModelFromJson(
  Map<String, dynamic> json,
) => UserPhotographerModel(
  id: json['id'] as String,
  name: json['name'] as String,
  phoneNumber: json['phone_number'] as String?,
  accountNumber: json['account_number'] as String?,
  bankAccount: json['bank_account'] as String?,
  feePerHour: (json['fee_per_hour'] as num?)?.toInt(),
  gears: json['gear'] as String?,
  instagram: json['instagram'] as String?,
  location: json['location'] as String?,
  isActive: json['is_active'] as bool,
);

Map<String, dynamic> _$UserPhotographerModelToJson(
  UserPhotographerModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone_number': instance.phoneNumber,
  'account_number': instance.accountNumber,
  'bank_account': instance.bankAccount,
  'fee_per_hour': instance.feePerHour,
  'is_active': instance.isActive,
  'gear': instance.gears,
  'instagram': instance.instagram,
  'location': instance.location,
};
