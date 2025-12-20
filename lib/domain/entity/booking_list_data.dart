import 'package:wavenadmin/data/model/usermodel.dart';

class BookingListData {
  final Metadata? metadata;
  final int totalBooking;
  final int totalPending;
  final int totalLunas;
  final int totalNeedVerified;
  final int totalVerified;
  final List<Booking> bookings;

  const BookingListData({
    required this.metadata,
    required this.totalBooking,
    required this.totalPending,
    required this.totalLunas,
    required this.totalNeedVerified,
    required this.totalVerified,
    required this.bookings,
  });
}

class Booking {
  final String id;
  final String clientName;
  final String universityName;
  final String phoneNumber;
  final String packageName;
  final String eventDate;
  final String eventStartTime;
  final String eventEndTime;
  final int paidAmount;
  final String? photoResultUrl;
  final String? editedPhotoResultUrl;
  final String status;
  final String verificationStatus;
  final bool alreadyPhoto;

  const Booking({
    required this.id,
    required this.clientName,
    required this.universityName,
    required this.phoneNumber,
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
}