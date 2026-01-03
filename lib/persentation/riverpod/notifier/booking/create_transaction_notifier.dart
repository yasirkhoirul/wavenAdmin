import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/data/model/create_transaction_request_model.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/detail_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'create_transaction_notifier.g.dart';

@Riverpod(keepAlive: true)
class CreateTransaction extends _$CreateTransaction {
  @override
  FutureOr<CreateTransactionResponse?> build() {
    return null;
  }

  Future<void> execute(String idBooking, CreateTransactionRequest request, XFile? imageFile) async {
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(createTransactionUsecaseProvider);
      final result = await usecase.execute(idBooking, request, imageFile);
      
      
      // Refresh detail booking setelah create transaksi
      await ref.read(detailBookingProvider(idBooking).notifier).onRefresh();
      
      return result;
    });
  }
  
}
