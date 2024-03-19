import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:unitysocial/core/widgets/custom_button.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/home/data/source/posts_repo.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/recruit/screens/widgets/text_field_header_widget.dart';

class PostDetailsWidget extends StatelessWidget {
  const PostDetailsWidget({
    Key? key,
    required this.post,
  }) : super(key: key);
  final RecruitmentPost post;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: UnityAppBar(
            title: post.title,
            showBackBtn: true,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextFieldHeader(title: 'Our vision'),
                _showDescription(width),
                const SizedBox(height: 10),
                const TextFieldHeader(title: 'Duration'),
                _showDateRange(),
                const SizedBox(height: 10),
                const TextFieldHeader(title: 'Location'),
                _showLocation(width),
                const Spacer(),
                const TextFieldHeader(title: 'Accreditations'),
                _showBadges(),
                const SizedBox(height: 10),
                Center(
                    child: CustomButton(
                  label: 'Volunteer',
                  onPressed: () {},
                )),
                Center(
                    child: CustomButton(
                  label: 'Donate',
                  labelColor: Colors.blue,
                  onPressed: () {},
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(0,0,0,10),
                ))
              ],
            )),
          ],
        ),
      ),
    );
  }

  _showDescription(double width) {
    return Container(
        constraints: BoxConstraints(
            maxHeight: 600, maxWidth: 400, minHeight: 120, minWidth: width),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
        child: Text(post.description,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)));
  }

  _showBadges() {
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

  _showLocation(width) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.location_fill, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(borderRadius: BorderRadius.circular(12),
              onTap: () {},
              child: Text(
                post.location.address,
                style: const TextStyle(
                    color: CupertinoColors.black,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
          ),
        ],
      ),
    );
  }

  _showDateRange() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(CupertinoIcons.calendar),
          const SizedBox(width: 10),
          Text(
            '${post.duration.start.day} ${DateFormat.MMMM().format(post.duration.start)}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5), child: Text('to')),
          Text(
            '${post.duration.end.day} ${DateFormat.MMMM().format(post.duration.end)}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
