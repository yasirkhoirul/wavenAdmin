// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailBookingResponse _$DetailBookingResponseFromJson(
  Map<String, dynamic> json,
) => DetailBookingResponse(
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : DetailBookingData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DetailBookingResponseToJson(
  DetailBookingResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

DetailBookingData _$DetailBookingDataFromJson(Map<String, dynamic> json) =>
    DetailBookingData(
      id: json['id'] as String?,
      clientName: json['client_name'] as String?,
      clientPhoneNumber: json['client_phone_number'] as String?,
      clientInstagram: json['client_instagram'] as String?,
      universityId: json['university_id'] as String?,
      university: json['university'] as String?,
      packageId: json['package_id'] as String?,
      packageName: json['package_name'] as String?,
      eventDate: json['event_date'] as String?,
      eventStartTime: json['event_start_time'] as String?,
      eventEndTime: json['event_end_time'] as String?,
      location: json['location'] as String?,
      note: json['note'] as String?,
      verificationStatus: json['verification_status'] as String?,
      alreadyPhoto: json['already_photo'] as bool?,
      photoResultUrl: json['photo_result_url'] as String?,
      editedPhotoResultUrl: json['edited_photo_result_url'] as String?,
      status: json['status'] as String?,
      extra: (json['extra'] as List<dynamic>?)
          ?.map((e) => ExtraItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['total_amount'] as num?)?.toInt(),
      paidAmount: (json['paid_amount'] as num?)?.toInt(),
      unpaidAmount: (json['unpaid_amount'] as num?)?.toInt(),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => TransactionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      photographerData: (json['photographer_data'] as List<dynamic>?)
          ?.map((e) => PhotographerItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      editedPhoto: json['edited_photo'] as String?,
    );

Map<String, dynamic> _$DetailBookingDataToJson(DetailBookingData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_name': instance.clientName,
      'client_phone_number': instance.clientPhoneNumber,
      'client_instagram': instance.clientInstagram,
      'university_id': instance.universityId,
      'university': instance.university,
      'package_id': instance.packageId,
      'package_name': instance.packageName,
      'event_date': instance.eventDate,
      'event_start_time': instance.eventStartTime,
      'event_end_time': instance.eventEndTime,
      'location': instance.location,
      'note': instance.note,
      'verification_status': instance.verificationStatus,
      'already_photo': instance.alreadyPhoto,
      'edited_photo': instance.editedPhoto,
      'photo_result_url': instance.photoResultUrl,
      'edited_photo_result_url': instance.editedPhotoResultUrl,
      'status': instance.status,
      'extra': instance.extra,
      'total_amount': instance.totalAmount,
      'paid_amount': instance.paidAmount,
      'unpaid_amount': instance.unpaidAmount,
      'transactions': instance.transactions,
      'photographer_data': instance.photographerData,
    };

ExtraItem _$ExtraItemFromJson(Map<String, dynamic> json) =>
    ExtraItem(id: json['id'] as String?, name: json['name'] as String?);

Map<String, dynamic> _$ExtraItemToJson(ExtraItem instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

TransactionItem _$TransactionItemFromJson(Map<String, dynamic> json) =>
    TransactionItem(
      id: json['id'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      status: json['status'] as String?,
      type: json['type'] as String?,
      method: json['method'] as String?,
      transactionTime: json['transaction_time'] as String?,
      verificationStatus: json['verification_status'] as String?,
      transactionEvidenceUrl: json['transaction_evidence_url'] as String?,
    );

Map<String, dynamic> _$TransactionItemToJson(TransactionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'status': instance.status,
      'type': instance.type,
      'method': instance.method,
      'transaction_time': instance.transactionTime,
      'verification_status': instance.verificationStatus,
      'transaction_evidence_url': instance.transactionEvidenceUrl,
    };

PhotographerItem _$PhotographerItemFromJson(Map<String, dynamic> json) =>
    PhotographerItem(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      fee: (json['fee'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PhotographerItemToJson(PhotographerItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'fee': instance.fee,
    };
