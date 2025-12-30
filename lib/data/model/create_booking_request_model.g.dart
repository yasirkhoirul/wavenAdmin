// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_booking_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBookingRequest _$CreateBookingRequestFromJson(
  Map<String, dynamic> json,
) => CreateBookingRequest(
  customerData: CustomerData.fromJson(
    json['customer_data'] as Map<String, dynamic>,
  ),
  bookingData: BookingData.fromJson(
    json['booking_data'] as Map<String, dynamic>,
  ),
  additionalData: AdditionalData.fromJson(
    json['additional_data'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CreateBookingRequestToJson(
  CreateBookingRequest instance,
) => <String, dynamic>{
  'customer_data': instance.customerData,
  'booking_data': instance.bookingData,
  'additional_data': instance.additionalData,
};

CustomerData _$CustomerDataFromJson(Map<String, dynamic> json) => CustomerData(
  userId: json['user_id'] as String,
  fullName: json['full_name'] as String,
  whatsappNumber: json['whatsapp_number'] as String,
  instagram: json['instagram'] as String,
);

Map<String, dynamic> _$CustomerDataToJson(CustomerData instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'whatsapp_number': instance.whatsappNumber,
      'instagram': instance.instagram,
    };

BookingData _$BookingDataFromJson(Map<String, dynamic> json) => BookingData(
  packageId: json['package_id'] as String,
  date: json['date'] as String,
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String,
  paymentMethod: json['payment_method'] as String,
  paymentType: json['payment_type'] as String,
  amount: (json['amount'] as num).toInt(),
  addonIds: (json['addon_ids'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$BookingDataToJson(BookingData instance) =>
    <String, dynamic>{
      'package_id': instance.packageId,
      'date': instance.date,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'payment_method': instance.paymentMethod,
      'payment_type': instance.paymentType,
      'amount': instance.amount,
      'addon_ids': instance.addonIds,
    };

AdditionalData _$AdditionalDataFromJson(Map<String, dynamic> json) =>
    AdditionalData(
      universityId: json['university_id'] as String,
      location: json['location'] as String,
      note: json['note'] as String,
      platform: json['platform'] as String,
    );

Map<String, dynamic> _$AdditionalDataToJson(AdditionalData instance) =>
    <String, dynamic>{
      'university_id': instance.universityId,
      'location': instance.location,
      'note': instance.note,
      'platform': instance.platform,
    };

CreateBookingResponse _$CreateBookingResponseFromJson(
  Map<String, dynamic> json,
) => CreateBookingResponse(
  message: json['message'] as String,
  bookingId: json['booking_id'] as String?,
  data: json['data'] == null
      ? null
      : BookingResponseData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateBookingResponseToJson(
  CreateBookingResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'booking_id': instance.bookingId,
  'data': instance.data,
};

BookingResponseData _$BookingResponseDataFromJson(Map<String, dynamic> json) =>
    BookingResponseData(
      bookingDetail: BookingDetail.fromJson(
        json['booking_detail'] as Map<String, dynamic>,
      ),
      actions: json['actions'] == null
          ? null
          : BookingActions.fromJson(json['actions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingResponseDataToJson(
  BookingResponseData instance,
) => <String, dynamic>{
  'booking_detail': instance.bookingDetail,
  'actions': instance.actions,
};

BookingDetail _$BookingDetailFromJson(Map<String, dynamic> json) =>
    BookingDetail(
      bookingId: json['booking_id'] as String,
      totalAmount: (json['total_amount'] as num).toInt(),
      paidAmount: (json['paid_amount'] as num).toInt(),
      paymentMethod: json['payment_method'] as String,
      transactionTime: json['transaction_time'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$BookingDetailToJson(BookingDetail instance) =>
    <String, dynamic>{
      'booking_id': instance.bookingId,
      'total_amount': instance.totalAmount,
      'paid_amount': instance.paidAmount,
      'payment_method': instance.paymentMethod,
      'transaction_time': instance.transactionTime,
      'status': instance.status,
    };

BookingActions _$BookingActionsFromJson(Map<String, dynamic> json) =>
    BookingActions(
      token: json['token'] as String?,
      redirectUrl: json['redirect_url'] as String?,
    );

Map<String, dynamic> _$BookingActionsToJson(BookingActions instance) =>
    <String, dynamic>{
      'token': instance.token,
      'redirect_url': instance.redirectUrl,
    };

CheckAvailabilityResponse _$CheckAvailabilityResponseFromJson(
  Map<String, dynamic> json,
) => CheckAvailabilityResponse(message: json['message'] as String);

Map<String, dynamic> _$CheckAvailabilityResponseToJson(
  CheckAvailabilityResponse instance,
) => <String, dynamic>{'message': instance.message};
