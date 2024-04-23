import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/your_projects/bloc/projects_bloc.dart';

import 'widgets/project_card.dart';

class YourProjects extends StatefulWidget {
  const YourProjects({super.key});

  @override
  State<YourProjects> createState() => _YourProjectsState();
}

class _YourProjectsState extends State<YourProjects> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  List cachedPosts = [];

  @override
  void initState() {
    super.initState();
    context.read<ProjectsBloc>().add(FetchUserProjects(hostId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocBuilder<ProjectsBloc, ProjectState>(
          builder: (context, state) {
            if (state is LoadingProjects) {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 1.5),
              );
            } else if (state is FetchSuccess) {
              return state.posts.isEmpty
                  ? _noProjectsMessage()
                  : CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 75),
                            sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                              final post = state.posts[index];
                              return ProjectCard(post: post);
                            }, childCount: state.posts.length)),
                          ),
                        ]);
            }
            return cachedPosts.isEmpty
                ? _errorMessage()
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ProjectCard(post: cachedPosts[index]);
                          },
                          itemCount: cachedPosts.length,
                        ),
                      ),
                      Container(
                        height: 75,
                        color: Colors.transparent,
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }

  PreferredSize _appBar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: UnityAppBar(
        title: 'Your Projects',
        showBackBtn: true,
      ),
    );
  }

  Center _errorMessage() {
    return const Center(
      child: Text('Something went wrong'),
    );
  }

  Center _noProjectsMessage() {
    return const Center(
      child: Text(
        'You havent started any projects',
        style: TextStyle(color: CupertinoColors.inactiveGray),
      ),
    );
  }
}
