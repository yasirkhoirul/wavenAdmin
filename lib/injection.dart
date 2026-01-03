
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:wavenadmin/data/addons_repository_impl.dart';
import 'package:wavenadmin/data/auth_repositoryimpl.dart';
import 'package:wavenadmin/data/booking_repository_impl.dart';
import 'package:wavenadmin/data/dashboard_repository_impl.dart';
import 'package:wavenadmin/data/datasource/dio.dart';
import 'package:wavenadmin/data/datasource/local_data.dart';
import 'package:wavenadmin/data/datasource/addon_remote_data_source.dart';
import 'package:wavenadmin/data/datasource/auth_remote_data_source.dart';
import 'package:wavenadmin/data/datasource/booking_remote_data_source.dart';
import 'package:wavenadmin/data/datasource/dashboard_remote_data_source.dart';
import 'package:wavenadmin/data/datasource/package_remote_data_source.dart';
import 'package:wavenadmin/data/datasource/pengaturan_remote_data_source.dart';
import 'package:wavenadmin/data/datasource/photographer_remote_data_source.dart';
import 'package:wavenadmin/data/datasource/university_remote_data_source.dart';
import 'package:wavenadmin/data/datasource/user_remote_data_source.dart';
import 'package:wavenadmin/data/package_repository_impl.dart';
import 'package:wavenadmin/data/pengaturan_repository_impl.dart';
import 'package:wavenadmin/data/referensi_repository_impl.dart';
import 'package:wavenadmin/data/university_repository_impl.dart';
import 'package:wavenadmin/data/user_repository_impl.dart';
import 'package:wavenadmin/data/file_mover_repository_impl.dart';
import 'package:wavenadmin/data/datasource/file_mover_local_data_source.dart';
import 'package:wavenadmin/domain/repository/addons_repository.dart';
import 'package:wavenadmin/domain/repository/auth_repository.dart';
import 'package:wavenadmin/domain/repository/booking_repository.dart';
import 'package:wavenadmin/domain/repository/package_repository.dart';
import 'package:wavenadmin/domain/repository/pengaturan_repository.dart';
import 'package:wavenadmin/domain/repository/referensi_repository.dart';
import 'package:wavenadmin/domain/repository/university_repository.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';
import 'package:wavenadmin/domain/repository/file_mover_repository.dart';
import 'package:wavenadmin/domain/usecase/create_admin.dart';
import 'package:wavenadmin/domain/usecase/create_booking_usecase.dart';
import 'package:wavenadmin/domain/usecase/create_fotografer.dart';
import 'package:wavenadmin/domain/usecase/create_package.dart';
import 'package:wavenadmin/domain/usecase/create_porto.dart';
import 'package:wavenadmin/domain/usecase/create_univ.dart';
import 'package:wavenadmin/domain/usecase/delete_admin.dart';
import 'package:wavenadmin/domain/usecase/delete_batch_user.dart';
import 'package:wavenadmin/domain/usecase/delete_fotografer.dart';
import 'package:wavenadmin/domain/usecase/delete_package.dart';
import 'package:wavenadmin/domain/usecase/delete_porto.dart';
import 'package:wavenadmin/domain/usecase/delete_univ.dart';
import 'package:wavenadmin/domain/usecase/delete_user.dart';
import 'package:wavenadmin/domain/usecase/get_addons_dropdown.dart';
import 'package:wavenadmin/domain/usecase/get_addon_detail.dart';
import 'package:wavenadmin/domain/usecase/get_porto.dart';
import 'package:wavenadmin/domain/usecase/update_addon.dart';
import 'package:wavenadmin/domain/usecase/create_addon.dart';
import 'package:wavenadmin/domain/usecase/delete_addon.dart';
import 'package:wavenadmin/domain/usecase/get_dashboard.dart';
import 'package:wavenadmin/domain/usecase/get_detail_admin.dart';
import 'package:wavenadmin/domain/usecase/get_detail_booking.dart';
import 'package:wavenadmin/domain/usecase/get_pengaturan.dart';
import 'package:wavenadmin/domain/usecase/update_pengaturan.dart';
import 'package:wavenadmin/domain/usecase/get_photographer_bookings.dart';
import 'package:wavenadmin/domain/usecase/get_photographer_detail.dart';
import 'package:wavenadmin/domain/usecase/get_photographer_payment_list.dart';
import 'package:wavenadmin/domain/repository/photographer_payment_repository.dart';
import 'package:wavenadmin/data/photographer_payment_repository_impl.dart';
import 'package:wavenadmin/domain/usecase/get_detail_fotografer.dart';
import 'package:wavenadmin/domain/usecase/get_detail_user.dart';
import 'package:wavenadmin/domain/usecase/get_list_addons.dart';
import 'package:wavenadmin/domain/usecase/get_list_admin.dart';
import 'package:wavenadmin/domain/usecase/get_list_booking.dart';
import 'package:wavenadmin/domain/usecase/get_list_photographer.dart';
import 'package:wavenadmin/domain/usecase/get_list_schedule.dart';
import 'package:wavenadmin/domain/usecase/get_list_user.dart';
import 'package:wavenadmin/domain/usecase/get_package_dropdown.dart';
import 'package:wavenadmin/domain/usecase/get_package_list.dart';
import 'package:wavenadmin/domain/usecase/get_photographer_dropdown.dart';
import 'package:wavenadmin/domain/usecase/get_token.dart';
import 'package:wavenadmin/domain/usecase/get_universitas_list.dart';
import 'package:wavenadmin/domain/usecase/get_university_detail.dart';
import 'package:wavenadmin/domain/usecase/get_university_dropdown.dart';
import 'package:wavenadmin/domain/usecase/post_login.dart';
import 'package:wavenadmin/domain/usecase/post_logout.dart';
import 'package:wavenadmin/domain/usecase/put_detail_admin.dart';
import 'package:wavenadmin/domain/usecase/put_detail_fotografer.dart';
import 'package:wavenadmin/domain/usecase/update_booking.dart';
import 'package:wavenadmin/domain/usecase/create_transaction_usecase.dart';
import 'package:wavenadmin/domain/usecase/update_package.dart';
import 'package:wavenadmin/domain/usecase/upload_edited_photo_usecase.dart';
import 'package:wavenadmin/domain/usecase/upload_photo_result_usecase.dart';
import 'package:wavenadmin/domain/usecase/verify_batch_booking.dart';
import 'package:wavenadmin/domain/usecase/verify_booking_usecase.dart';
import 'package:wavenadmin/domain/usecase/verify_transaction_usecase.dart';
import 'package:wavenadmin/domain/usecase/save_file_mover_history.dart';
import 'package:wavenadmin/domain/usecase/get_file_mover_histories.dart';
import 'package:wavenadmin/domain/usecase/clear_file_mover_history.dart';
import 'package:wavenadmin/persentation/cubit/auth_cubit.dart';
import 'package:http/http.dart'as http;
import 'package:wavenadmin/persentation/riverpod/notifier/admin/admin_list_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/user/user_list_notifier.dart';
import 'package:wavenadmin/persentation/route/approuter.dart';
import 'package:wavenadmin/domain/repository/dasboard_repository.dart';


final GetIt locator = GetIt.instance;
Future<void> init(GetIt locator)async{
  //cubit
  locator.registerLazySingleton(() => AuthCubit(locator(), getToken: locator(), postLogout: locator()),);
  //riverpod
  locator.registerFactory(() => UserListNotifier(locator()),);
  locator.registerFactory(() => AdminListNotifier(getListAdmin: locator()),);
  
  //usecase
  locator.registerLazySingleton(() => PostLogin(locator()),);
  locator.registerLazySingleton(() => PostLogout(locator()),);
  locator.registerLazySingleton(() => GetToken(locator()),);
  locator.registerLazySingleton(() => GetListUser(locator()),);
  locator.registerLazySingleton(() => GetListAdmin(locator()),);
  locator.registerLazySingleton(() => GetDetailAdmin(locator()),);
  locator.registerLazySingleton(() => PutDetailAdmin(locator()),);
  locator.registerLazySingleton(() => CreateAdmin(locator()),);
  locator.registerLazySingleton(() => DeleteAdmin(locator()),);
  locator.registerLazySingleton(() => GetDetailUser(locator()),);
  locator.registerLazySingleton(() => GetListPhotographer(locator()),);
  locator.registerLazySingleton(() => PutDetailFotografer(locator()),);
  locator.registerLazySingleton(() => GetDetailFotografer(locator()),);
  locator.registerLazySingleton(() => DeleteFotografer(locator()),);
  locator.registerLazySingleton(() => GetListBooking(locator()),);
  locator.registerLazySingleton(() => GetDetailBooking(locator()),);
  locator.registerLazySingleton(() => UpdateBooking(locator()),);
  locator.registerLazySingleton(() => CreateBookingUsecase(locator()),);
  locator.registerLazySingleton(() => VerifyBookingUsecase(locator()),);
  locator.registerLazySingleton(() => VerifyTransactionUsecase(locator()));
  locator.registerLazySingleton(() => VerifyBatchBooking(locator()),);
  locator.registerLazySingleton(() => CreateTransactionUsecase(locator()),);
  locator.registerLazySingleton(() => UploadPhotoResultUsecase(locator()),);
  locator.registerLazySingleton(() => UploadEditedPhotoUsecase(locator()),);
  locator.registerLazySingleton(() => GetListAddons(locator()),);
  locator.registerLazySingleton(() => GetAddonDetail(locator()),);
  locator.registerLazySingleton(() => UpdateAddon(locator()),);
  locator.registerLazySingleton(() => CreateAddon(locator()),);
  locator.registerLazySingleton(() => DeleteAddon(locator()),);
  locator.registerLazySingleton(() => GetPackageDropdown(locator()),);
  locator.registerLazySingleton(() => GetPhotographerDropdown(locator()),);
  locator.registerLazySingleton(() => GetUniversityDropdown(locator()),);
  locator.registerLazySingleton(() => GetUniversitasList(locator()),);
  locator.registerLazySingleton(() => GetUniversityDetail(locator()),);
  locator.registerLazySingleton(() => UpdateUniversity(locator()),);
  locator.registerLazySingleton(() => CreateUniv(locator()),);
  locator.registerLazySingleton(() => DeleteUniv(locator()),);
   locator.registerLazySingleton(() => GetPackageList(locator()),);
  locator.registerLazySingleton(() => GetListSchedule(locator()),);
  locator.registerLazySingleton(() => UpdatePackage(locator()),);
  locator.registerLazySingleton(() => CreatePackage(locator()),);
  locator.registerLazySingleton(() => DeletePackage(locator()),);
  locator.registerLazySingleton(() => GetAddonsDropdown(locator()),);
  locator.registerLazySingleton(() => GetPhotographerPaymentList(locator()),);
  locator.registerLazySingleton(() => GetPhotographerDetail(locator()),);
  locator.registerLazySingleton(() => GetPhotographerBookings(locator()),);
  locator.registerLazySingleton(() => GetPengaturan(locator()),);
  locator.registerLazySingleton(() => UpdatePengaturan(locator()),);
  locator.registerLazySingleton(() => CreateFotografer(locator()),);
  locator.registerLazySingleton(() => DeleteUser(locator()),);
  locator.registerLazySingleton(() => DeleteBatchUser(locator()),);
  locator.registerLazySingleton(() => GetDashboard(locator()),);
  locator.registerLazySingleton(() => DeletePorto(locator()),);
  locator.registerLazySingleton(() => GetPorto(locator()),);
  locator.registerLazySingleton(() => CreatePorto(locator()),);
  // File Mover Use Cases
  locator.registerLazySingleton(() => SaveFileMoverHistory(locator()),);
  locator.registerLazySingleton(() => GetFileMoverHistories(locator()),);
  locator.registerLazySingleton(() => ClearFileMoverHistory(locator()),);
  
  //repository
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryimpl(locator(), localData: locator()),);
  locator.registerLazySingleton<UserRepositoty>(() => UserRepositoryImpl(locator(), locator()),);
  locator.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl(locator()),);
  locator.registerLazySingleton<AddonsRepository>(() =>AddonsRepositoryImpl(locator()) ,);
  locator.registerLazySingleton<PackageRepository>(() => PackageRepositoryImpl(locator()),);
  locator.registerLazySingleton<ReferensiRepository>(() => ReferensiRepositoryImpl(locator()),);
  locator.registerCachedFactory<UniversityRepository>(() => UniversityRepositoryImpl(locator()),);
  locator.registerLazySingleton<FileMoverRepository>(() => FileMoverRepositoryImpl(locator()),);
  locator.registerLazySingleton<PhotographerPaymentRepository>(() => PhotographerPaymentRepositoryImpl(remoteData: locator()),);
  locator.registerLazySingleton<PengaturanRepository>(() => PengaturanRepositoryImpl(locator()),);
  locator.registerLazySingleton<DasboardRepository>(() => DashboardRepositoryImpl(locator()),);

  //datasource
  locator.registerLazySingleton<AddonRemoteDataSource>(() => AddonRemoteDataSourceImpl(locator()),);
  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(locator(), locator()),);
  locator.registerLazySingleton<BookingRemoteDataSource>(() => BookingRemoteDataSourceImpl(locator()),);
  locator.registerLazySingleton<DashboardRemoteDataSource>(() => DashboardRemoteDataSourceImpl(locator()),);
  locator.registerLazySingleton<PackageRemoteDataSource>(() => PackageRemoteDataSourceImpl(locator()),);
  locator.registerLazySingleton<PengaturanRemoteDataSource>(() => PengaturanRemoteDataSourceImpl(locator()),);
  locator.registerLazySingleton<PhotographerRemoteDataSource>(() => PhotographerRemoteDataSourceImpl(locator()),);
  locator.registerLazySingleton<UniversityRemoteDataSource>(() => UniversityRemoteDataSourceImpl(locator()),);
  locator.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(locator()),);
  locator.registerLazySingleton<LocalData>(() =>LocalDataImpl(locator()) ,);
  locator.registerLazySingleton(() => FileMoverLocalDataSource(locator()),);

  //http
  locator.registerLazySingleton(() => http.Client());

  //secure storage
  locator.registerLazySingleton(() => FlutterSecureStorage());

  //dio client
  locator.registerLazySingleton(() => DioClient(locator(),onUnauthorized: () {
    locator<AuthCubit>().logOut();
  },),);
  //dio
  locator.registerLazySingleton<Dio>(() =>Dio() ,);
  //router
  locator.registerLazySingleton<Approuter>(() => Approuter(),);
}