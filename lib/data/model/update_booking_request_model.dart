import 'package:json_annotation/json_annotation.dart';

part 'update_booking_request_model.g.dart';

@JsonSerializable()
class UpdateBookingRequest {
  @JsonKey(name: 'university_id')
  final String universityId;
  @JsonKey(name: 'package_id')
  final String packageId;
  @JsonKey(name: 'event_date')
  final String eventDate;
  @JsonKey(name: 'event_start_time')
  final String eventStartTime;
  @JsonKey(name: 'event_end_time')
  final String eventEndTime;
  @JsonKey(name: 'location_address')
  final String locationAddress;
  @JsonKey(name: 'already_photo')
  final bool alreadyPhoto;
  @JsonKey(name: 'addon_ids')
  final List<String> addonIds;
  final List<PhotographerRequest> photographers;

  UpdateBookingRequest({
    required this.universityId,
    required this.packageId,
    required this.eventDate,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.locationAddress,
    required this.alreadyPhoto,
    required this.addonIds,
    required this.photographers,
  });

  factory UpdateBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBookingRequestToJson(this);
}

@JsonSerializable()
class PhotographerRequest {
  final String id;
  final int fee;

  PhotographerRequest({
    required this.id,
    required this.fee,
  });

  factory PhotographerRequest.fromJson(Map<String, dynamic> json) =>
      _$PhotographerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PhotographerRequestToJson(this);
}

@JsonSerializable()
class UpdateBookingResponse {
  final String? message;
  final String? data;

  UpdateBookingResponse({
    this.message,
    this.data,
  });

  factory UpdateBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBookingResponseToJson(this);
}
