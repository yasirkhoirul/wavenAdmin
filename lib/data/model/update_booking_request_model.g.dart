// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_booking_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBookingRequest _$UpdateBookingRequestFromJson(
  Map<String, dynamic> json,
) => UpdateBookingRequest(
  universityId: json['university_id'] as String,
  packageId: json['package_id'] as String,
  eventDate: json['event_date'] as String,
  eventStartTime: json['event_start_time'] as String,
  eventEndTime: json['event_end_time'] as String,
  locationAddress: json['location_address'] as String,
  alreadyPhoto: json['already_photo'] as bool,
  addonIds: (json['addon_ids'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  photographers: (json['photographers'] as List<dynamic>)
      .map((e) => PhotographerRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UpdateBookingRequestToJson(
  UpdateBookingRequest instance,
) => <String, dynamic>{
  'university_id': instance.universityId,
  'package_id': instance.packageId,
  'event_date': instance.eventDate,
  'event_start_time': instance.eventStartTime,
  'event_end_time': instance.eventEndTime,
  'location_address': instance.locationAddress,
  'already_photo': instance.alreadyPhoto,
  'addon_ids': instance.addonIds,
  'photographers': instance.photographers,
};

PhotographerRequest _$PhotographerRequestFromJson(Map<String, dynamic> json) =>
    PhotographerRequest(
      id: json['id'] as String,
      fee: (json['fee'] as num).toInt(),
    );

Map<String, dynamic> _$PhotographerRequestToJson(
  PhotographerRequest instance,
) => <String, dynamic>{'id': instance.id, 'fee': instance.fee};

UpdateBookingResponse _$UpdateBookingResponseFromJson(
  Map<String, dynamic> json,
) => UpdateBookingResponse(
  message: json['message'] as String?,
  data: json['data'] as String?,
);

Map<String, dynamic> _$UpdateBookingResponseToJson(
  UpdateBookingResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};
