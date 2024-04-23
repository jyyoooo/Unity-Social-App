import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unitysocial/features/donation/data/models/donation_model.dart';
import 'package:unitysocial/features/notifications/data/notification_model.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class DonationRepository {
  final donations = FirebaseFirestore.instance.collection('postDonations');
  final notifications = FirebaseFirestore.instance.collection('notifications');

  final userId = FirebaseAuth.instance.currentUser!.uid;

  addDonation({required RecruitmentPost post, required String amount}) async {
    log('in add donation');
    final donation = Donation(
      postId: post.id!,
      userId: userId,
      amount: num.parse(amount),
      donatedTo: post.title,
      createdAt: DateTime.now(),
    );
    final postRef = donations.doc(post.id);
    final postDoc = await postRef.get();

    if (!postDoc.exists) {
      await postRef.set({
        'postId': post.id,
        'postTitle': post.title,
      });
    }

    try {
      await postRef.collection('donations').add(donation.toMap());
      await sendDonationNotification(post, donation.amount);
      log('donation added');
    } catch (e) {
      log('add donation err: $e');
    }
  }

  sendDonationNotification(RecruitmentPost post, num amount) {
    final notification = UnityNotification(
        recepientId: post.host,
        title: 'Donation received',
        description: '$amount donation receieved to ${post.title}');
    notifications.add(notification.toMap());
  }

  Future<List<Donation>> fetchPostDonations(String postId) async {
    try {
      final querySnapshot = await donations
          .doc(postId)
          .collection('donations')
          .orderBy('createdAt', descending: true)
          .get();

      final donationsList =
          querySnapshot.docs.map((doc) => Donation.fromMap(doc)).toList();

      return donationsList;
    } catch (e) {
      log('fetch donations err: $e');
      return [];
    }
  }

  Future<double> totalPostDonations(String postId) async {
    try {
      final querySnapshot = await donations
          .doc(postId)
          .collection('donations')
          .orderBy('createdAt', descending: true)
          .get();

      final donationsList =
          querySnapshot.docs.map((doc) => Donation.fromMap(doc)).toList();

      final totalAmount =
          donationsList.fold<double>(0, (prev, curr) => prev + curr.amount);

      return totalAmount;
    } catch (e) {
      log('fetch donations err: $e');
      return 0.0;
    }
  }

  Future<List<Donation>> fetchUserDonations(String userId) async {
    try {
      final querySnapshot = await donations.get();

      final List<Donation> userDonations = [];

      for (final doc in querySnapshot.docs) {
        final subCollectionSnapshot = await doc.reference
            .collection('donations')
            .where('userId', isEqualTo: userId)
            .get();

        final donationsList = subCollectionSnapshot.docs
            .map((doc) => Donation.fromMap(doc))
            .toList();

        userDonations.addAll(donationsList);
      }

      return userDonations;
    } catch (e) {
      log('fetch user donations err: $e');
      return [];
    }
  }
}
