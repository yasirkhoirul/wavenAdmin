import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavenadmin/domain/entity/detailAdmin.dart';
import 'package:wavenadmin/domain/entity/detailUser.dart';
import 'package:wavenadmin/domain/usecase/create_admin.dart';
import 'package:wavenadmin/domain/usecase/delete_admin.dart';
import 'package:wavenadmin/domain/usecase/get_detail_admin.dart';
import 'package:wavenadmin/domain/usecase/get_detail_user.dart';
import 'package:wavenadmin/domain/usecase/put_detail_admin.dart';
import 'package:wavenadmin/injection.dart';

final getDetailAdminUsecaseProvider = Provider<GetDetailAdmin>((ref) {
  return locator<GetDetailAdmin>();
});

final putDetailAdminUsecaseProvider = Provider<PutDetailAdmin>((ref) {
  return locator<PutDetailAdmin>();
});

final createAdminUseCaseProvider = Provider<CreateAdmin>((ref) {
  return locator<CreateAdmin>();
});

final deleteAdminUseCaseProvider = Provider<DeleteAdmin>((ref) {
  return locator<DeleteAdmin>();
},);

final getUserDetailProvider = Provider<GetDetailUser>((ref) {
  return locator<GetDetailUser>();
},);