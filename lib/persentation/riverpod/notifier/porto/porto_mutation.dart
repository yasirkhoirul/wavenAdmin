

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/entity/porto_list.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'porto_mutation.g.dart';


@riverpod
class PortoMutation extends _$PortoMutation{
  @override
  Future<PortoList> build(String packageId)async{
    final usecase = ref.read(getListPOrtoPorvider);
    return usecase.execute(packageId);
  }

  Future<void>deletePortoOne(String portoId)async{
    state = AsyncLoading();
    try {
      final usecase = ref.read(deletePortoProvider);
      await usecase.execute(portoId);
      ref.invalidateSelf();
    } catch (e,s) {
      state = AsyncError(e, s);
    }
  }
  Future<void>addPortoOne(XFile image)async{
    state = AsyncLoading();
    try {
      final usecase = ref.read(createPortoProvider);
      await usecase.execute(image,packageId);
      ref.invalidateSelf();
    } catch (e,s) {
      state = AsyncError(e, s);
    }
  }
}
