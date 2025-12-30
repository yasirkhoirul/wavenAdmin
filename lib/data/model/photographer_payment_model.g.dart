// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photographer_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotographerPaymentModel _$PhotographerPaymentModelFromJson(
  Map<String, dynamic> json,
) => PhotographerPaymentModel(
  id: json['id'] as String,
  name: json['name'] as String,
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

Map<String, dynamic> _$PhotographerPaymentModelToJson(
  PhotographerPaymentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
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

PhotographerPaymentMetadataModel _$PhotographerPaymentMetadataModelFromJson(
  Map<String, dynamic> json,
) => PhotographerPaymentMetadataModel(
  count: (json['count'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$PhotographerPaymentMetadataModelToJson(
  PhotographerPaymentMetadataModel instance,
) => <String, dynamic>{
  'count': instance.count,
  'total_pages': instance.totalPages,
  'page': instance.page,
  'limit': instance.limit,
};

PhotographerPaymentResponse _$PhotographerPaymentResponseFromJson(
  Map<String, dynamic> json,
) => PhotographerPaymentResponse(
  message: json['message'] as String,
  metadata: json['metadata'] == null
      ? null
      : PhotographerPaymentMetadataModel.fromJson(
          json['metadata'] as Map<String, dynamic>,
        ),
  data: (json['data'] as List<dynamic>)
      .map((e) => PhotographerPaymentModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PhotographerPaymentResponseToJson(
  PhotographerPaymentResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'data': instance.data,
};
