// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingListResponse _$BookingListResponseFromJson(Map<String, dynamic> json) =>
    BookingListResponse(
      message: json['message'] as String,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      data: json['data'] == null
          ? null
          : BookingDataWrapper.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingListResponseToJson(
  BookingListResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'data': instance.data,
};

BookingDataWrapper _$BookingDataWrapperFromJson(Map<String, dynamic> json) =>
    BookingDataWrapper(
      totalBooking: (json['total_booking'] as num).toInt(),
      totalPending: (json['total_pending'] as num).toInt(),
      totalLunas: (json['total_lunas'] as num).toInt(),
      totalNeedVerified: (json['total_need_verified'] as num).toInt(),
      totalVerified: (json['total_verified'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => BookingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingDataWrapperToJson(BookingDataWrapper instance) =>
    <String, dynamic>{
      'total_booking': instance.totalBooking,
      'total_pending': instance.totalPending,
      'total_lunas': instance.totalLunas,
      'total_need_verified': instance.totalNeedVerified,
      'total_verified': instance.totalVerified,
      'data': instance.data,
    };

BookingItem _$BookingItemFromJson(Map<String, dynamic> json) => BookingItem(
  clientData: ClientData.fromJson(json['client_data'] as Map<String, dynamic>),
  bookingData: BookingData.fromJson(
    json['booking_data'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$BookingItemToJson(BookingItem instance) =>
    <String, dynamic>{
      'client_data': instance.clientData,
      'booking_data': instance.bookingData,
    };

ClientData _$ClientDataFromJson(Map<String, dynamic> json) => ClientData(
  clientName: json['client_name'] as String,
  universityName: json['university_name'] as String,
  phoneNumber: json['phone_number'] as String,
);

Map<String, dynamic> _$ClientDataToJson(ClientData instance) =>
    <String, dynamic>{
      'client_name': instance.clientName,
      'university_name': instance.universityName,
      'phone_number': instance.phoneNumber,
    };

BookingData _$BookingDataFromJson(Map<String, dynamic> json) => BookingData(
  id: json['id'] as String,
  packageName: json['package_name'] as String,
  eventDate: json['event_date'] as String,
  eventStartTime: json['event_start_time'] as String,
  eventEndTime: json['event_end_time'] as String,
  paidAmount: (json['paid_amount'] as num).toInt(),
  photoResultUrl: json['photo_result_url'] as String?,
  editedPhotoResultUrl: json['edited_photo_result_url'] as String?,
  status: json['status'] as String,
  verificationStatus: json['verification_status'] as String,
  alreadyPhoto: json['already_photo'] as bool,
);

Map<String, dynamic> _$BookingDataToJson(BookingData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'package_name': instance.packageName,
      'event_date': instance.eventDate,
      'event_start_time': instance.eventStartTime,
      'event_end_time': instance.eventEndTime,
      'paid_amount': instance.paidAmount,
      'photo_result_url': instance.photoResultUrl,
      'edited_photo_result_url': instance.editedPhotoResultUrl,
      'status': instance.status,
      'verification_status': instance.verificationStatus,
      'already_photo': instance.alreadyPhoto,
    };
