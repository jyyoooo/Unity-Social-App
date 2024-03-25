// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'projects_bloc.dart';

abstract class ProjectEvent {}

class FetchUserProjects extends ProjectEvent {
  final String hostId;
  FetchUserProjects({required this.hostId});
}

class UpdateUserProject extends ProjectEvent {
  final String postID;
  UpdateUserProject({required this.postID});
}
