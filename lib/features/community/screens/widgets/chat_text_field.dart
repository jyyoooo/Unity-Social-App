import 'dart:developer';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/features/community/data/models/chat_room_model.dart';
import 'package:unitysocial/features/community/data/models/message_model.dart';
import 'package:unitysocial/features/community/data/repository/chat_repo.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({Key? key, required this.room}) : super(key: key);
  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    // final focusNode = FocusNode();
    final TextEditingController chatController = TextEditingController();
    final senderId = FirebaseAuth.instance.currentUser!.uid;
    return SafeArea(
      bottom: true,
      child: ClipPath(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 60),
            padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.5),
              border: const Border(
                top: BorderSide(
                  color: CupertinoColors.lightBackgroundGray,
                ),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    // focusNode: focusNode,
                    // onTap: () {
                    //   if (!focusNode.hasFocus) {
                    //     focusNode.requestFocus();
                    //   }
                    // },
                    controller: chatController,
                    maxLines: 5,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.only(right: 42, left: 16, top: 15),
                      hintStyle: const TextStyle(color: Colors.grey),
                      hintText: 'Message',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: .5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: .5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                // send button
                Positioned(
                  right: 2,
                  top: 2,
                  child: IconButton(
                    icon: const Icon(
                      CupertinoIcons.arrow_up_circle_fill,
                      color: CupertinoColors.systemBlue,
                    ),
                    onPressed: () {
                      log(chatController.text);
                      if (chatController.text.isNotEmpty) {
                        final message = Message(
                            roomId: room.roomId,
                            text: chatController.text,
                            senderId: senderId,
                            sentAt: DateTime.now());
                        log('sending msg');
                        ChatRepo().sendMessage(message);
                        chatController.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
