import 'dart:developer';

import 'package:unitysocial/core/enums/auth_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unitysocial/features/auth_feature/data/models/sign_up_model.dart';

class AuthRepository {
  Future<AuthenticationStatus> verifyEmail() {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }

  Future<AuthenticationStatus> signUpWithEmail(SignUpModel user) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email, password: user.password);

      // credential.user!.sendEmailVerification();
      log('success auth');
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

  Future<AuthenticationStatus> signInWithEmail() {
    // TODO: implement signInWithEmail
    throw UnimplementedError();
  }

  void deleteUser() {
    // TODO: implement deleteUser
  }
  Future<AuthenticationStatus> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  Future<String> passwordReset({required String email}) {
    // TODO: implement passwordReset
    throw UnimplementedError();
  }

  sendEmailForVerification() async {
    throw UnimplementedError();
  }
}
