// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AppStartEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final SignUpModel user;

  SignUpEvent({required this.user});
}

class CreateUserEvent extends AuthEvent {
  final UserProfile user;
  CreateUserEvent({required this.user});
}

class LoginEvent extends AuthEvent {
  final Login login;
  LoginEvent(this.login);
}

class VerifyEmailEvent extends AuthEvent {}

class GoogleSignUpEvent extends AuthEvent {}

class PasswordResetEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
