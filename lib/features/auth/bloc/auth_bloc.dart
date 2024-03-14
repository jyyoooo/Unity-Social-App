import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/enums/auth_status.dart';
import 'package:unitysocial/features/auth/data/models/login_model.dart';
import 'package:unitysocial/features/auth/data/models/sign_up_model.dart';
import 'package:unitysocial/features/auth/data/models/user_model.dart';
import 'package:unitysocial/features/auth/data/repository/auth_repo.dart';

part 'auth_events.dart';
part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final signUpformKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  AuthBloc() : super(AuthInitialState()) {
    on<SignUpEvent>(signUpEvent);
    on<LoginEvent>(loginEvent);
    on<VerifyEmailEvent>(verifyEmailEvent);
    on<GoogleSignUpEvent>(googleSignUpEvent);
    on<PasswordResetEvent>(passwordResetEvent);
    on<LogoutEvent>(logoutEvent);
  }
  FutureOr<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    AuthenticationStatus authStatus =
        await AuthRepository().signUpWithEmail(event.user);
    authStatus == AuthenticationStatus.signUpSuccess
        ? emit(AuthSuccessState(authStatus: authStatus))
        : emit(AuthErrorState(authStatus: authStatus));
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    AuthenticationStatus authStatus =
        await AuthRepository().signInWithEmail(login: event.login);
    authStatus == AuthenticationStatus.signUpSuccess
        ? emit(LoginSuccesState(authStatus: authStatus))
        : emit(AuthErrorState(authStatus: authStatus));
  }

  FutureOr<void> verifyEmailEvent(
      VerifyEmailEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> googleSignUpEvent(
      GoogleSignUpEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> passwordResetEvent(
      PasswordResetEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> logoutEvent(LogoutEvent event, Emitter<AuthState> emit) {}
}
