part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final SignUpModel user;

  SignUpEvent({required this.user});
}

class LoginEvent extends AuthEvent {}

class VerifyEmailEvent extends AuthEvent {}

class GoogleSignUpEvent extends AuthEvent {}

class PasswordResetEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
