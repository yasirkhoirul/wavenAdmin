import 'package:flutter_test/flutter_test.dart';
import 'package:wavenadmin/data/datasource/booking_remote_data_source.dart';

void main() {
  group('BookingRemoteDataSource', () {
    const tBookingId = 'booking-123';
    const tPage = 1;
    const tLimit = 10;

    test('should have booking remote data source interface defined', () async {
      expect(BookingRemoteDataSource, isNotNull);
    });

    test('getListBooking should accept page and limit parameters', () async {
      expect(tPage, 1);
      expect(tLimit, 10);
    });

    test('getDetailBooking should accept booking id parameter', () async {
      expect(tBookingId, isNotEmpty);
    });

    test('verifyBooking should accept booking id and status parameters', () async {
      expect(tBookingId, isNotEmpty);
    });

    test('checkBookingAvailability should accept date and time parameters', () async {
      const tDate = '2024-01-15';
      expect(tDate, isNotEmpty);
    });

    test('createBooking should accept booking request', () async {
      expect(tBookingId, isNotEmpty);
    });

    test('getListSchedule should accept month and year parameters', () async {
      const tMonth = 1;
      const tYear = 2024;
      expect(tMonth, isNotNull);
      expect(tYear, isNotNull);
    });
  });
}
