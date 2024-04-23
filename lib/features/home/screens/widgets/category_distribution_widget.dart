import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/home/bloc/posts_bloc.dart';
import 'package:unitysocial/features/home/screens/widgets/cause_info_card.dart';

class CauseCategoryPage extends StatelessWidget {
  CauseCategoryPage({
    super.key,
    required this.query,
    required this.categoryName,
  });
  final String query;
  final String categoryName;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<PostsBloc>().add(FetchAllPosts(category: query));
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Hero(tag: categoryName,
            child: UnityAppBar(
              title: categoryName,
              showBackBtn: true,
            ),
          )),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPosts) {
            return const Center(
              child: CupertinoActivityIndicator()
            );
          } else if (state is AnimalsPosts) {
            log(state.allPosts.toString());
            return state.allPosts.isEmpty
                ? _emptyMessage()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.allPosts.length,
                    itemBuilder: (context, index) {
                      final post = state.allPosts[index];

                      return CauseInfoCard(post: post);
                    });
          } else if (state is HumanitarianPosts) {
            return state.allPosts.isEmpty
                ? _emptyMessage()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.allPosts.length,
                    itemBuilder: (context, index) {
                      final post = state.allPosts[index];

                      return CauseInfoCard(post: post);
                    });
          } else if (state is WaterPosts) {
            return state.allPosts.isEmpty
                ? _emptyMessage()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.allPosts.length,
                    itemBuilder: (context, index) {
                      final post = state.allPosts[index];
                      return CauseInfoCard(post: post);
                    });
          } else if (state is EnvironmentPosts) {
            return state.allPosts.isEmpty
                ? _emptyMessage()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.allPosts.length,
                    itemBuilder: (context, index) {
                      final post = state.allPosts[index];

                      return CauseInfoCard(post: post);
                    });
          }
          return const Center(child: Text('Something went wrong!'));
        },
      ),
    );
  }

  Center _emptyMessage() {
    return const Center(
      child: Text(
        'No posts available',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
