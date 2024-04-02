
part of 'volunteer_bloc.dart';

sealed class VolunteerState {}

class VolunteerInitial extends VolunteerState {}

class Loading extends VolunteerState {}

class JoinError extends VolunteerState {
  final String message;
  JoinError({required this.message});
}

class JoinSuccess extends VolunteerState {
  final String message;
  JoinSuccess({required this.message});
}
