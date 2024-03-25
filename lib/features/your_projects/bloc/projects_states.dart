part of 'projects_bloc.dart';

abstract class ProjectState {}

class Initial extends ProjectState {}

class LoadingProjects extends ProjectState {}

class FetchSuccess extends ProjectState {
  final List<RecruitmentPost> posts;
  FetchSuccess({required this.posts});
}

class UpdateSuccess extends ProjectState {
  final String postID;
  UpdateSuccess({required this.postID});
}

class UpdateError extends ProjectState {}
