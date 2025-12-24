import 'package:wavenadmin/domain/repository/booking_repository.dart';

class UploadEditedPhotoUsecase {
  final BookingRepository repository;

  const UploadEditedPhotoUsecase(this.repository);

  Future<String> execute(String idBooking, String photoUrl) async {
    try {
      final response = await repository.uploadEditedPhoto(idBooking, photoUrl);
      return response.message ?? 'Edited photo berhasil diupload';
    } catch (e) {
      rethrow;
    }
  }
}
