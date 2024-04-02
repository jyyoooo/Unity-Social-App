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
      final allUserProjects = allUserPosts.docs
          .map((post) => RecruitmentPost.fromMap(post))
          .toList();
      return allUserProjects;
    } catch (e) {
      log('ProjectRepoError: ${e.toString()}');
    }
  }

  // Future<void> updateProject(String postId,
  //     {DateTimeRange? updatedDateRange, String? updatedLocation}) async {
  //   try {
  //     DocumentReference projectRef = projectsCollection.doc(postId);

  //     // Create a map to hold the fields to update
  //     Map<String, dynamic> updateData = {};

  //     // Update date range if it's not null
  //     if (updatedDateRange != null) {
  //       updateData['duration'] = {
  //         'start': updatedDateRange.start,
  //         'end': updatedDateRange.end,
  //       };
  //     }

  //     // Update location if it's not null
  //     if (updatedLocation != null) {
  //       updateData['location'] = updatedLocation;
  //     }
  //     log('logging daterange: $updatedDateRange');
  //     log('logging location: $updatedLocation');
  //     log('logging repo: $updateData');

  //     // Update the document with the fields that have changed
  //     await projectRef.update(updateData);
  //   } catch (e) {
  //     log('UpdateProjectError: ${e.toString()}');
  //   }
  // }
}
