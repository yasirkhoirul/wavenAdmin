import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/usecase/get_pengaturan.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/persentation/riverpod/state/pengaturan_state.dart';

part 'pengaturan_notifier.g.dart';

@riverpod
class PengaturanNotifier extends _$PengaturanNotifier {
  @override
  Future<PengaturanState> build() async {
    final usecase = locator<GetPengaturan>();
    final data = await usecase.execute();
    return PengaturanState(data.isActive);
  }
}
