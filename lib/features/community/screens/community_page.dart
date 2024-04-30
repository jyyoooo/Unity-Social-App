import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/community/data/models/chat_room_model.dart';
import 'package:unitysocial/features/community/data/models/message_model.dart';
import 'package:unitysocial/features/community/data/repository/chat_repo.dart';
import 'package:unitysocial/features/community/data/repository/chat_room_repo.dart';
import 'package:unitysocial/features/community/screens/chat_screen.dart';
import 'package:unitysocial/features/community/screens/widgets/formatter.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appbar(),
        body: StreamBuilder(
          stream: ChatRoomRepo().fetchChatRooms(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong',
                    style: TextStyle(color: Colors.grey)),
              );
            } else if (snapshot.hasData) {
              final chatRooms = snapshot.data!;
              return chatRooms.isEmpty
                  ? const Center(
                      child: Text('You are not in any active communities',
                          style: TextStyle(color: Colors.grey)))
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                      separatorBuilder: (context, index) =>
                          const Divider(thickness: .2, height: .1),
                      itemBuilder: (context, index) {
                        final ChatRoom room = snapshot.data![index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              _pushRouteWithAnimation(room),
                            );
                          },
                          child: SizedBox(
                            height: 85,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(19, 10, 12.5, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _roomTitle(room),
                                  const SizedBox(height: 5),
                                  _showLastMessage(room)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            }
            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }

  Widget _roomTitle(ChatRoom room) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(room.name, style: const TextStyle(fontSize: 18)),
        const Icon(
          Icons.keyboard_arrow_right_rounded,
          size: 20,
          color: CupertinoColors.activeBlue,
        )
      ],
    );
  }

  FutureBuilder<Message> _showLastMessage(ChatRoom room) {
    return FutureBuilder(
      future: ChatRepo().fetchLastMessage(room.roomId!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text(
            'No messages',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          );
        } else if (snapshot.hasData) {
          final Message lastMessage = snapshot.data!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  lastMessage.text,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Text(
                Formatter.formatDateTime(lastMessage.sentAt),
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              )
            ],
          );
        }
        return const Text('...', style: TextStyle(color: Colors.grey));
      },
    );
  }

  PageRouteBuilder<dynamic> _pushRouteWithAnimation(ChatRoom room) {
    return PageRouteBuilder(
      pageBuilder: (context, _, __) => ChatScreen(room: room),
      transitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var curve = Curves.easeInOutSine;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  PreferredSize _appbar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: UnityAppBar(title: 'Community'),
    );
  }
}
