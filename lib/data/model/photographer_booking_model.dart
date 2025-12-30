import 'package:json_annotation/json_annotation.dart';
import 'package:wavenadmin/domain/entity/photographer_booking.dart';

part 'photographer_booking_model.g.dart';

@JsonSerializable()
class PhotographerBookingResponse {
  final String message;
  final PhotographerBookingMetadataModel? metadata;
  final List<PhotographerBookingModel> data;

  const PhotographerBookingResponse({
    required this.message,
    required this.metadata,
    required this.data,
  });

  factory PhotographerBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$PhotographerBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhotographerBookingResponseToJson(this);
}

@JsonSerializable()
class PhotographerBookingModel {
  final String id;

  @JsonKey(name: 'event_date')
  final String eventDate;

  @JsonKey(name: 'client_name')
  final String clientName;

  final String location;

  @JsonKey(name: 'university_name')
  final String universityName;

  @JsonKey(name: 'package_name')
  final String packageName;

  final int fee;
  final String status;
  final List<BookingAddonModel>? addons;

  const PhotographerBookingModel({
    required this.id,
    required this.eventDate,
    required this.clientName,
    required this.location,
    required this.universityName,
    required this.packageName,
    required this.fee,
    required this.status,
    required this.addons,
  });

  factory PhotographerBookingModel.fromJson(Map<String, dynamic> json) =>
      _$PhotographerBookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotographerBookingModelToJson(this);

  PhotographerBooking toEntity() {
    return PhotographerBooking(
      id: id,
      eventDate: eventDate,
      clientName: clientName,
      location: location,
      universityName: universityName,
      packageName: packageName,
      fee: fee,
      status: status,
      addons: addons == null?[]: addons!.map((addon) => addon.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class BookingAddonModel {
  final String id;
  final String title;

  const BookingAddonModel({
    required this.id,
    required this.title,
  });

  factory BookingAddonModel.fromJson(Map<String, dynamic> json) =>
      _$BookingAddonModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingAddonModelToJson(this);

  BookingAddon toEntity() {
    return BookingAddon(
      id: id,
      title: title,
    );
  }
}

@JsonSerializable()
class PhotographerBookingMetadataModel {
  final int count;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  final int page;
  final int limit;

  const PhotographerBookingMetadataModel({
    required this.count,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  factory PhotographerBookingMetadataModel.fromJson(
          Map<String, dynamic> json) =>
      _$PhotographerBookingMetadataModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PhotographerBookingMetadataModelToJson(this);

  PhotographerBookingMetadata toEntity() {
    return PhotographerBookingMetadata(
      count: count,
      totalPages: totalPages,
      page: page,
      limit: limit,
    );
  }
}
