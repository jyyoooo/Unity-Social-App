import 'dart:developer';

import 'package:unitysocial/core/enums/auth_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unitysocial/features/auth/data/models/login_model.dart';
import 'package:unitysocial/features/auth/data/models/sign_up_model.dart';
import 'package:unitysocial/features/auth/data/repository/user_repo.dart';

class AuthRepository {
  UserRepository userRepo = UserRepository();
  Future<AuthenticationStatus> signUpWithEmail(SignUpModel user) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password);
      log('suxsful auth');

      // credential.user!.sendEmailVerification();

      await userRepo.addUser(user);
      log('user created');

      log(credential.user!.email!);
      return AuthenticationStatus.signUpSuccess;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return AuthenticationStatus.emailAlreadyExists;
        case 'invalid-email':
          return AuthenticationStatus.invalidEmail;
        case 'weak-password':
          return AuthenticationStatus.weakPassword;
        default:
          return AuthenticationStatus.error;
      }
    } catch (e) {
      log(e.toString());
      return AuthenticationStatus.error;
    }
  }

  Future<AuthenticationStatus> signInWithEmail({required Login login}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: login.email, password: login.password);
      return AuthenticationStatus.signUpSuccess;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        return AuthenticationStatus.userNotFound;
      } else if (e.code == 'wrong-password') {
        return AuthenticationStatus.wrongPassword;
      } else {
        return AuthenticationStatus.error;
      }
    } catch (e) {
      return AuthenticationStatus.error;
    }
  }

  Future<bool> checkForActiveUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
