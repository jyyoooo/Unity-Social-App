import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/core/enums/search_filters.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class SearchRepository {
  final allPosts = FirebaseFirestore.instance.collection('posts');

  Future<List<RecruitmentPost>> searchThisQuery(String queryString) async {
    final query = queryString.toLowerCase();
    log('querying $query');
    try {
      return await allPosts
          .orderBy('title')
          .startAt([query])
          .endAt(['$query\uf8ff'])
          .where('isApproved', isEqualTo: true)
          // .where('title', isGreaterThanOrEqualTo: query)
          .get()
          .then((snapshot) => snapshot.docs
              .map((post) => RecruitmentPost.fromMap(post))
              .toList());
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<RecruitmentPost>> filterByDuration(DurationFilter durationFilter) async {
  try {
    // Define the filters based on the enum
    DateTime now = DateTime.now();
    DateTime startDate;
    DateTime endDate;

    switch (durationFilter) {
      case DurationFilter.oneDay:
        startDate = now.subtract(const Duration(days: 1));
        endDate = now;
        break;
      case DurationFilter.lessThanWeek:
        startDate = now.subtract(const Duration(days: 7));
        endDate = now;
        break;
      case DurationFilter.moreThanWeek:
        startDate = now.subtract(const Duration(days: 7));
        endDate = now.add(const Duration(days: 7));
        break;
    }

    // Query Firestore for posts that intersect with the date range
    QuerySnapshot querySnapshot = await allPosts
        .where('duration.dateRange.start', isLessThan: endDate)
        .where('duration.dateRange.end', isGreaterThan: startDate)
        .get();

    // Process the query results and return the list of RecruitmentPost objects
    List<RecruitmentPost> posts = querySnapshot.docs
        .map((doc) => RecruitmentPost.fromMap(doc))
        .toList();

    return posts;
  } catch (e) {
    log(e.toString());
    // Return an empty list or handle the error as needed
    return [];
  }
}


}
