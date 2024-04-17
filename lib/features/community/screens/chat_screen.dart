import 'dart:developer';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/community/bloc/chat_bloc.dart';
import 'package:unitysocial/features/community/data/models/chat_room_model.dart';
import 'package:unitysocial/features/community/data/models/message_model.dart';
import 'package:unitysocial/features/community/data/repository/chat_repo.dart';
import 'package:unitysocial/features/community/screens/room_details.dart';
import 'package:unitysocial/features/home/screens/widgets/navigation_bloc.dart';
import 'widgets/chat_text_field.dart';

class ChatScreen extends StatefulWidget {
  final ChatRoom room;

  const ChatScreen({
    Key? key,
    required this.room,
  }) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  late final ScrollController _scrollController;
  late final ChatBloc _chatBloc;
  final senderId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    context.read<NavigationCubit>().hideNavBar();
    _scrollController = ScrollController();
    _chatBloc = BlocProvider.of<ChatBloc>(context);
    _chatBloc.add(FetchMessages(widget.room.roomId!));
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
        appBar: _appbar(context),
        body: GestureDetector(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      log('chat loading');
                      return _loadingWidget();
                    } else if (state is ChatError) {
                      return _errorFetchingMessage();
                    } else if (state is ChatLoaded) {
                      log('chat loaded');
                      return _showMessages(state.messages, _scrollController);
                    }
                    return _undefinedErrorMsg();
                  },
                ),
              ),
              ChatTextField(room: widget.room),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _appbar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: UnityAppBar(
          title: widget.room.name,
          showBackBtn: true,
          activateOntap: true,
          showInfoIcon: true,
          onInfoTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomDetails(room: widget.room),
                ));
          }),
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

  Widget _showMessages(List<Message> messages, ScrollController controller) {
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
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final chat = messages[index];

          final isSender = chat.senderId == senderId;
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
        textStyle: TextStyle(
            color: isSender ? Colors.white : Colors.black, fontSize: 15),
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
          return const Text('...', style: TextStyle(color: Colors.grey));
        } else if (snapshot.hasError) {
          return const Text('Volunteer', style: TextStyle(color: Colors.grey));
        } else if (snapshot.hasData) {
          return Text(snapshot.data!,
              style: const TextStyle(color: Colors.grey));
        }
        return const Text('Volunteer', style: TextStyle(color: Colors.grey));
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
