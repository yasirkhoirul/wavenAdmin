
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:wavenadmin/data/auth_repositoryimpl.dart';
import 'package:wavenadmin/data/datasource/dio.dart';
import 'package:wavenadmin/data/datasource/local_data.dart';
import 'package:wavenadmin/data/datasource/remote_data.dart';
import 'package:wavenadmin/data/user_repository_impl.dart';
import 'package:wavenadmin/domain/repository/auth_repository.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';
import 'package:wavenadmin/domain/usecase/get_detail_admin.dart';
import 'package:wavenadmin/domain/usecase/get_list_admin.dart';
import 'package:wavenadmin/domain/usecase/get_list_user.dart';
import 'package:wavenadmin/domain/usecase/get_token.dart';
import 'package:wavenadmin/domain/usecase/post_login.dart';
import 'package:wavenadmin/domain/usecase/post_logout.dart';
import 'package:wavenadmin/persentation/cubit/auth_cubit.dart';
import 'package:http/http.dart'as http;
import 'package:wavenadmin/persentation/riverpod/notifier/admin_list_notifier.dart';
import 'package:wavenadmin/persentation/riverpod/notifier/user_list_notifier.dart';
import 'package:wavenadmin/persentation/route/approuter.dart';


final GetIt locator = GetIt.instance;
Future<void> init(GetIt locator)async{
  //cubit
  locator.registerFactory(() => AuthCubit(locator(), getToken: locator(), postLogout: locator()),);
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
  
  //repository
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryimpl(locator(), localData: locator()),);
  locator.registerLazySingleton<UserRepositoty>(() => UserRepositoryImpl(locator()),);

  //datasource
  locator.registerLazySingleton<RemoteData>(() =>RemoteDataImpl(locator(), locator()) ,);
  locator.registerLazySingleton<LocalData>(() =>LocalDataImpl(locator()) ,);

  //http
  locator.registerLazySingleton(() => http.Client());

  //secure storage
  locator.registerLazySingleton(() => FlutterSecureStorage());

  //dio client
  locator.registerLazySingleton(() => DioClient(locator()),);
  //dio
  locator.registerLazySingleton<Dio>(() =>Dio() ,);
  //router
  locator.registerLazySingleton<Approuter>(() => Approuter(),);
}