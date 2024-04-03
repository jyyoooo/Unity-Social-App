import 'package:flutter/material.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/community/models/chat_room_model.dart';
import 'package:unitysocial/features/community/models/message_model.dart';
import 'package:unitysocial/features/community/repository/chat_repo.dart';
import 'package:unitysocial/features/community/repository/chat_room_repo.dart';
import 'package:unitysocial/features/community/screens/chat_screen.dart';

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
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            } else if (snapshot.hasData) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data?.length ?? 0,
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
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(room.name,
                                style: const TextStyle(fontSize: 17)),
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
            return const Center(
              child: Text('You are not in any active communities'),
            );
          },
        ),
      ),
    );
  }

  FutureBuilder<Message> _showLastMessage(ChatRoom room) {
    return FutureBuilder(
      future: ChatRepo().fetchLastMessage(room.roomId!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(room.roomId!);
        } else if (snapshot.hasData) {
          final Message lastMessage = snapshot.data!;
          return Text(
            lastMessage.text,
            style: const TextStyle(color: Colors.grey),
          );
        }
        return const Text('...', style: TextStyle(color: Colors.grey));
      },
    );
  }

  PageRouteBuilder<dynamic> _pushRouteWithAnimation(ChatRoom room) {
    return PageRouteBuilder(
      pageBuilder: (context, _, __) => ChatScreen(
        room: room,
      ),
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
