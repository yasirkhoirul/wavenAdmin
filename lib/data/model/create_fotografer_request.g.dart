// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_fotografer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateFotograferRequest _$CreateFotograferRequestFromJson(
  Map<String, dynamic> json,
) => CreateFotograferRequest(
  username: json['username'] as String,
  password: json['password'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  phoneNumber: json['phone_number'] as String?,
  accountNumber: json['account_number'] as String?,
  bankAccount: json['bank_account'] as String?,
  gear: json['gear'] as String?,
  feePerHour: (json['fee_per_hour'] as num?)?.toInt(),
);

Map<String, dynamic> _$CreateFotograferRequestToJson(
  CreateFotograferRequest instance,
) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
  'email': instance.email,
  'name': instance.name,
  'phone_number': instance.phoneNumber,
  'account_number': instance.accountNumber,
  'bank_account': instance.bankAccount,
  'gear': instance.gear,
  'fee_per_hour': instance.feePerHour,
};
