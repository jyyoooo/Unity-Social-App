import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/features/home/data/source/posts_repo.dart';
import 'package:unitysocial/features/recruit/data/models/badge_model.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

ListView buildAccreditationsTileList(List<RecruitmentPost> posts) {
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 2),
        child: SizedBox(
          height: 100,
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  width: 80,
                  height: 40,
                  child: FutureBuilder(
                    future:
                        PostsRepository().fetchPostBadges(posts[index].badges),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const CircleAvatar(backgroundColor: Colors.grey);
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
      );
    },
  );
}

ListView buildBadgesList(List<AchievementBadge>? badges) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    itemCount: badges!.length,
    itemBuilder: (context, index) => Align(
      widthFactor: .8,
      child: CircleAvatar(
        child: Icon(badges[index].icon),
      ),
    ),
  );
}
