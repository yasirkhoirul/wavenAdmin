// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_transaction_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTransactionRequest _$CreateTransactionRequestFromJson(
  Map<String, dynamic> json,
) => CreateTransactionRequest(
  paymentType: json['payment_type'] as String,
  paymentMethod: json['payment_method'] as String,
  amount: (json['amount'] as num).toInt(),
  platform: json['platform'] as String,
);

Map<String, dynamic> _$CreateTransactionRequestToJson(
  CreateTransactionRequest instance,
) => <String, dynamic>{
  'payment_type': instance.paymentType,
  'payment_method': instance.paymentMethod,
  'amount': instance.amount,
  'platform': instance.platform,
};

CreateTransactionResponse _$CreateTransactionResponseFromJson(
  Map<String, dynamic> json,
) => CreateTransactionResponse(
  message: json['message'] as String,
  data: json['data'] == null
      ? null
      : CreateTransactionData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateTransactionResponseToJson(
  CreateTransactionResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

CreateTransactionData _$CreateTransactionDataFromJson(
  Map<String, dynamic> json,
) => CreateTransactionData(
  transactionDetail: TransactionDetail.fromJson(
    json['transaction_detail'] as Map<String, dynamic>,
  ),
  actions: json['actions'] == null
      ? null
      : ActionsData.fromJson(json['actions'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateTransactionDataToJson(
  CreateTransactionData instance,
) => <String, dynamic>{
  'transaction_detail': instance.transactionDetail,
  'actions': instance.actions,
};

TransactionDetail _$TransactionDetailFromJson(Map<String, dynamic> json) =>
    TransactionDetail(
      bookingId: json['booking_id'] as String,
      gatewayTransactionId: json['gateway_transaction_id'] as String?,
      totalAmount: (json['total_amount'] as num).toInt(),
      paidAmount: (json['paid_amount'] as num).toInt(),
      currency: json['currency'] as String?,
      paymentMethod: json['payment_method'] as String,
      transactionTime: json['transaction_time'] as String,
      status: json['status'] as String,
      acquirer: json['acquirer'] as String?,
    );

Map<String, dynamic> _$TransactionDetailToJson(TransactionDetail instance) =>
    <String, dynamic>{
      'booking_id': instance.bookingId,
      'gateway_transaction_id': instance.gatewayTransactionId,
      'total_amount': instance.totalAmount,
      'paid_amount': instance.paidAmount,
      'currency': instance.currency,
      'payment_method': instance.paymentMethod,
      'transaction_time': instance.transactionTime,
      'status': instance.status,
      'acquirer': instance.acquirer,
    };

QrisAction _$QrisActionFromJson(Map<String, dynamic> json) => QrisAction(
  name: json['name'] as String,
  url: json['url'] as String,
  method: json['method'] as String,
);

Map<String, dynamic> _$QrisActionToJson(QrisAction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'method': instance.method,
    };

QrisPaymentStatusResponse _$QrisPaymentStatusResponseFromJson(
  Map<String, dynamic> json,
) => QrisPaymentStatusResponse(
  message: json['message'] as String,
  data: QrisPaymentStatusData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QrisPaymentStatusResponseToJson(
  QrisPaymentStatusResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

QrisPaymentStatusData _$QrisPaymentStatusDataFromJson(
  Map<String, dynamic> json,
) => QrisPaymentStatusData(
  isPaid: json['is_paid'] as bool,
  description: json['description'] as String,
);

Map<String, dynamic> _$QrisPaymentStatusDataToJson(
  QrisPaymentStatusData instance,
) => <String, dynamic>{
  'is_paid': instance.isPaid,
  'description': instance.description,
};

ActionsData _$ActionsDataFromJson(Map<String, dynamic> json) =>
    ActionsData(json['token'] as String?, json['redirect_url'] as String?);

Map<String, dynamic> _$ActionsDataToJson(ActionsData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'redirect_url': instance.redirectUrl,
    };
