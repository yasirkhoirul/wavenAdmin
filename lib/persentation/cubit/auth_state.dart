part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthLogout extends AuthState {}
final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
final class AuthSucces extends AuthState {}
final class AuthRedirectGoogle extends AuthState {}
