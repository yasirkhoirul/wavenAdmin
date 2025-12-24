import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/detail_booking.dart';

part 'detail_booking_model.g.dart';

@JsonSerializable()
class DetailBookingResponse {
  final String? message;
  final DetailBookingData? data;

  DetailBookingResponse({
    this.message,
    this.data,
  });

  factory DetailBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailBookingResponseToJson(this);

  DetailBooking toEntity() {
    return data?.toEntity() ?? DetailBooking();
  }
}

@JsonSerializable()
class DetailBookingData {
  final String? id;
  @JsonKey(name: 'client_name')
  final String? clientName;
  @JsonKey(name: 'client_phone_number')
  final String? clientPhoneNumber;
  @JsonKey(name: 'client_instagram')
  final String? clientInstagram;
  @JsonKey(name: 'university_id')
  final String? universityId;
  final String? university;
  @JsonKey(name: 'package_id')
  final String? packageId;
  @JsonKey(name: 'package_name')
  final String? packageName;
  @JsonKey(name: 'event_date')
  final String? eventDate;
  @JsonKey(name: 'event_start_time')
  final String? eventStartTime;
  @JsonKey(name: 'event_end_time')
  final String? eventEndTime;
  final String? location;
  final String? note;
  @JsonKey(name: 'verification_status')
  final String? verificationStatus;
  @JsonKey(name: 'already_photo')
  final bool? alreadyPhoto;
  @JsonKey(name: 'photo_result_url')
  final String? photoResultUrl;
  @JsonKey(name: 'edited_photo_result_url')
  final String? editedPhotoResultUrl;
  final String? status;
  final List<ExtraItem>? extra;
  @JsonKey(name: 'total_amount')
  final int? totalAmount;
  @JsonKey(name: 'paid_amount')
  final int? paidAmount;
  @JsonKey(name: 'unpaid_amount')
  final int? unpaidAmount;
  final List<TransactionItem>? transactions;
  @JsonKey(name: 'photographer_data')
  final List<PhotographerItem>? photographerData;

  DetailBookingData({
    this.id,
    this.clientName,
    this.clientPhoneNumber,
    this.clientInstagram,
    this.universityId,
    this.university,
    this.packageId,
    this.packageName,
    this.eventDate,
    this.eventStartTime,
    this.eventEndTime,
    this.location,
    this.note,
    this.verificationStatus,
    this.alreadyPhoto,
    this.photoResultUrl,
    this.editedPhotoResultUrl,
    this.status,
    this.extra,
    this.totalAmount,
    this.paidAmount,
    this.unpaidAmount,
    this.transactions,
    this.photographerData,
  });

  factory DetailBookingData.fromJson(Map<String, dynamic> json) =>
      _$DetailBookingDataFromJson(json);

  Map<String, dynamic> toJson() => _$DetailBookingDataToJson(this);

  DetailBooking toEntity() {
    return DetailBooking(
      id: id ?? '',
      clientName: clientName ?? '',
      clientPhoneNumber: clientPhoneNumber ?? '',
      clientInstagram: clientInstagram ?? '',
      universityId: universityId ?? '',
      university: university ?? '',
      packageId: packageId ?? '',
      packageName: packageName ?? '',
      eventDate: eventDate ?? '',
      eventStartTime: eventStartTime ?? '',
      eventEndTime: eventEndTime ?? '',
      location: location ?? '',
      note: note ?? '',
      verificationStatus: verificationStatus ?? '',
      alreadyPhoto: alreadyPhoto ?? false,
      photoResultUrl: photoResultUrl ?? '',
      editedPhotoResultUrl: editedPhotoResultUrl ?? '',
      status: status ?? '',
      extra: extra?.map((e) => e.toEntity()).toList() ?? [],
      totalAmount: totalAmount ?? 0,
      paidAmount: paidAmount ?? 0,
      unpaidAmount: unpaidAmount ?? 0,
      transactions: transactions?.map((t) => t.toEntity()).toList() ?? [],
      photographerData: photographerData?.map((p) => p.toEntity()).toList() ?? [],
    );
  }
}

@JsonSerializable()
class ExtraItem {
  final String? id;
  final String? name;

  ExtraItem({
    this.id,
    this.name,
  });

  factory ExtraItem.fromJson(Map<String, dynamic> json) =>
      _$ExtraItemFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraItemToJson(this);

  Extra toEntity() {
    return Extra(
      id: id ?? '',
      name: name ?? '',
    );
  }
}

@JsonSerializable()
class TransactionItem {
  final String? id;
  final int? amount;
  final String? status;
  final String? type;
  final String? method;
  @JsonKey(name: 'transaction_time')
  final String? transactionTime;
  @JsonKey(name: 'verification_status')
  final String? verificationStatus;
  @JsonKey(name: 'transaction_evidence_url')
  final String? transactionEvidenceUrl;

  TransactionItem({
    this.id,
    this.amount,
    this.status,
    this.type,
    this.method,
    this.transactionTime,
    this.verificationStatus,
    this.transactionEvidenceUrl,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionItemToJson(this);

  Transaction toEntity() {
    return Transaction(
      id: id ?? '',
      amount: amount ?? 0,
      status: status ?? '',
      type: type ?? '',
      method: method ?? '',
      transactionTime: transactionTime ?? '',
      verificationStatus: verificationStatus ?? '',
      transactionEvidenceUrl: transactionEvidenceUrl,
    );
  }
}

@JsonSerializable()
class PhotographerItem {
  final String? id;
  final String? name;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final int? fee;

  PhotographerItem({
    this.id,
    this.name,
    this.phoneNumber,
    this.fee,
  });

  factory PhotographerItem.fromJson(Map<String, dynamic> json) =>
      _$PhotographerItemFromJson(json);

  Map<String, dynamic> toJson() => _$PhotographerItemToJson(this);

  Photographer toEntity() {
    return Photographer(
      id: id ?? '',
      name: name ?? '',
      phoneNumber: phoneNumber ?? '',
      fee: fee ?? 0,
    );
  }
}
