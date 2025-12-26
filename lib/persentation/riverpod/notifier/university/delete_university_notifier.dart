

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'delete_university_notifier.g.dart';

@riverpod
class DeleteUniversityNotifier extends _$DeleteUniversityNotifier{

  @override
  Future<String> build(String idUniv)async{
    final usecase = ref.read(deleteUnive);
    return usecase.execute(idUniv);
  }

}