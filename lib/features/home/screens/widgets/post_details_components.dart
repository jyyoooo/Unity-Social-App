import 'package:flutter/material.dart';
import 'package:unitysocial/features/auth/data/models/user_model.dart';
import 'package:unitysocial/features/auth/data/repository/user_repo.dart';
import 'package:unitysocial/features/home/data/source/posts_repo.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

showBadges(RecruitmentPost post) {
  return SizedBox(
    height: 50,
    child: FutureBuilder(
        future: PostsRepository().fetchPostBadges(post.badges),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...',
                style: TextStyle(fontSize: 12, color: Colors.grey));
          } else if (snapshot.hasData) {
            final badges = snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CircleAvatar(child: Icon(badges![index].icon)),
              ),
              itemCount: post.badges.length,
            );
          }
          return const Text('Error fetching badges',
              style: TextStyle(fontSize: 12, color: Colors.grey));
        }),
  );
}

FutureBuilder<List<UserProfile>> showVolunteers(RecruitmentPost post) {
  return FutureBuilder(
    future: UserRepository().showMembers(post.members),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator(strokeWidth: 1.5));
      } else if (snapshot.hasError) {
        return const Text('Error fetching members details');
      } else if (snapshot.hasData) {
        final List<UserProfile>? members = snapshot.data;
        return ListView.builder(
          itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: .5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(members![index].userName),
              )),
          itemCount: post.members.length,
        );
      }
      return const Center(child: Text('Something went wrong'));
    },
  );
}
