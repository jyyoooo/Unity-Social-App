import 'package:flutter/material.dart';
import 'package:unitysocial/core/widgets/custom_button.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'widgets/wish_yellow_card_widget.dart';

class JoinSuccessPage extends StatelessWidget {
  const JoinSuccessPage({super.key, required this.postTitle});

  final String postTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: UnityAppBar(title: 'Congrats',showBackBtn: true,)),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(
                'Your registration to join the $postTitle  team was successful.'),
            const WishYellowCard(),
            CustomButton(label: 'Set Reminder', onPressed: () {})
          ],
        ),
      ),
    );
  }
}
