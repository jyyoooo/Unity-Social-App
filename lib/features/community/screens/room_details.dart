import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/community/models/chat_room_model.dart';
import 'package:unitysocial/features/home/screens/widgets/navigation_bloc.dart';

class RoomDetails extends StatelessWidget {
  const RoomDetails({super.key, required this.room});
  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NavigationCubit>(context).hideNavBar();
    return const Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: UnityAppBar(
            title: 'Cause details',
            titleSize: 17,
            titleColor: CupertinoColors.systemBlue,
            boldTitle: false,
            showBackBtn: true,
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
