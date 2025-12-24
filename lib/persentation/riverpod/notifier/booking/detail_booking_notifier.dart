

import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/entity/detail_booking.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'detail_booking_notifier.g.dart';


@riverpod
class DetailBookingNotifier extends _$DetailBookingNotifier{
  @override
  Future<DetailBooking> build(String idDetail) async{
    Logger().d("build detail dipanggil");
    final usecase = ref.read(getDetailBooking);
    return await usecase.execute(idDetail);
  }

  Future<void> onRefresh() async {
    Logger().d("onRefresh detail booking dipanggil");
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(getDetailBooking);
      return await usecase.execute(idDetail);
    });
  }
}