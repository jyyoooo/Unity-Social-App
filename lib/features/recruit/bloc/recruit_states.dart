part of 'recruit_bloc.dart';

abstract class RecruitState {}

class RecruitInitial extends RecruitState {}

class LoadingState extends RecruitState {}

class DateRangeUpdatedState extends RecruitState {
  final DateTimeRange updatedDateTimeRange;

  DateRangeUpdatedState({required this.updatedDateTimeRange});
}

class LocationUpdatedState extends RecruitState{
  final LocationData selectedLocation ;
  LocationUpdatedState({required this.selectedLocation});
}

class BadgeFetchSuccessState extends RecruitState{
  final List<AchievementBadge> allbadges;
  BadgeFetchSuccessState({required this.allbadges});
}
