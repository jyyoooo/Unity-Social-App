import 'dart:async';
import 'dart:developer';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
        // appBar: _appbar(context),
        body: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  // Dismiss the keyboard when tapping outside the text field
                  FocusScope.of(context).unfocus();
                },
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
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: UnityAppBar(
                  title: widget.room.name,
                  showBackBtn: true,
                  smallTitle: true,
                  activateOntap: true,
                  showInfoIcon: true,
                  onInfoTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomDetails(room: widget.room),
                        ));
                  }),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ChatTextField(room: widget.room),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showMessages(List<Message> messages, ScrollController controller) {
    DateTime? currentDate;
    Message? previousChat;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.hasClients) {
        // controller.animateTo(controller.position.maxScrollExtent,
        //     duration: const Duration(milliseconds: 200),
        //     curve: Curves.decelerate);
        controller.jumpTo(controller.position.maxScrollExtent);
      }
    });
    return messages.isEmpty
        ? const Center(
            child: Text('Send a message', style: TextStyle(color: Colors.grey)))
        : CustomScrollView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 80, bottom: 63),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final chat = messages[index];
                      final isSender = chat.senderId == senderId;

                      final messageDate = chat.sentAt;
                      final showDate = currentDate == null ||
                          !isSameDay(messageDate, currentDate!);
                      currentDate = messageDate;

                      final showUsername =
                          previousChat?.senderId != chat.senderId;
                      previousChat = chat;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showDate) _dateSeparator(messageDate),
                          if (showUsername) ...[
                            if (!isSender) _senderUsername(chat),
                            const SizedBox(height: 8),
                          ],
                          _chatBubble(isSender, chat),
                        ],
                      );
                    },
                    childCount: messages.length,
                  ),
                ),
              ),
            ],
          );
  }

  Widget _dateSeparator(DateTime date) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        DateFormat('EEE, MMM d, yyyy').format(date),
        style: const TextStyle(color: Colors.grey, fontSize: 11),
      ),
    );
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

  Widget _senderUsername(Message chat) {
    return FutureBuilder(
      future: ChatRepo().getSenderUsername(chat.senderId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('      ...',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold));
        } else if (snapshot.hasError) {
          return const Text('      Volunteer',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold));
        } else if (snapshot.hasData) {
          return Text('      ${snapshot.data!}',
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold));
        }
        return const Text('      Volunteer',
            style: TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold));
      },
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Center _undefinedErrorMsg() =>
      const Center(child: Text('Something went wrong'));

  Center _errorFetchingMessage() {
    return const Center(
      child: Text('Error fetching messages'),
    );
  }

  Center _loadingWidget() {
    return const Center(child: CupertinoActivityIndicator());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
