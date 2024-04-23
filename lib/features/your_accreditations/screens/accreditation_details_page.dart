// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/home/data/source/posts_repo.dart';
import 'package:unitysocial/features/recruit/data/models/badge_model.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

import 'widgets/accreditation_widgets.dart';

class AccreditationsDetails extends StatelessWidget {
  const AccreditationsDetails({Key? key, required this.post}) : super(key: key);
  final RecruitmentPost post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: UnityAppBar(
            title: post.title,
            smallTitle: true,
            showBackBtn: true,
          )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                style: const TextStyle(fontSize: 15),
                'You have completed your participation in ${post.title} and has accredited ${post.badges.length} badges for your perfomance'),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Achievement Badges',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Align(
              child: FutureBuilder(
                future: PostsRepository().fetchPostBadges(post.badges),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const CircleAvatar(backgroundColor: Colors.grey);
                  } else if (snapshot.hasData) {
                    final List<AchievementBadge>? badges = snapshot.data;
                    return SizedBox(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: badges!.isEmpty
                          ? const Center(
                              child: Text('No badges for this cause'),
                            )
                          : GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: post.badges.length > 2
                                    ? 2
                                    : post.badges.length,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              itemCount: post.badges.length,
                              itemBuilder: (context, index) {
                                return badgeMetalCard(badges, index);
                              },
                            ),
                    );
                  }
                  return const CircleAvatar(backgroundColor: Colors.grey);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
