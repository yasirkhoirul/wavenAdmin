import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wavenadmin/domain/usecase/create_admin.dart';
import 'package:wavenadmin/domain/usecase/create_transaction_usecase.dart';
import 'package:wavenadmin/domain/usecase/create_univ.dart';
import 'package:wavenadmin/domain/usecase/delete_admin.dart';
import 'package:wavenadmin/domain/usecase/delete_batch_user.dart';
import 'package:wavenadmin/domain/usecase/delete_fotografer.dart';
import 'package:wavenadmin/domain/usecase/delete_univ.dart';
import 'package:wavenadmin/domain/usecase/delete_user.dart';
import 'package:wavenadmin/domain/usecase/get_dashboard.dart';
import 'package:wavenadmin/domain/usecase/get_detail_admin.dart';
import 'package:wavenadmin/domain/usecase/get_detail_booking.dart';
import 'package:wavenadmin/domain/usecase/get_detail_fotografer.dart';
import 'package:wavenadmin/domain/usecase/get_detail_user.dart';
import 'package:wavenadmin/domain/usecase/get_list_addons.dart';
import 'package:wavenadmin/domain/usecase/get_list_booking.dart';
import 'package:wavenadmin/domain/usecase/get_list_photographer.dart';
import 'package:wavenadmin/domain/usecase/get_list_schedule.dart';
import 'package:wavenadmin/domain/usecase/get_package_dropdown.dart';
import 'package:wavenadmin/domain/usecase/get_photographer_dropdown.dart';
import 'package:wavenadmin/domain/usecase/get_universitas_list.dart';
import 'package:wavenadmin/domain/usecase/get_university_dropdown.dart';
import 'package:wavenadmin/domain/usecase/put_detail_admin.dart';
import 'package:wavenadmin/domain/usecase/put_detail_fotografer.dart';
import 'package:wavenadmin/domain/usecase/update_booking.dart';
import 'package:wavenadmin/domain/usecase/upload_edited_photo_usecase.dart';
import 'package:wavenadmin/domain/usecase/upload_photo_result_usecase.dart';
import 'package:wavenadmin/domain/usecase/verify_batch_booking.dart';
import 'package:wavenadmin/domain/usecase/verify_booking_usecase.dart';
import 'package:wavenadmin/domain/usecase/verify_transaction_usecase.dart';
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

final getListPhotoGraperProvider = Provider<GetListPhotographer>((ref) {
  return locator<GetListPhotographer>();
},);

final getDetailFotografer = Provider<GetDetailFotografer>((ref) {
  return locator<GetDetailFotografer>();
},);

final putDetailFotografer = Provider<PutDetailFotografer>((ref) {
  return locator<PutDetailFotografer>();
},);

final deleteFotograferUseCase = Provider<DeleteFotografer>((ref) {
  return locator<DeleteFotografer>();
},);

final getListBooking = Provider<GetListBooking>((ref) {
  return locator<GetListBooking>();
},);

final verifyBatchBookingUsecase = Provider<VerifyBatchBooking>((ref) {
  return locator<VerifyBatchBooking>();
},);

final getDetailBooking = Provider<GetDetailBooking>((ref) {
  return locator<GetDetailBooking>();
},);

final getListAddons = Provider<GetListAddons>((ref) {
  return locator<GetListAddons>();
},);

final getUniversityDropdown = Provider<GetUniversityDropdown>((ref) {
  return locator<GetUniversityDropdown>();
},);
final getPhotographerDropdown = Provider<GetPhotographerDropdown>((ref) {
  return locator<GetPhotographerDropdown>();
},);
final getPackageDropdown = Provider<GetPackageDropdown>((ref) {
  return locator<GetPackageDropdown>();
},);

final updateBooking = Provider<UpdateBooking>((ref) {
  return locator<UpdateBooking>();
},);

final verifyBooking = Provider<VerifyBookingUsecase>((ref) {
  return locator<VerifyBookingUsecase>();
},);

final verifyTransactionUsecase = Provider<VerifyTransactionUsecase>((ref) {
  return locator<VerifyTransactionUsecase>();
},);

final createTransactionUsecaseProvider = Provider<CreateTransactionUsecase>((ref) {
  return locator<CreateTransactionUsecase>();
},);

final uploadPhotoResult = Provider<UploadPhotoResultUsecase>((ref) {
  return locator<UploadPhotoResultUsecase>();
},);

final uploadEditedPhoto = Provider<UploadEditedPhotoUsecase>((ref) {
  return locator<UploadEditedPhotoUsecase>();
},);

final getListUniversitasUseCse = Provider<GetUniversitasList>((ref) {
  return locator<GetUniversitasList>();
},);

final createUnive = Provider<CreateUniv>((ref) {
  return locator<CreateUniv>();
},);
final deleteUnive = Provider<DeleteUniv>((ref) {
  return locator<DeleteUniv>();
},);
final deleteUserUsecase = Provider<DeleteUser>((ref) {
  return locator<DeleteUser>();
},);
final deleteBatchUserUsecase = Provider<DeleteBatchUser>((ref) {
  return locator<DeleteBatchUser>();
},);
final getListScheduleUseCase = Provider<GetListSchedule>((ref) {
  return locator<GetListSchedule>();
},);

final getDashboardProviderUseCase = Provider<GetDashboard>((ref) {
  return locator<GetDashboard>();
},);