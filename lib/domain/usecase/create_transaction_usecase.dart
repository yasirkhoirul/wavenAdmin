import 'package:image_picker/image_picker.dart';
import 'package:wavenadmin/data/model/create_transaction_request_model.dart';
import 'package:wavenadmin/domain/repository/booking_repository.dart';

class CreateTransactionUsecase {
  final BookingRepository repository;

  const CreateTransactionUsecase(this.repository);

  Future<CreateTransactionResponse> execute(String idBooking, CreateTransactionRequest request, XFile? imageFile) async {
    try {
      final response = await repository.createTransaction(idBooking, request, imageFile);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<int>> getQrisImage(String gatewayTransactionId) async {
    try {
      return await repository.getQrisImage(gatewayTransactionId);
    } catch (e) {
      rethrow;
    }
  }

  Future<QrisPaymentStatusResponse> checkQrisPaymentStatus(String bookingId, String gatewayTransactionId) async {
    try {
      return await repository.checkQrisPaymentStatus(bookingId, gatewayTransactionId);
    } catch (e) {
      rethrow;
    }
  }
}
