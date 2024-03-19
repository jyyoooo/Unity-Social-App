import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/features/recruit/data/models/badge_model.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class PostsRepository {
  final postsCollection = FirebaseFirestore.instance.collection('posts');
  final badgesCollection = FirebaseFirestore.instance.collection('badges');

  Future<List<RecruitmentPost>> fetchAllPostsFromCategory(
      String category) async {
    try {
      log('searching $category');
      final QuerySnapshot<Map<String, dynamic>> allPosts = await postsCollection
          .where('category', isEqualTo: category)
          .where('isApproved', isEqualTo: true)
          .get();

      final List<RecruitmentPost> postsFromCategory =
          allPosts.docs.map((post) => RecruitmentPost.fromMap(post)).toList();
      return postsFromCategory;
    } catch (e) {
      log(e.toString());
      return <RecruitmentPost>[];
    }
  }

  Future<List<AchievementBadge>> fetchPostBadges(List<String> allBadges) async {
    List<AchievementBadge> postBadges = [];
    for (String badgeId in allBadges) {
      final snapshot = await badgesCollection.doc(badgeId).get();
      postBadges.add(AchievementBadge.fromMap(snapshot));
    }
    return postBadges;
  }
}
