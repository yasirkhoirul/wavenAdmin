import 'package:json_annotation/json_annotation.dart';

part 'create_booking_request_model.g.dart';

@JsonSerializable()
class CreateBookingRequest {
  @JsonKey(name: 'customer_data')
  final CustomerData customerData;
  
  @JsonKey(name: 'booking_data')
  final BookingData bookingData;
  
  @JsonKey(name: 'additional_data')
  final AdditionalData additionalData;

  CreateBookingRequest({
    required this.customerData,
    required this.bookingData,
    required this.additionalData,
  });

  factory CreateBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingRequestToJson(this);
}

@JsonSerializable()
class CustomerData {
  @JsonKey(name: 'user_id')
  final String userId;
  
  @JsonKey(name: 'full_name')
  final String fullName;
  
  @JsonKey(name: 'whatsapp_number')
  final String whatsappNumber;
  
  final String instagram;

  CustomerData({
    required this.userId,
    required this.fullName,
    required this.whatsappNumber,
    required this.instagram,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDataToJson(this);
}

@JsonSerializable()
class BookingData {
  @JsonKey(name: 'package_id')
  final String packageId;
  
  final String date;
  
  @JsonKey(name: 'start_time')
  final String startTime;
  
  @JsonKey(name: 'end_time')
  final String endTime;
  
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  
  @JsonKey(name: 'payment_type')
  final String paymentType;
  
  final double amount;
  
  @JsonKey(name: 'addon_ids')
  final List<String> addonIds;

  BookingData({
    required this.packageId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.paymentMethod,
    required this.paymentType,
    required this.amount,
    required this.addonIds,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) =>
      _$BookingDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDataToJson(this);
}

@JsonSerializable()
class AdditionalData {
  @JsonKey(name: 'university_id')
  final String universityId;
  
  final String location;
  
  final String note;

  final String platform;

  AdditionalData({
    required this.universityId,
    required this.location,
    required this.note, required this.platform,
  });

  factory AdditionalData.fromJson(Map<String, dynamic> json) =>
      _$AdditionalDataFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalDataToJson(this);
}

@JsonSerializable()
class CreateBookingResponse {
  final String message;
  
  @JsonKey(name: 'booking_id')
  final String? bookingId;
  
  final BookingResponseData? data;

  CreateBookingResponse({
    required this.message,
    this.bookingId,
    this.data,
  });

  factory CreateBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBookingResponseToJson(this);
}

@JsonSerializable()
class BookingResponseData {
  @JsonKey(name: 'booking_detail')
  final BookingDetail bookingDetail;
  
  final BookingActions? actions;

  BookingResponseData({
    required this.bookingDetail,
    this.actions,
  });

  factory BookingResponseData.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookingResponseDataToJson(this);
}

@JsonSerializable()
class BookingDetail {
  @JsonKey(name: 'booking_id')
  final String bookingId;
  
  @JsonKey(name: 'total_amount')
  final int totalAmount;
  
  @JsonKey(name: 'paid_amount')
  final int paidAmount;
  
  @JsonKey(name: 'payment_method')
  final String paymentMethod;
  
  @JsonKey(name: 'transaction_time')
  final String transactionTime;
  
  final String status;

  BookingDetail({
    required this.bookingId,
    required this.totalAmount,
    required this.paidAmount,
    required this.paymentMethod,
    required this.transactionTime,
    required this.status,
  });

  factory BookingDetail.fromJson(Map<String, dynamic> json) =>
      _$BookingDetailFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDetailToJson(this);
}

@JsonSerializable()
class BookingActions {
  final String? token;
  
  @JsonKey(name: 'redirect_url')
  final String? redirectUrl;

  BookingActions({
    required this.token,
    required this.redirectUrl,
  });

  factory BookingActions.fromJson(Map<String, dynamic> json) =>
      _$BookingActionsFromJson(json);

  Map<String, dynamic> toJson() => _$BookingActionsToJson(this);
}

@JsonSerializable()
class CheckAvailabilityResponse {
  final String message;

  CheckAvailabilityResponse({
    required this.message,
  });

  factory CheckAvailabilityResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckAvailabilityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAvailabilityResponseToJson(this);
}
