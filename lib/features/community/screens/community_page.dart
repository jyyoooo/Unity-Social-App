import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/constants/custom_button.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/community/cubit/scroll_cubit.dart';
import 'package:unitysocial/features/community/cubit/segment_cubit.dart';
import 'package:unitysocial/features/community/data/models/chat_room_model.dart';
import 'package:unitysocial/features/community/data/models/message_model.dart';
import 'package:unitysocial/features/community/data/repository/chat_repo.dart';
import 'package:unitysocial/features/community/data/repository/chat_room_repo.dart';
import 'package:unitysocial/features/community/screens/chat_screen.dart';
import 'package:unitysocial/features/home/screens/widgets/navigation_bloc.dart';
import 'package:unitysocial/features/news/data/source/news_repository.dart';

import 'widgets/formatter.dart';
import 'widgets/post_card.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appbar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: BlocBuilder<SegmentCubit, int>(
                builder: (context, segmentValue) {
                  return segmentValue == 1 ? chatRooms() : feed();
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton:
            context.watch<SegmentCubit>().state == 1 ? null : _fab(context),
      ),
    );
  }

  FloatingActionButton _fab(BuildContext context) {
    return FloatingActionButton(
      splashColor: CupertinoColors.lightBackgroundGray,
      onPressed: () {
        showModalBottomSheet(
          constraints: const BoxConstraints(maxHeight: 700, minHeight: 645),
          context: context,
          isScrollControlled: true, // Allow the bottom sheet to expand more
          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: CupertinoColors.systemGrey6,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Create Post',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(height: 1),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(
                                  height: 300,
                                  child: Center(child: Text("Upload image")),
                                ),
                                const SizedBox(height: 10),
                                const CupertinoTextField(
                                  controller: null,
                                  placeholder: 'Add a caption...',
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 10),
                                const CupertinoTextField(
                                  placeholder: 'Mention cause...',
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 20),
                                CustomButton(
                                  label: 'Post',
                                  onPressed: () {
                                    NewsRepository.fetchLatestNews();
                                    // Handles post submission logic
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      child:
          const Icon(CupertinoIcons.create, color: CupertinoColors.activeBlue),
    );
  }
}

Widget feed() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) {
          return const PostCard();
        }),
  );
}

StreamBuilder<List<ChatRoom>> chatRooms() {
  return StreamBuilder(
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
            : showListOfRooms(snapshot);
      }
      return const Center(child: Text('Something went wrong'));
    },
  );
}

// Refactored widgets

ListView showListOfRooms(AsyncSnapshot<List<ChatRoom>> snapshot) {
  return ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemCount: snapshot.hasData ? snapshot.data!.length : 0,
    separatorBuilder: (context, index) => const Divider(
      thickness: .9,
      height: 1,
      color: CupertinoColors.lightBackgroundGray,
    ),
    itemBuilder: (context, index) {
      final ChatRoom room = snapshot.data![index];

      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChatScreen(room: room),
              )
              // _pushRouteWithAnimation(room),
              );
        },
        child: SizedBox(
          height: 85,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(19, 10, 12.5, 10),
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

StreamBuilder<Message> _showLastMessage(ChatRoom room) {
  return StreamBuilder<Message>(
    stream: ChatRepo.fetchLastMessage(room.roomId!),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text('Loading...', style: TextStyle(color: Colors.grey));
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}',
            style: const TextStyle(color: Colors.grey));
      } else if (snapshot.hasData) {
        final Message? lastMessage = snapshot.data;
        if (lastMessage == null) {
          return const Text(
            'No messages',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                lastMessage.text.isEmpty ? 'No messages' : lastMessage.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            Text(
              lastMessage.text.isEmpty
                  ? 'now'
                  : Formatter.formatDateTime(lastMessage.sentAt),
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            )
          ],
        );
      }
      return const Text('No data');
    },
  );
}

PageRouteBuilder<dynamic> _pushRouteWithAnimation(ChatRoom room) {
  return PageRouteBuilder(
    pageBuilder: (context, _, __) => ChatScreen(room: room,),
    transitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      var curve = Curves.easeInOutSine;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
    preferredSize: Size.fromHeight(110),
    child: UnityAppBar(
      title: 'Community',
      showSlider: true,
    ),
  );
}
