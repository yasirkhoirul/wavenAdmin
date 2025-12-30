import 'package:equatable/equatable.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/user_fotografer.dart';

class PhotographerCreateState extends Equatable{
  final UserFotografer data;
  final RequestState requestState;
  final String username;
  final String password;
  final String email;
  const PhotographerCreateState({this.data = const UserFotografer(id: '', name: '', isActive: false), this.username = '', this.password = '', this.email = '',this.requestState = RequestState.init});


  PhotographerCreateState copyWith(
    {UserFotografer? data,
   String? username,
   String? password,
   String? email,
   RequestState? request
   }
  ){
    return PhotographerCreateState(data:  data??this.data,username:  username??this.username,password:  password??this.username,email:  email??this.email,requestState: request??requestState);
  }

  @override
  List<Object?> get props => [data,username,password,email,requestState];
}