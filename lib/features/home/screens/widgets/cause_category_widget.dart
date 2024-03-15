import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/home/bloc/posts_bloc.dart';

class CauseCategoryPage extends StatelessWidget {
  const CauseCategoryPage({
    super.key,
    required this.query,
    required this.categoryName,
  });
  final String query;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    context.read<PostsBloc>().add(FetchAllPosts(category: query));
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: UnityAppBar(title: categoryName)),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPosts) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
              ),
            );
          } else if (state is AnimalsPosts) {
            log(state.allPosts.toString());
            return ListView.builder(
              itemCount: state.allPosts.length,
              itemBuilder: (context, index) {
                return Text(state.allPosts[index].title);
              },
            );
          } else if (state is HumanitarianPosts) {
            return ListView.builder(
              itemCount: state.allPosts.length,
              itemBuilder: (context, index) {
                return Text(state.allPosts[index].title);
              },
            );
          } else if (state is WaterPosts) {
            return ListView.builder(
              itemCount: state.allPosts.length,
              itemBuilder: (context, index) {
                return Text(state.allPosts[index].title);
              },
            );
          } else if (state is EnvironmentPosts) {
            return ListView.builder(
              itemCount: state.allPosts.length,
              itemBuilder: (context, index) {
                return Text(state.allPosts[index].title);
              },
            );
          }
          return Text(state.toString());
        },
      ),
    );
  }
}
