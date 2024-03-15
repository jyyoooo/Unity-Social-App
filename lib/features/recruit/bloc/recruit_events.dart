part of 'recruit_bloc.dart';

abstract class RecruitEvent {}

class SubmitFormEvent extends RecruitEvent {}

class DateRangeUpdateEvent extends RecruitEvent {
  final DateTimeRange updatedDateTimeRange;
  DateRangeUpdateEvent({required this.updatedDateTimeRange});
}

class LocationSelectEvent extends RecruitEvent {
  final LocationData selectedLocation;
  LocationSelectEvent({required this.selectedLocation});
}

class FetchBadgesEvent extends RecruitEvent {}

class CreateRecruitmentEvent extends RecruitEvent {
  final RecruitmentPost data;
  CreateRecruitmentEvent({required this.data});
}
