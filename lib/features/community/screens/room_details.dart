import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/community/data/models/chat_room_model.dart';
import 'package:unitysocial/features/community/data/repository/chat_room_repo.dart';
import 'package:unitysocial/features/donation/screens/widgets/donation_repository.dart';
import 'package:unitysocial/features/home/screens/widgets/navigation_bloc.dart';
import 'package:unitysocial/features/home/screens/widgets/post_details_components.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

class RoomDetails extends StatelessWidget {
  const RoomDetails({super.key, required this.room});
  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NavigationCubit>(context).hideNavBar();
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: UnityAppBar(
            title: 'Room details',
            smallTitle: true,
            showBackBtn: true,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: FutureBuilder(
          future: ChatRoomRepo().getPostDetails(room),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: Text(
                'Loading...',
                style: TextStyle(color: Colors.grey),
              ));
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text(
                'Error fetching room details. Try again later',
                style: TextStyle(color: Colors.grey),
              ));
            } else if (snapshot.hasData) {
              final post = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post!.title, style: const TextStyle(fontSize: 20)),
                  const Text('Badges', style: TextStyle(color: Colors.grey)),
                  showBadges(post),
                  const Align(
                      alignment: Alignment.center,
                      child: Text('Total Donations',
                          style: TextStyle(color: Colors.grey))),
                  _showTotalDonations(post),
                  const Text('Recent donations',
                      style: TextStyle(color: Colors.grey)),
                  _showAllDonations(post),
                  const Text('Volunteers',
                      style: TextStyle(color: Colors.grey)),
                  Expanded(child: showVolunteers(post)),
                ],
              );
            }
            return const Text('Something went wrong');
          },
        ),
      ),
    );
  }

  SizedBox _showAllDonations(RecruitmentPost post) {
    return SizedBox(
      height: 40,
      child: FutureBuilder(
        future: DonationRepository().fetchPostDonations(post.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading donations...',
                style: TextStyle(color: Colors.grey));
          } else if (snapshot.hasError) {
            return const Text('Error fetching donations',
                style: TextStyle(color: Colors.grey));
          } else if (snapshot.hasData) {
            final donations = snapshot.data;

            return donations!.isEmpty
                ? const Center(
                    child: Text('0 Donations',
                        style: TextStyle(color: Colors.grey)),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: donations.length,
                    itemBuilder: (context, index) => Card(
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('₹${donations[index].amount}'),
                        )),
                  );
          }
          return const Text('Something went wrong, Please try again');
        },
      ),
    );
  }

  SizedBox _showTotalDonations(RecruitmentPost post) {
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
}
