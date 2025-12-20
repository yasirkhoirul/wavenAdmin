import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/entity/detail_user.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'userDetail.g.dart';

@riverpod
class UserDetail extends _$UserDetail {
  @override
  Future<DetailUser> build(String idUser)async{
    final usecase = ref.read(getUserDetailProvider);
    return usecase.execute(idUser);
  }
}