import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/photographer_detail.dart';

part 'photographer_detail_model.g.dart';

@JsonSerializable()
class PhotographerDetailResponse {
  final String message;
  final PhotographerDetailData data;

  const PhotographerDetailResponse({
    required this.message,
    required this.data,
  });

  factory PhotographerDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PhotographerDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhotographerDetailResponseToJson(this);

  PhotographerDetail toEntity() {
    return PhotographerDetail(
      photographerData: data.photographerData.toEntity(),
      paymentData: data.paymentData.toEntity(),
    );
  }
}

@JsonSerializable()
class PhotographerDetailData {
  @JsonKey(name: 'photographer_data')
  final PhotographerDataModel photographerData;

  @JsonKey(name: 'payment_data')
  final PaymentDataModel paymentData;

  const PhotographerDetailData({
    required this.photographerData,
    required this.paymentData,
  });

  factory PhotographerDetailData.fromJson(Map<String, dynamic> json) =>
      _$PhotographerDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$PhotographerDetailDataToJson(this);
}

@JsonSerializable()
class PhotographerDataModel {
  final String id;
  final String username;
  final String email;
  final String name;

  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  @JsonKey(name: 'bank_account')
  final String? bankAccount;

  @JsonKey(name: 'is_active')
  final bool isActive;

  final String? gear;

  @JsonKey(name: 'fee_per_hour')
  final int feePerHour;

  @JsonKey(name: 'created_at')
  final String createdAt;

  const PhotographerDataModel({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.bankAccount,
    required this.isActive,
    required this.gear,
    required this.feePerHour,
    required this.createdAt,
  });

  factory PhotographerDataModel.fromJson(Map<String, dynamic> json) =>
      _$PhotographerDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotographerDataModelToJson(this);

  PhotographerData toEntity() {
    return PhotographerData(
      id: id,
      username: username,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      bankAccount: bankAccount??'',
      isActive: isActive,
      gear: gear??'',
      feePerHour: feePerHour,
      createdAt: createdAt,
    );
  }
}

@JsonSerializable()
class PaymentDataModel {
  @JsonKey(name: 'session_count')
  final int sessionCount;

  @JsonKey(name: 'session_pending')
  final int sessionPending;

  @JsonKey(name: 'session_verified')
  final int sessionVerified;

  @JsonKey(name: 'session_rejected')
  final int sessionRejected;

  @JsonKey(name: 'session_paid')
  final int sessionPaid;

  @JsonKey(name: 'session_unpaid')
  final int sessionUnpaid;

  @JsonKey(name: 'paid_amount')
  final int paidAmount;

  @JsonKey(name: 'unpaid_amount')
  final int unpaidAmount;

  final String status;

  const PaymentDataModel({
    required this.sessionCount,
    required this.sessionPending,
    required this.sessionVerified,
    required this.sessionRejected,
    required this.sessionPaid,
    required this.sessionUnpaid,
    required this.paidAmount,
    required this.unpaidAmount,
    required this.status,
  });

  factory PaymentDataModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDataModelToJson(this);

  PaymentData toEntity() {
    return PaymentData(
      sessionCount: sessionCount,
      sessionPending: sessionPending,
      sessionVerified: sessionVerified,
      sessionRejected: sessionRejected,
      sessionPaid: sessionPaid,
      sessionUnpaid: sessionUnpaid,
      paidAmount: paidAmount,
      unpaidAmount: unpaidAmount,
      status: status,
    );
  }
}
