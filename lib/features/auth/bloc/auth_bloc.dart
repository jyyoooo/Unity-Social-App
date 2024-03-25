import 'dart:async';
import 'dart:developer';
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
  final emailController = TextEditingController();
  AuthBloc() : super(AuthInitialState()) {
    on<SignUpEvent>(signUpEvent);
    on<LoginEvent>(loginEvent);
    on<VerifyEmailEvent>(verifyEmailEvent);
    on<GoogleSignUpEvent>(googleSignUpEvent);
    on<PasswordResetEvent>(passwordResetEvent);
    on<LogoutEvent>(logoutEvent);
    on<AppStartEvent>(appStartEvent);
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
    if (authStatus == AuthenticationStatus.signUpSuccess) {
      final userName = await AuthRepository().getUserName();
      emit(LoginSuccesState(authStatus: authStatus, userName: userName));
    } else {
      emit(AuthErrorState(authStatus: authStatus));
    }
  }

  FutureOr<void> appStartEvent(
      AppStartEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitialState());
    log('in app start');
    final isUserLoggedIn = await AuthRepository().checkForActiveUser();
    if (isUserLoggedIn) {
      final userName = await AuthRepository().getUserName();
      emit(UserFoundState(userName: userName));
    } else {
      emit(NoUserState());
    }
  }

  FutureOr<void> verifyEmailEvent(
      VerifyEmailEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> googleSignUpEvent(
      GoogleSignUpEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> passwordResetEvent(
      PasswordResetEvent event, Emitter<AuthState> emit) {}

  FutureOr<void> logoutEvent(LogoutEvent event, Emitter<AuthState> emit) {}
}
