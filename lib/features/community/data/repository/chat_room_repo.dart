import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unitysocial/features/community/data/models/chat_room_model.dart';
import 'package:unitysocial/features/home/data/source/posts_repo.dart';
import 'package:unitysocial/features/push_notification/push_notification_service.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class ChatRoomRepo {
  final allPosts = PostsRepository().postsCollection;
  final currentUser = FirebaseAuth.instance.currentUser;
  final chatroomsRef = FirebaseFirestore.instance.collection('chatrooms');

  Stream<List<ChatRoom>> fetchChatRooms() async* {
    try {
      // fetching chatrooms and converting them into a list of ChatRoom objects
      yield* chatroomsRef.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => ChatRoom.fromMap(doc))
            .where((room) =>
                room.members!.contains(currentUser!.uid) ||
                room.admin == currentUser!.uid)
            .toList();
      });
    } catch (e) {
      log(e.toString());
      yield [];
    }
  }

  void addMemberToChatRoom(String roomId, String memberId) async {
    // user is added to the chatroom when they join as a volunteer
    try {
      //testing notification subsctiption
      await PushNotificationService.subscribeToTopic(roomId);
      final room = chatroomsRef.doc(roomId);
      room.get().then((doc) async {
        if (doc.exists) {
          log('Adding new member to chatroom');
          await room.update({
            'members': FieldValue.arrayUnion([memberId])
          });
        }
      });
    } catch (e) {
      log('add member error: $e');
    }
  }

  Future<RecruitmentPost> getPostDetails(ChatRoom room) async {
    final post = await PostsRepository().postsCollection.doc(room.postId).get();
    log(post.data().toString());
    return RecruitmentPost.fromMap(post);
  }
}
