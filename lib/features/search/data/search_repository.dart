import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/core/enums/search_filters.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class SearchRepository {
  final allPosts = FirebaseFirestore.instance.collection('posts');

  Future<List<RecruitmentPost>> searchThisQuery(String queryString) async {
    log('querying $queryString');
    try {
      final queryResults = await allPosts
          .where('isApproved', isEqualTo: true)
          .where('title', isGreaterThanOrEqualTo: queryString)
          .get()
          .then((snapshot) => snapshot.docs
              .map((post) => RecruitmentPost.fromMap(post))
              .toList());
      log('query results: $queryResults');
      return queryResults;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<RecruitmentPost>> filterByDuration(
      DurationFilter durationFilter) async {
    try {
      DateTime startDate;
      DateTime endDate;

      QuerySnapshot querySnapshot =
          await allPosts.where('isApproved', isEqualTo: true).get();
      List<RecruitmentPost> filteredPosts = [];

      for (final snapshot in querySnapshot.docs) {
        RecruitmentPost post = RecruitmentPost.fromMap(snapshot);
        startDate = post.duration.start;
        endDate = post.duration.end;

        if (durationFilter == DurationFilter.oneDay) {
          if (!endDate.isBefore(DateTime.now())) {
            if (endDate.difference(startDate).inDays <= 1) {
              filteredPosts.add(post);
            }
          }
        } else if (durationFilter == DurationFilter.lessThanWeek) {
          if (!endDate.isBefore(DateTime.now())) {
            if (endDate.difference(startDate).inDays <= 7 &&
                endDate.difference(startDate).inDays > 1) {
              filteredPosts.add(post);
            }
          }
        } else if (durationFilter == DurationFilter.moreThanWeek) {
          if (!endDate.isBefore(DateTime.now())) {
            if (endDate.difference(startDate).inDays <= 30 &&
                endDate.difference(startDate).inDays > 7) {
              filteredPosts.add(post);
            }
          }
        }
      }

      return filteredPosts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
