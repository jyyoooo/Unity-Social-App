import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';
import 'package:unitysocial/features/home/data/source/posts_repo.dart';
import 'package:unitysocial/features/recruit/data/models/badge_model.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/your_accreditations/screens/accreditation_details_page.dart';

ListView buildAccreditationsTileList(List<RecruitmentPost> posts) {
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 2),
        child: SizedBox(
          height: 100,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AccreditationsDetails(post: posts[index]),
                )),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              tileColor: CupertinoColors.extraLightBackgroundGray,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    posts[index].title,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'You achieved ${posts[index].badges.length} badges',
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: FutureBuilder(
                      future: PostsRepository()
                          .fetchPostBadges(posts[index].badges),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const CircleAvatar(
                              backgroundColor: Colors.grey);
                        } else if (snapshot.hasData) {
                          final badges = snapshot.data;
                          return buildBadgesList(badges);
                        }
                        return const CircleAvatar(backgroundColor: Colors.grey);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

ListView buildBadgesList(List<AchievementBadge>? badges,
    {Axis scrollDirection = Axis.horizontal}) {
  return ListView.builder(
    scrollDirection: scrollDirection,
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    itemCount: badges!.length,
    itemBuilder: (context, index) => Align(
      widthFactor: .8,
      child: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 30,
              color: CupertinoColors.systemGrey6,
              spreadRadius: .3,
              offset: Offset(0, 2))
        ]),
        child: Builder(builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: CupertinoColors.systemGrey3,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: CircleAvatar(
                  backgroundColor: buttonGreen.withOpacity(.4).withGreen(255).withBlue(180).withAlpha(90),
                  child: Icon(badges[index].icon),
                ),
              ),
            ),
          );
        }),
      ),
    ),
  );
}

Container badgeMetalCard(List<AchievementBadge> badges, int index) {
  return Container(
    height: 80,
    width: 80,
    decoration: BoxDecoration(
      border: const BorderDirectional(
          top: BorderSide(width: .1, color: CupertinoColors.systemGrey4)),
      boxShadow: const [
        BoxShadow(
            blurStyle: BlurStyle.normal,
            blurRadius: 8,
            spreadRadius: 3,
            color: CupertinoColors.systemGrey5,
            offset: Offset(0, 2))
      ],
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        tileMode: TileMode.mirror,
        colors: [
          CupertinoColors.extraLightBackgroundGray,
          Colors.white,
          CupertinoColors.lightBackgroundGray,
          CupertinoColors.systemGrey4.withOpacity(.5)
        ],
      ),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          badges[index].icon,
          size: 50,
        ),
        Text(badges[index].title,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700])),
        Text(
          badges[index].description,
          style: TextStyle(color: Colors.grey[600]),
        )
      ],
    ),
  );
}
