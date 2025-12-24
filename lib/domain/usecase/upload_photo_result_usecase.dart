import 'package:wavenadmin/domain/repository/booking_repository.dart';

class UploadPhotoResultUsecase {
  final BookingRepository repository;

  const UploadPhotoResultUsecase(this.repository);

  Future<String> execute(String idBooking, String photoUrl) async {
    try {
      final response = await repository.uploadPhotoResult(idBooking, photoUrl);
      return response.message ?? 'Photo result berhasil diupload';
    } catch (e) {
      rethrow;
    }
  }
}
