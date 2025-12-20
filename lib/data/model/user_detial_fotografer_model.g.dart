// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detial_fotografer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailFotograferResponse _$UserDetailFotograferResponseFromJson(
  Map<String, dynamic> json,
) => UserDetailFotograferResponse(
  message: json['message'] as String,
  data: UserDetailFotograferModel.fromJson(
    json['data'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$UserDetailFotograferResponseToJson(
  UserDetailFotograferResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

UserDetailFotograferModel _$UserDetailFotograferModelFromJson(
  Map<String, dynamic> json,
) => UserDetailFotograferModel(
  id: json['id'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  phoneNumber: json['phone_number'] as String?,
  accountNumber: json['account_number'] as String?,
  bankAccount: json['bank_account'] as String?,
  isActive: json['is_active'] as bool,
  gear: json['gear'] as String?,
  feePerHour: (json['fee_per_hour'] as num?)?.toInt(),
  createdAt: _createdAtFromJson(json['created_at'] as String),
);

Map<String, dynamic> _$UserDetailFotograferModelToJson(
  UserDetailFotograferModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'name': instance.name,
  'phone_number': instance.phoneNumber,
  'account_number': instance.accountNumber,
  'bank_account': instance.bankAccount,
  'is_active': instance.isActive,
  'gear': instance.gear,
  'fee_per_hour': instance.feePerHour,
  'created_at': _createdAtToJson(instance.createdAt),
};
