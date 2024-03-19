import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/features/recruit/data/models/badge_model.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class RecruitRepository {
  final badgeCollection = FirebaseFirestore.instance.collection('badges');
  final postsCollection = FirebaseFirestore.instance.collection('posts');

  Future<List<AchievementBadge>> fetchAllBadges(String? filter) async {
    try {
      final allBadges = await badgeCollection.get();
      return allBadges.docs
          .map((badge) => AchievementBadge.fromMap(badge))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  sendPostForApproval(RecruitmentPost data) async {
    try {
      await postsCollection.add(data.toMap());
      return 'success';
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }
}
