import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_location_search/flutter_location_search.dart';
import 'package:unitysocial/features/recruit/data/models/badge_model.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/recruit/data/source/recruit_repository.dart';

part 'recruit_events.dart';
part 'recruit_states.dart';

class RecruitBloc extends Bloc<RecruitEvent, RecruitState> {
  DateTimeRange? dateRange;
  LocationData? location;
  final recruitFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final membersController = TextEditingController();
  RecruitBloc() : super(RecruitInitial()) {
    on<DateRangeUpdateEvent>(dateRangeUpdateEvent);
    on<LocationSelectEvent>(locationSelectEvent);
    on<FetchBadgesEvent>(fetchBadgesEvent);
    on<CreateRecruitmentEvent>(createRecruitmentEvent);
  }

  FutureOr<void> dateRangeUpdateEvent(
      DateRangeUpdateEvent event, Emitter<RecruitState> emit) {
    dateRange = event.updatedDateTimeRange;
    emit(DateRangeUpdatedState(updatedDateTimeRange: dateRange!));
  }

  FutureOr<void> locationSelectEvent(
      LocationSelectEvent event, Emitter<RecruitState> emit) {
    location = event.selectedLocation;
    emit(LocationUpdatedState(selectedLocation: location!));
  }

  FutureOr<void> fetchBadgesEvent(
      FetchBadgesEvent event, Emitter<RecruitState> emit) async {
    log('in fetch');
    emit(LoadingState());
    final allbadges = await RecruitRepository().fetchAllBadges();
    emit(BadgeFetchSuccessState(allbadges: allbadges));
  }

  FutureOr<void> createRecruitmentEvent(
      CreateRecruitmentEvent event, Emitter<RecruitState> emit) async {
    final result = await RecruitRepository().sendPostForApproval(event.data);
    if (result == 'success') {
      emit(SentForApproval());
    } else {
      log(result);
    }
  }
}
