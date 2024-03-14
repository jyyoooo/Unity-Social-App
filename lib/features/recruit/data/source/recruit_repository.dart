import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/features/recruit/data/models/badge_model.dart';

class RecruitRepository {
  final badgeCollection = FirebaseFirestore.instance.collection('badges');

  Future<List<AchievementBadge>> fetchAllBadges() async {
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
}
