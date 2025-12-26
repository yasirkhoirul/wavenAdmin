
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/entity/university_detail.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';


part 'create_university_notifier.g.dart';

@riverpod
class CreateUniversityNotifier extends _$CreateUniversityNotifier{
  @override
  Future<String> build(UniversityDetail payload)async{
    final usecase = ref.read(createUnive);
    return usecase.execute(payload);
  }
}