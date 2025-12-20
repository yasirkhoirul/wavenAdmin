import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/data/model/usermodel.dart';
import 'package:wavenadmin/domain/entity/booking_list_data.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingListResponse {
  final String message;
  final Metadata? metadata;
  final BookingDataWrapper? data;

  BookingListResponse({
    required this.message,
    required this.metadata,
    required this.data,
  });

  BookingListData toBookingListData() {
    return BookingListData(
      metadata: metadata,
      totalBooking: data?.totalBooking ?? 0,
      totalPending: data?.totalPending ?? 0,
      totalLunas: data?.totalLunas ?? 0,
      totalNeedVerified: data?.totalNeedVerified ?? 0,
      totalVerified: data?.totalVerified ?? 0,
      bookings: data?.toEntityList() ?? [],
    );
  }

  factory BookingListResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookingListResponseToJson(this);
}

@JsonSerializable()
class BookingDataWrapper {
  @JsonKey(name: 'total_booking')
  final int totalBooking;

  @JsonKey(name: 'total_pending')
  final int totalPending;

  @JsonKey(name: 'total_lunas')
  final int totalLunas;

  @JsonKey(name: 'total_need_verified')
  final int totalNeedVerified;

  @JsonKey(name: 'total_verified')
  final int totalVerified;

  final List<BookingItem> data;

  BookingDataWrapper({
    required this.totalBooking,
    required this.totalPending,
    required this.totalLunas,
    required this.totalNeedVerified,
    required this.totalVerified,
    required this.data,
  });

  List<Booking> toEntityList() {
    return data.map((item) => item.toEntity()).toList();
  }

  factory BookingDataWrapper.fromJson(Map<String, dynamic> json) =>
      _$BookingDataWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDataWrapperToJson(this);
}

@JsonSerializable()
class BookingItem {
  @JsonKey(name: 'client_data')
  final ClientData clientData;

  @JsonKey(name: 'booking_data')
  final BookingData bookingData;

  BookingItem({
    required this.clientData,
    required this.bookingData,
  });

  Booking toEntity() {
    return Booking(
      id: bookingData.id,
      clientName: clientData.clientName,
      universityName: clientData.universityName,
      phoneNumber: clientData.phoneNumber,
      packageName: bookingData.packageName,
      eventDate: bookingData.eventDate,
      eventStartTime: bookingData.eventStartTime,
      eventEndTime: bookingData.eventEndTime,
      paidAmount: bookingData.paidAmount,
      photoResultUrl: bookingData.photoResultUrl,
      editedPhotoResultUrl: bookingData.editedPhotoResultUrl,
      status: bookingData.status,
      verificationStatus: bookingData.verificationStatus,
      alreadyPhoto: bookingData.alreadyPhoto,
    );
  }

  factory BookingItem.fromJson(Map<String, dynamic> json) =>
      _$BookingItemFromJson(json);

  Map<String, dynamic> toJson() => _$BookingItemToJson(this);
}

@JsonSerializable()
class ClientData {
  @JsonKey(name: 'client_name')
  final String clientName;

  @JsonKey(name: 'university_name')
  final String universityName;

  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  ClientData({
    required this.clientName,
    required this.universityName,
    required this.phoneNumber,
  });

  factory ClientData.fromJson(Map<String, dynamic> json) =>
      _$ClientDataFromJson(json);

  Map<String, dynamic> toJson() => _$ClientDataToJson(this);
}

@JsonSerializable()
class BookingData {
  final String id;

  @JsonKey(name: 'package_name')
  final String packageName;

  @JsonKey(name: 'event_date')
  final String eventDate;

  @JsonKey(name: 'event_start_time')
  final String eventStartTime;

  @JsonKey(name: 'event_end_time')
  final String eventEndTime;

  @JsonKey(name: 'paid_amount')
  final int paidAmount;

  @JsonKey(name: 'photo_result_url')
  final String? photoResultUrl;

  @JsonKey(name: 'edited_photo_result_url')
  final String? editedPhotoResultUrl;

  final String status;

  @JsonKey(name: 'verification_status')
  final String verificationStatus;

  @JsonKey(name: 'already_photo')
  final bool alreadyPhoto;

  BookingData({
    required this.id,
    required this.packageName,
    required this.eventDate,
    required this.eventStartTime,
    required this.eventEndTime,
    required this.paidAmount,
    this.photoResultUrl,
    this.editedPhotoResultUrl,
    required this.status,
    required this.verificationStatus,
    required this.alreadyPhoto,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) =>
      _$BookingDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDataToJson(this);
}
