import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'project_cubit_injection.dart';
import 'project_status_widgets.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.post,
  });

  final RecruitmentPost post;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: .2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          log(post.id!);
          Navigator.push(context, _routeBuilder());
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
              height: 90,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _projectTitle(),
                    _projectDescription(),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        post.isApproved ? _joinedCount() : const SizedBox(),
                        post.duration.end.isBefore(DateTime.now())
                            ? expiredMessage()
                            : post.isApproved
                                ? approvedMessage()
                                : pendingMessage()
                      ],
                    )
                  ])),
        ),
      ),
    );
  }

  Row _joinedCount() {
    return Row(
      children: [
        const Icon(CupertinoIcons.group, color: CupertinoColors.activeBlue),
        const SizedBox(width: 5),
        Text(
            style: GoogleFonts.inter(color: Colors.black54),
            '${post.members.length} joined')
      ],
    );
  }

  PageRouteBuilder<dynamic> _routeBuilder() {
    return PageRouteBuilder(
      pageBuilder: (context, _, __) => ProjectDetailsScreen(post: post),
      transitionDuration: const Duration(milliseconds: 180),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  Text _projectTitle() {
    return Text(
      post.title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Text _projectDescription() {
    return Text(
      post.description,
      style: const TextStyle(
          color: Colors.black54, overflow: TextOverflow.ellipsis),
    );
  }
}
