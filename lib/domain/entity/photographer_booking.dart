import 'package:equatable/equatable.dart';

class PhotographerBooking extends Equatable {
  final String id;
  final String eventDate;
  final String clientName;
  final String location;
  final String universityName;
  final String packageName;
  final int fee;
  final String status;
  final List<BookingAddon> addons;

  const PhotographerBooking({
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

  @override
  List<Object?> get props => [
        id,
        eventDate,
        clientName,
        location,
        universityName,
        packageName,
        fee,
        status,
        addons,
      ];
}

class BookingAddon extends Equatable {
  final String id;
  final String title;

  const BookingAddon({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];
}

class PhotographerBookingMetadata extends Equatable {
  final int count;
  final int totalPages;
  final int page;
  final int limit;

  const PhotographerBookingMetadata({
    required this.count,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  @override
  List<Object?> get props => [count, totalPages, page, limit];
}
