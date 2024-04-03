import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/widgets/custom_button.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/volunteer/screens/widgets/wish_yellow_card_widget.dart';

class DonationSuccessPage extends StatelessWidget {
  const DonationSuccessPage({super.key, required this.postTitle});

  final String postTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: UnityAppBar(
            title: 'Home',
            titleSize: 17,
            titleColor: CupertinoColors.systemBlue,
            boldTitle: false,
            showBackBtn: true,
          )),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const Text('Thank you for your kind act.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
              'Your donation to join the $postTitle  team was successful.',
              style: const TextStyle(fontSize: 15),
            ),
            const WishYellowCard(showVolunteer: false),
            CustomButton(label: 'Volunteer', onPressed: () {})
          ],
        ),
      ),
    );
  }
}
