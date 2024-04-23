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
                  child: CupertinoActivityIndicator());
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
                  showTotalDonations(post),
                  const Text('Recent donations',
                      style: TextStyle(color: Colors.grey)),
                  showAllDonations(post),
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

  
}
