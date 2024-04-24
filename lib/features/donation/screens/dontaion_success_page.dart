import 'package:flutter/material.dart';
import 'package:unitysocial/core/constants/custom_button.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/volunteer/screens/volunteer_confirm_page.dart';
import 'package:unitysocial/features/volunteer/screens/widgets/wish_yellow_card_widget.dart';

class DonationSuccessPage extends StatelessWidget {
  const DonationSuccessPage({super.key, required this.post});

  final RecruitmentPost post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: UnityAppBar(
            title: 'Home',
            smallTitle: true,
            enableCloseAction: true,
          )),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Thank you for your kind act.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(
              'Your donation to the ${post.title} team was successful.',
              style: const TextStyle(fontSize: 15),
            ),
            const WishYellowCard(showVolunteer: false),
            const Spacer(),
            Align(
                alignment: Alignment.center,
                child: CustomButton(
                    label: 'Volunteer',
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VolunteerJoin(post: post),
                          ));
                    })),
                    const SizedBox(height:60)
          ],
        ),
      ),
    );
  }
}
