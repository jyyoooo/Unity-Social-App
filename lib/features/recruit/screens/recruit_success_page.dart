import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/constants/custom_button.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/volunteer/screens/widgets/wish_yellow_card_widget.dart';
import 'package:unitysocial/features/your_projects/screens/your_projects.dart';

class RecruitSuccessPage extends StatelessWidget {
  const RecruitSuccessPage({super.key, required this.postTitle});

  final String postTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child:
              UnityAppBar(title: 'Sent For Approval', enableCloseAction: true,smallTitle: true,)),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text(
                'Your recruitment post for $postTitle was sent for approval from the admin. Please wait till the admins verify your post '),
                const SizedBox(height: 10),
            const WishYellowCard(
              cardTitle: 'Your post is under review',
              icon: Icon(CupertinoIcons.group,size: 100,),
              message: '',
            ),
            CustomButton(
                label: 'See your projects',
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const YourProjects(),
                      ));
                })
          ],
        ),
      ),
    );
  }
}
