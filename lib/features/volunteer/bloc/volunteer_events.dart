// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'volunteer_bloc.dart';

sealed class VolunteerEvent {}

class JoinEvent extends VolunteerEvent {
  final RecruitmentPost post;
  final String userID;
  JoinEvent({required this.post, required this.userID});
}


