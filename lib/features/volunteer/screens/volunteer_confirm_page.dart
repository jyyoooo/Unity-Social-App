import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/constants/custom_button.dart';
import 'package:unitysocial/core/constants/snack_bar.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/volunteer/bloc/volunteer_bloc.dart';
import 'join_success_page.dart';

class VolunteerJoin extends StatelessWidget {
  const VolunteerJoin({Key? key, required this.post}) : super(key: key);
  final RecruitmentPost post;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VolunteerBloc, VolunteerState>(
      listener: (context, state) {
        if (state is JoinError) {
          showSnackbar(context, state.message,
              CupertinoColors.systemTeal.highContrastColor);
        } else if (state is JoinSuccess) {
          showSnackbar(context, state.message);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => JoinSuccessPage(
                  postTitle: post.title,
                ),
              ),
              (route) => route.isFirst);
        }
      },
      child: Scaffold(
        appBar: _showVolunteerAppbar(),
        body: Column(
          children: [
            _preJoinMessage(),
            const Spacer(),
            BlocBuilder<VolunteerBloc, VolunteerState>(
              builder: (context, state) {
                if (state is Loading) {
                 return const LinearProgressIndicator();
                }
                return CustomButton(
                  label: 'Confirm Join',
                  onPressed: () {
                    log('current userid ${FirebaseAuth.instance.currentUser!.uid}');
                    if (FirebaseAuth.instance.currentUser!.uid == post.host) {
                      showSnackbar(
                          context,
                          'You cannot join your own recruitment',
                          CupertinoColors.systemTeal.highContrastColor);
                    } else {
                      context.read<VolunteerBloc>().add(
                            JoinEvent(
                              post: post,
                              userID: FirebaseAuth.instance.currentUser!.uid,
                            ),
                          );
                    }
                  },
                );
              },
            ),
            CustomButton(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
              color: Colors.white,
              label: 'Cancel',
              labelColor: CupertinoColors.destructiveRed,
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }

  // REFACTORED COMPONENTS

  PreferredSize _showVolunteerAppbar() {
    return const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: UnityAppBar(
          smallTitle: true,
          title: 'Volunteer for',
          showBackBtn: true,
        ));
  }

  Container _preJoinMessage() {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _showTitle(),
            Text('Are you sure you want to join ${post.title} team?',
                style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 10),
            // const Spacer(),
            Text(
                style: const TextStyle(fontSize: 15),
                'After you join, you will be added to the group chat of ${post.title} in the community section and you can discuss regarding the cause')
          ],
        ));
  }

  Text _showTitle() {
    return Text(
      post.title,
      style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
          fontSize: 25),
    );
  }
}
