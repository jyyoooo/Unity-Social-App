import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unitysocial/features/auth/data/models/sign_up_model.dart';
import 'package:unitysocial/features/auth/data/models/user_model.dart';

class UserRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(SignUpModel userProfile) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    log(user?.email?.toString() ?? 'no user');
    UserProfile newUser = UserProfile(
        uid: user?.uid,
        userName: userProfile.name,
        email: userProfile.email,
        gender: '',
        profilePhoto: '',
        mobile: '',
        badges: [],
        location: '',
        token: '');

    await firestore.collection('users').doc().set(newUser.toMap());
  }
}
