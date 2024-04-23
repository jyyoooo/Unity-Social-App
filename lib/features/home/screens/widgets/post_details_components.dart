import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/utils/colors/colors.dart';
import 'package:unitysocial/features/auth/data/models/user_profile.dart';
import 'package:unitysocial/features/auth/data/repository/user_repo.dart';
import 'package:unitysocial/features/donation/data/models/donation_model.dart';
import 'package:unitysocial/features/donation/screens/widgets/donation_repository.dart';
import 'package:unitysocial/features/home/data/source/posts_repo.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

showBadges(RecruitmentPost post) {
  return SizedBox(
    height: 50,
    child: FutureBuilder(
        future: PostsRepository().fetchPostBadges(post.badges),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator();
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
        return const Center(child: CupertinoActivityIndicator());
      } else if (snapshot.hasError) {
        return const Text('Error fetching members details');
      } else if (snapshot.hasData) {
        final List<UserProfile>? members = snapshot.data;
        return members!.isEmpty
            ? const Center(
                child: Text(
                'No volunteers',
                style: TextStyle(color: Colors.grey),
              ))
            : ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                cacheExtent: 5,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => ListTile(
                    tileColor: CupertinoColors.systemGrey6,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(members[index].userName),
                    )),
                itemCount: post.members.length,
              );
      }
      return const Center(child: Text('Something went wrong'));
    },
  );
}

SizedBox showAllDonations(RecruitmentPost post) {
  return SizedBox(
    height: 40,
    child: FutureBuilder(
      future: DonationRepository().fetchPostDonations(post.id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasError) {
          return const Text('Error fetching donations',
              style: TextStyle(color: Colors.grey));
        } else if (snapshot.hasData) {
          final List<Donation>? donations = snapshot.data;

          return donations!.isEmpty
              ? const Center(
                  child:
                      Text('0 Donations', style: TextStyle(color: Colors.grey)),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 5),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: donations.length,
                  itemBuilder: (context, index) => ChoiceChip(
                    backgroundColor: CupertinoColors.white,
                    showCheckmark: true,
                    checkmarkColor: buttonGreen,
                    selectedColor: CupertinoColors.systemGrey6,
                    side: BorderSide.none,
                    selected: true,
                    labelStyle: const TextStyle(color: Colors.black),
                    pressElevation: 12,
                    disabledColor: CupertinoColors.activeBlue.withOpacity(.9),
                    label: Text(
                      '₹${donations[index].amount}',
                    ),
                  ),
                );
        }
        return const Text('Something went wrong, Please try again');
      },
    ),
  );
}

SizedBox showTotalDonations(RecruitmentPost post) {
  return SizedBox(
    height: 40,
    child: FutureBuilder(
      future: DonationRepository().totalPostDonations(post.id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading total donations...',
              style: TextStyle(color: Colors.grey));
        } else if (snapshot.hasError) {
          return const Text('Error fetching total donations',
              style: TextStyle(color: Colors.grey));
        } else if (snapshot.hasData) {
          final totalDonation = snapshot.data;

          return totalDonation == null
              ? const Center(
                  child: Text('₹ 0',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                )
              : Center(
                  child: Text(
                    '₹ $totalDonation',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                );
        }
        return const Text('Something went wrong, Please try again');
      },
    ),
  );
}
