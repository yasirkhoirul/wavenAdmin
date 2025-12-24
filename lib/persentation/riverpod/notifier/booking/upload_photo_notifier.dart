import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/booking/detail_booking_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'upload_photo_notifier.g.dart';

@Riverpod(keepAlive: true)
class UploadPhotoResultNotifier extends _$UploadPhotoResultNotifier {
  @override
  FutureOr<String> build() {
    return '';
  }

  Future<void> execute(String idBooking, String photoUrl) async {
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(uploadPhotoResult);
      final result = await usecase.execute(idBooking, photoUrl);
      // Refresh detail booking setelah upload
      await ref.read(detailBookingProvider(idBooking).notifier).onRefresh();
      return result;
    });
  }
}

@Riverpod(keepAlive: true)
class UploadEditedPhotoNotifier extends _$UploadEditedPhotoNotifier {
  @override
  FutureOr<String> build() {
    return '';
  }

  Future<void> execute(String idBooking, String photoUrl) async {
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(uploadEditedPhoto);
      final result = await usecase.execute(idBooking, photoUrl);
      // Refresh detail booking setelah upload
      await ref.read(detailBookingProvider(idBooking).notifier).onRefresh();
      return result;
    });
  }
}
