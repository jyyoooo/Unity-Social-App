import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/widgets/custom_button.dart';
import 'package:unitysocial/features/home/screens/post_details_page.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/volunteer/screens/volunteer_confirm_page.dart';

class CauseInfoCard extends StatelessWidget {
  const CauseInfoCard({super.key, required this.post});

  final RecruitmentPost post;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: .5,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostDetailsWidget(post: post)));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleAndLocation(),
              _description(),
              _joinButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Row _joinButton(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        CustomButton(
          label: 'Join',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VolunteerJoin(post: post),
              ),
            );
          },
          width: 80,
          height: 35,
          borderRadius: 9,
          padding: const EdgeInsets.all(0),
        )
      ],
    );
  }

  Text _description() {
    return Text(
      post.description,
      style: const TextStyle(color: Colors.black54),
    );
  }

  Row _titleAndLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(post.title,
              style:
                  const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        ),
        _iconAndLocation()
      ],
    );
  }

  Row _iconAndLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Icon(CupertinoIcons.location_fill, size: 12),
        const SizedBox(
          width: 2,
        ),
        Text(
          post.location.address.split(',').first,
          overflow: TextOverflow.fade,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
