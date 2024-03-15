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
  LoginSuccesState({required this.authStatus});
}

class UserState extends AuthState {}

class EmailVerifiedState extends AuthState {}

class PasswordResetSuccessState extends AuthState {}

class LogoutSuccessState extends AuthState {}

class UserFoundState extends AuthState {}

class NoUserState extends AuthState {}
