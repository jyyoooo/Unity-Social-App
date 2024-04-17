// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Donation {
  String postId;
  String userId;
  String? donationId;
  num amount;
  String donatedTo;
  DateTime createdAt;
  Donation({
    required this.postId,
    required this.userId,
    this.donationId,
    required this.amount,
    required this.donatedTo,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'userId': userId,
      'donationId': donationId,
      'amount': amount,
      'donatedTo': donatedTo,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Donation.fromMap(DocumentSnapshot doc) {
    return Donation(
      donationId: doc.id,
      postId: doc['postId'] as String,
      userId: doc['userId'] as String,
      amount: doc['amount'] as num,
      donatedTo: doc['donatedTo'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(doc['createdAt'] as int),
    );
  }
}
