import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/photographer_payment.dart';

part 'photographer_payment_model.g.dart';

@JsonSerializable()
class PhotographerPaymentModel {
  final String id;
  final String name;
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

  PhotographerPaymentModel({
    required this.id,
    required this.name,
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

  factory PhotographerPaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PhotographerPaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotographerPaymentModelToJson(this);

  PhotographerPayment toEntity() => PhotographerPayment(
        id: id,
        name: name,
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

@JsonSerializable()
class PhotographerPaymentMetadataModel {
  final int count;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final int page;
  final int limit;

  PhotographerPaymentMetadataModel({
    required this.count,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  factory PhotographerPaymentMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$PhotographerPaymentMetadataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotographerPaymentMetadataModelToJson(this);

  PhotographerPaymentMetadata toEntity() => PhotographerPaymentMetadata(
        count: count,
        totalPages: totalPages,
        page: page,
        limit: limit,
      );
}

@JsonSerializable()
class PhotographerPaymentResponse {
  final String message;
  final PhotographerPaymentMetadataModel? metadata;
  final List<PhotographerPaymentModel> data;

  PhotographerPaymentResponse({
    required this.message,
    required this.metadata,
    required this.data,
  });

  factory PhotographerPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PhotographerPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhotographerPaymentResponseToJson(this);
}
