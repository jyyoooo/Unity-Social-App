import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class ProjectRepo {
  final CollectionReference projectsCollection =
      FirebaseFirestore.instance.collection('posts');

  fetchUserProjects(String hostId) async {
    try {
      final allUserPosts =
          await projectsCollection.where('host', isEqualTo: hostId).get();
      final allUserProjects =
          allUserPosts.docs.map((post) => RecruitmentPost.fromMap(post)).toList();
      return allUserProjects;
    } catch (e) {
      log('ProjectRepoError: ${e.toString()}');
    }
  }

  requestUpdateProject() async {}
}
