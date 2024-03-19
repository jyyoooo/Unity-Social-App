import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class SearchRepository {
  final allPosts = FirebaseFirestore.instance.collection('posts');

  Future<List<RecruitmentPost>> searchThisQuery(String query) async {
    log('querying $query');
    try {
      return await allPosts
          .where('title', isGreaterThanOrEqualTo: query)
          // .where('isApproved', isEqualTo: true)
          .get()
          .then((snapshot) => snapshot.docs
              .map((post) => RecruitmentPost.fromMap(post))
              .toList());
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
