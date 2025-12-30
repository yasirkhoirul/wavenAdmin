// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photographer_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotographerDetailResponse _$PhotographerDetailResponseFromJson(
  Map<String, dynamic> json,
) => PhotographerDetailResponse(
  message: json['message'] as String,
  data: PhotographerDetailData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PhotographerDetailResponseToJson(
  PhotographerDetailResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

PhotographerDetailData _$PhotographerDetailDataFromJson(
  Map<String, dynamic> json,
) => PhotographerDetailData(
  photographerData: PhotographerDataModel.fromJson(
    json['photographer_data'] as Map<String, dynamic>,
  ),
  paymentData: PaymentDataModel.fromJson(
    json['payment_data'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PhotographerDetailDataToJson(
  PhotographerDetailData instance,
) => <String, dynamic>{
  'photographer_data': instance.photographerData,
  'payment_data': instance.paymentData,
};

PhotographerDataModel _$PhotographerDataModelFromJson(
  Map<String, dynamic> json,
) => PhotographerDataModel(
  id: json['id'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  phoneNumber: json['phone_number'] as String,
  bankAccount: json['bank_account'] as String?,
  isActive: json['is_active'] as bool,
  gear: json['gear'] as String?,
  feePerHour: (json['fee_per_hour'] as num).toInt(),
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$PhotographerDataModelToJson(
  PhotographerDataModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'name': instance.name,
  'phone_number': instance.phoneNumber,
  'bank_account': instance.bankAccount,
  'is_active': instance.isActive,
  'gear': instance.gear,
  'fee_per_hour': instance.feePerHour,
  'created_at': instance.createdAt,
};

PaymentDataModel _$PaymentDataModelFromJson(Map<String, dynamic> json) =>
    PaymentDataModel(
      sessionCount: (json['session_count'] as num).toInt(),
      sessionPending: (json['session_pending'] as num).toInt(),
      sessionVerified: (json['session_verified'] as num).toInt(),
      sessionRejected: (json['session_rejected'] as num).toInt(),
      sessionPaid: (json['session_paid'] as num).toInt(),
      sessionUnpaid: (json['session_unpaid'] as num).toInt(),
      paidAmount: (json['paid_amount'] as num).toInt(),
      unpaidAmount: (json['unpaid_amount'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$PaymentDataModelToJson(PaymentDataModel instance) =>
    <String, dynamic>{
      'session_count': instance.sessionCount,
      'session_pending': instance.sessionPending,
      'session_verified': instance.sessionVerified,
      'session_rejected': instance.sessionRejected,
      'session_paid': instance.sessionPaid,
      'session_unpaid': instance.sessionUnpaid,
      'paid_amount': instance.paidAmount,
      'unpaid_amount': instance.unpaidAmount,
      'status': instance.status,
    };
