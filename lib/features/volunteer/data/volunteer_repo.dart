import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class VolunteerRepository {
  final postsCollection = FirebaseFirestore.instance.collection('posts');

  Future<String> addNewVolunteer(
      String volunteerId, RecruitmentPost post) async {
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
        return 'Successfully joined ${post.title} team';
      } else {
        return 'Maximum members reached';
      }
    } else {
      return 'You are already a member of ${post.title}';
    }
  }
}
