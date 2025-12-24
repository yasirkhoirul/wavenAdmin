// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_booking_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyBookingRequest _$VerifyBookingRequestFromJson(
  Map<String, dynamic> json,
) => VerifyBookingRequest(
  verifyStatus: json['verify_status'] as String,
  verifyRemarks: json['verify_remarks'] as String?,
);

Map<String, dynamic> _$VerifyBookingRequestToJson(
  VerifyBookingRequest instance,
) => <String, dynamic>{
  'verify_status': instance.verifyStatus,
  'verify_remarks': instance.verifyRemarks,
};

VerifyBookingResponse _$VerifyBookingResponseFromJson(
  Map<String, dynamic> json,
) => VerifyBookingResponse(message: json['message'] as String?);

Map<String, dynamic> _$VerifyBookingResponseToJson(
  VerifyBookingResponse instance,
) => <String, dynamic>{'message': instance.message};
