// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photographer_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotographerBookingResponse _$PhotographerBookingResponseFromJson(
  Map<String, dynamic> json,
) => PhotographerBookingResponse(
  message: json['message'] as String,
  metadata: json['metadata'] == null
      ? null
      : PhotographerBookingMetadataModel.fromJson(
          json['metadata'] as Map<String, dynamic>,
        ),
  data: (json['data'] as List<dynamic>)
      .map((e) => PhotographerBookingModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PhotographerBookingResponseToJson(
  PhotographerBookingResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'data': instance.data,
};

PhotographerBookingModel _$PhotographerBookingModelFromJson(
  Map<String, dynamic> json,
) => PhotographerBookingModel(
  id: json['id'] as String,
  eventDate: json['event_date'] as String,
  clientName: json['client_name'] as String,
  location: json['location'] as String,
  universityName: json['university_name'] as String,
  packageName: json['package_name'] as String,
  fee: (json['fee'] as num).toInt(),
  status: json['status'] as String,
  addons: (json['addons'] as List<dynamic>?)
      ?.map((e) => BookingAddonModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PhotographerBookingModelToJson(
  PhotographerBookingModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'event_date': instance.eventDate,
  'client_name': instance.clientName,
  'location': instance.location,
  'university_name': instance.universityName,
  'package_name': instance.packageName,
  'fee': instance.fee,
  'status': instance.status,
  'addons': instance.addons,
};

BookingAddonModel _$BookingAddonModelFromJson(Map<String, dynamic> json) =>
    BookingAddonModel(id: json['id'] as String, title: json['title'] as String);

Map<String, dynamic> _$BookingAddonModelToJson(BookingAddonModel instance) =>
    <String, dynamic>{'id': instance.id, 'title': instance.title};

PhotographerBookingMetadataModel _$PhotographerBookingMetadataModelFromJson(
  Map<String, dynamic> json,
) => PhotographerBookingMetadataModel(
  count: (json['count'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$PhotographerBookingMetadataModelToJson(
  PhotographerBookingMetadataModel instance,
) => <String, dynamic>{
  'count': instance.count,
  'total_pages': instance.totalPages,
  'page': instance.page,
  'limit': instance.limit,
};
