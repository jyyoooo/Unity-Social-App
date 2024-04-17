import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/features/community/data/repository/chat_room_repo.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class VolunteerRepository {
  final postsCollection = FirebaseFirestore.instance.collection('posts');

  Future<String> addNewVolunteer(
      String volunteerId, RecruitmentPost post) async {
    log('in add new volunteer');
    try {
      final db = FirebaseFirestore.instance;
      final docRef = db.collection('posts').doc(post.id.toString());

      final snapshot = await docRef.get();
      final existingList =
          (snapshot.get('members') as List<dynamic>?)?.cast<String>();

      if (existingList == null || !existingList.contains(volunteerId)) {
        // Check if the number of members has not reached maxMembers
        if (existingList == null || existingList.length < post.maximumMembers) {
          await docRef.update({
            'members': FieldValue.arrayUnion([volunteerId])
          });
          ChatRoomRepo().addMemberToChatRoom(post.id!, volunteerId);
          return 'Successfully joined ${post.title} team';
        } else {
          return 'Maximum members reached';
        }
      } else {
        return 'You are already a member of ${post.title}';
      }
    } catch (e) {
      log('add volunteer error: $e');
      return '';
    }
  }

  getVolunteeredCauses(String volunteerId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('posts')
              .where('members', arrayContains: volunteerId)
              .get();

      final posts =
          querySnapshot.docs.map((post) => RecruitmentPost.fromMap(post));
      log(posts.map((e) => e.badges.length).toString());
      return posts.where((post) => post.duration.end.isBefore(DateTime.now())).toList();
    } catch (e) {
      log('Error fetching volunteered causes: $e');
      return [];
    }
  }
}
