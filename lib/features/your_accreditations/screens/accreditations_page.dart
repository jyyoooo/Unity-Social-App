import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/volunteer/data/volunteer_repo.dart';
import 'widgets/accreditation_widgets.dart';

class AccreditationsPage extends StatelessWidget {
  AccreditationsPage({super.key});
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: UnityAppBar(
            title: 'Your Accreditations',
            showBackBtn: true,
          )),
      body: FutureBuilder(
        future: VolunteerRepository().getVolunteeredCauses(userId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong, Try again'));
          } else {
            List<RecruitmentPost> posts = snapshot.data ?? [];
            return posts.isEmpty
                ? const Center(
                    child: Text(
                        'Your accreditations will appear here once you complete volunteering for a cause'),
                  )
                : buildAccreditationsTileList(posts);
          }
        },
      ),
    );
  }
}
