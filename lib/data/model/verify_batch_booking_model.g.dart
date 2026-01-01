// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_batch_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyBatchBookingRequest _$VerifyBatchBookingRequestFromJson(
  Map<String, dynamic> json,
) => VerifyBatchBookingRequest(
  ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$VerifyBatchBookingRequestToJson(
  VerifyBatchBookingRequest instance,
) => <String, dynamic>{'ids': instance.ids};

VerifyBatchBookingResponse _$VerifyBatchBookingResponseFromJson(
  Map<String, dynamic> json,
) => VerifyBatchBookingResponse(
  message: json['message'] as String,
  verifiedCount: (json['verified_count'] as num).toInt(),
  failedIds: (json['failed_ids'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$VerifyBatchBookingResponseToJson(
  VerifyBatchBookingResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'verified_count': instance.verifiedCount,
  'failed_ids': instance.failedIds,
};
