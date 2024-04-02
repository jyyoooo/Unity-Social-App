import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/community/models/chat_room_model.dart';
import 'package:unitysocial/features/community/models/message_model.dart';
import 'package:unitysocial/features/community/repository/chat_repo.dart';
import 'package:unitysocial/features/community/screens/room_details.dart';
import 'package:unitysocial/features/home/screens/widgets/navigation_bloc.dart';
import 'widgets/chat_text_field.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({
    Key? key,
    required this.room,
  }) : super(key: key);
  final ChatRoom room;
  final senderId = FirebaseAuth.instance.currentUser!.uid;
  late final ScrollController scrollController = ScrollController();

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    context.read<NavigationCubit>().hideNavBar();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          BlocProvider.of<NavigationCubit>(context).showNavBar();
          return;
        }
        return;
      },
      canPop: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: UnityAppBar(
              title: widget.room.name,
              showBackBtn: true,
              activateOntap: true,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomDetails(room: widget.room),
                    ));
              }),
        ),
        body: GestureDetector(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: ChatRepo().fetchMessages(widget.room.roomId!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _loadingWidget();
                      } else if (snapshot.hasError) {
                        return _errorFetchingMessage();
                      } else if (snapshot.hasData) {
                        return snapshot.data!.isEmpty
                            ? _noMessages()
                            : _showMessages(snapshot, widget.scrollController);
                      }
                      return _undefinedErrorMsg();
                    }),
              ),
              ChatTextField(room: widget.room),
            ],
          ),
        ),
      ),
    );
  }

  Center _undefinedErrorMsg() =>
      const Center(child: Text('Something went wrong'));

  Center _errorFetchingMessage() {
    return const Center(
      child: Text('Error fetching messages'),
    );
  }

  Center _loadingWidget() {
    return const Center(child: CircularProgressIndicator(strokeWidth: 1.5));
  }

  Center _noMessages() {
    return const Center(
      child: Text(
        'Send a message',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  ListView _showMessages(
      AsyncSnapshot<List<Message>> snapshot, ScrollController controller) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.jumpTo(controller.position.maxScrollExtent);
    });
    {
      Message? previousChat;
      return ListView.separated(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        reverse: false,
        padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
        separatorBuilder: (_, __) => const SizedBox(height: 5),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final chat = snapshot.data![index];

          final isSender = chat.senderId == widget.senderId;
          final showUsername = previousChat?.senderId != chat.senderId;
          previousChat = chat;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showUsername
                  ? !isSender
                      ? _senderUsername(chat)
                      : const SizedBox()
                  : const SizedBox(),
              _chatBubble(isSender, chat),
            ],
          );
        },
      );
    }
  }

  BubbleSpecialThree _chatBubble(bool isSender, Message chat) {
    return BubbleSpecialThree(
        textStyle: TextStyle(color: isSender ? Colors.white : Colors.black),
        color:
            isSender ? buttonGreen : CupertinoColors.extraLightBackgroundGray,
        isSender: isSender,
        text: chat.text);
  }

  FutureBuilder<String> _senderUsername(Message chat) {
    return FutureBuilder(
      future: ChatRepo().getSenderUsername(chat.senderId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('...');
        } else if (snapshot.hasError) {
          return const Text('Volunteer');
        } else if (snapshot.hasData) {
          return Text(
            snapshot.data!,
            style: const TextStyle(color: Colors.grey),
          );
        }
        return const Text('Volunteer');
      },
    );
  }
}
