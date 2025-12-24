import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/common/constant.dart';

part 'verify_booking_request_model.g.dart';

@JsonSerializable()
class VerifyBookingRequest {
  @JsonKey(name: 'verify_status')
  final String verifyStatus;
  @JsonKey(name: 'verify_remarks')
  final String? verifyRemarks;

  VerifyBookingRequest({
    required this.verifyStatus,
    this.verifyRemarks,
  });

  factory VerifyBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyBookingRequestToJson(this);

  factory VerifyBookingRequest.fromEnum(VerifyStatus status, {String? remarks}) {
    return VerifyBookingRequest(
      verifyStatus: status.name,
      verifyRemarks: remarks,
    );
  }
}

@JsonSerializable()
class VerifyBookingResponse {
  final String? message;

  VerifyBookingResponse({
    this.message,
  });

  factory VerifyBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyBookingResponseToJson(this);
}
