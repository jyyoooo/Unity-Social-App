import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class PostsRepository {
  final collection = FirebaseFirestore.instance.collection('posts');

  Future<List<RecruitmentPost>> fetchAllPostsFromCategory(
      String category) async {
    try {
      log('searching $category');
      final QuerySnapshot<Map<String, dynamic>> allPosts =
          await collection.where('category', isEqualTo: category).get();

      final List<RecruitmentPost> postsFromCategory =
          allPosts.docs.map((post) => RecruitmentPost.fromMap(post)).toList();
      return postsFromCategory;
    } catch (e) {
      log(e.toString());
      return <RecruitmentPost>[];
    }
  }
}
