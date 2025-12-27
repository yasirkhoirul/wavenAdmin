
import 'package:json_annotation/json_annotation.dart';
part 'create_transaction_request_model.g.dart';

@JsonSerializable()
class CreateTransactionRequest {
  @JsonKey(name: 'payment_type')
  final String paymentType;
  
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  
  @JsonKey(name: 'amount')
  final double amount;

  final String platform;
  const CreateTransactionRequest({
    required this.paymentType,
    required this.paymentMethod,
    required this.amount, 
    required this.platform,
  });

  factory CreateTransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTransactionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTransactionRequestToJson(this);
}

@JsonSerializable()
class CreateTransactionResponse {
  final String message;
  final CreateTransactionData? data;

  const CreateTransactionResponse({
    required this.message,
    this.data,
  });

  factory CreateTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTransactionResponseToJson(this);
}

@JsonSerializable()
class CreateTransactionData {
  @JsonKey(name: 'transaction_detail')
  final TransactionDetail transactionDetail;
  final ActionsData? actions;

  const CreateTransactionData({
    required this.transactionDetail,
    this.actions,
  });

  factory CreateTransactionData.fromJson(Map<String, dynamic> json) =>
      _$CreateTransactionDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTransactionDataToJson(this);
}

@JsonSerializable()
class TransactionDetail {
  @JsonKey(name: 'booking_id')
  final String bookingId;
  @JsonKey(name: 'gateway_transaction_id')
  final String? gatewayTransactionId;
  @JsonKey(name: 'total_amount')
  final double totalAmount;
  @JsonKey(name: 'paid_amount')
  final double paidAmount;
  final String? currency;
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  @JsonKey(name: 'transaction_time')
  final String transactionTime;
  final String status;
  final String? acquirer;

  const TransactionDetail({
    required this.bookingId,
    this.gatewayTransactionId,
    required this.totalAmount,
    required this.paidAmount,
    this.currency,
    required this.paymentMethod,
    required this.transactionTime,
    required this.status,
    this.acquirer,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDetailToJson(this);
}

@JsonSerializable()
class QrisAction {
  final String name;
  final String url;
  final String method;

  const QrisAction({
    required this.name,
    required this.url,
    required this.method,
  });

  factory QrisAction.fromJson(Map<String, dynamic> json) =>
      _$QrisActionFromJson(json);

  Map<String, dynamic> toJson() => _$QrisActionToJson(this);
}

@JsonSerializable()
class QrisPaymentStatusResponse {
  final String message;
  final QrisPaymentStatusData data;

  const QrisPaymentStatusResponse({
    required this.message,
    required this.data,
  });

  factory QrisPaymentStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$QrisPaymentStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QrisPaymentStatusResponseToJson(this);
}

@JsonSerializable()
class QrisPaymentStatusData {
  @JsonKey(name: 'is_paid')
  final bool isPaid;
  final String description;

  const QrisPaymentStatusData({
    required this.isPaid,
    required this.description,
  });

  factory QrisPaymentStatusData.fromJson(Map<String, dynamic> json) =>
      _$QrisPaymentStatusDataFromJson(json);

  Map<String, dynamic> toJson() => _$QrisPaymentStatusDataToJson(this);
}

@JsonSerializable()
class ActionsData {
  final String? token;
  @JsonKey(name: "redirect_url")
  final String? redirectUrl;
  const ActionsData(this.token,this.redirectUrl);

  factory ActionsData.fromJson(Map<String,dynamic> json)=> _$ActionsDataFromJson(json);

  Map<String,dynamic> toJson() => _$ActionsDataToJson(this);
}