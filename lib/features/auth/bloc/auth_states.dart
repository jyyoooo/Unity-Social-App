// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final AuthenticationStatus authStatus;
  AuthErrorState({required this.authStatus});
}

class AuthSuccessState extends AuthState {
  final AuthenticationStatus authStatus;
  AuthSuccessState({required this.authStatus});
}

class LoginSuccesState extends AuthState {
  final AuthenticationStatus authStatus;
  final String userName;
  LoginSuccesState({
    required this.authStatus,
    required this.userName,
  });
}

class UserState extends AuthState {}

class EmailVerifiedState extends AuthState {}

class PasswordResetSuccessState extends AuthState {}

class LogoutSuccessState extends AuthState {}

class UserFoundState extends AuthState {
  final String userName;
  UserFoundState({required this.userName});
}

class NoUserState extends AuthState {}
