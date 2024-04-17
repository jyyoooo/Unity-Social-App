import 'package:cloud_firestore/cloud_firestore.dart';

class PostDonations {
  String postId;
  String postTitle;
  PostDonations({
    required this.postId,
    required this.postTitle,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'postTitle': postTitle,
    };
  }

  factory PostDonations.fromMap(DocumentSnapshot doc) {
    return PostDonations(
      postId: doc.id,
      postTitle: doc['postTitle'] as String,
    );
  }
}
