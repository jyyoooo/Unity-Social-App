import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/features/auth/bloc/auth_bloc.dart';

bool isEmailValid(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegex.hasMatch(email);
}

bool isPasswordValid(String password) {
  return password.length >= 8;
}

bool isUsernameValid(String username) {
  final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
  return usernameRegex.hasMatch(username);
}

validation(Function function, String input) {
  if (function == isEmailValid) {
    return isEmailValid(input);
  } else if (function == isPasswordValid) {
    return isPasswordValid(input);
  } else if (function == isUsernameValid) {
    return isUsernameValid(input);
  } else{
    return true;
  }
}

validationResult(Function function) {
  if (function == isEmailValid) {
    return 'Please enter a valid email';
  }  else if (function == isPasswordValid) {
    return 'password should contain atleast 8 characters';
  } else if (function == isUsernameValid) {
    return 'Username can only contain letters, numbers, and underscores';
  }else{
    return 'field cannot be empty';
  }
}

String getProviderForCurrentUser() {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null && user.providerData.isNotEmpty) {
    String primaryProvider = user.providerData[0].providerId;
    if (primaryProvider == 'google.com') {
      return 'Google Provider';
    } else {
      return 'Email/Password Provider';
    }
  } else {
    return 'No associated providers';
  }
}

String fieldIsEmpty(TextEditingController controller, context) {
  final provider = BlocProvider.of<AuthBloc>(context);
  if (provider.emailController == controller) {
    return 'email is required';
  } else if (provider.confirmPasswordController == controller) {
    return 'confirm your password';
  } else if (provider.passwordController == controller) {
    return 'password is required';
  } else if (provider.nameController == controller) {
    return 'name is required';
  } else {
    return 'field cannot be empty';
  }
}
