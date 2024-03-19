part of 'posts_bloc.dart';


sealed class PostsState {}

class PostsInitial extends PostsState {}

class LoadingPosts extends PostsState {}

class AnimalsPosts extends PostsState {
  final List<RecruitmentPost> allPosts;
  AnimalsPosts({required this.allPosts});
}

class HumanitarianPosts extends PostsState {
  final List<RecruitmentPost> allPosts;
  HumanitarianPosts({required this.allPosts});
}

class WaterPosts extends PostsState {
  final List<RecruitmentPost> allPosts;
  WaterPosts({required this.allPosts});
}

class EnvironmentPosts extends PostsState {
  final List<RecruitmentPost> allPosts;
  EnvironmentPosts({required this.allPosts});
}
