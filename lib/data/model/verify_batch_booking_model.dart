import 'package:json_annotation/json_annotation.dart';

part 'verify_batch_booking_model.g.dart';

@JsonSerializable()
class VerifyBatchBookingRequest {
  final List<String> ids;

  VerifyBatchBookingRequest({required this.ids});

  factory VerifyBatchBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyBatchBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyBatchBookingRequestToJson(this);
}

@JsonSerializable()
class VerifyBatchBookingResponse {
  final String message;

  @JsonKey(name: 'verified_count')
  final int verifiedCount;

  @JsonKey(name: 'failed_ids')
  final List<String>? failedIds;

  VerifyBatchBookingResponse({
    required this.message,
    required this.verifiedCount,
    this.failedIds,
  });

  factory VerifyBatchBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyBatchBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyBatchBookingResponseToJson(this);
}
