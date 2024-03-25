import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/volunteer/data/volunteer_repo.dart';
part 'volunteer_events.dart';
part 'volunteer_states.dart';

class VolunteerBloc extends Bloc<VolunteerEvent, VolunteerState> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  VolunteerBloc() : super(VolunteerInitial()) {
    on<JoinEvent>((event, emit) async {
      emit(Loading());
      log('onJoinEvent');
      final message =
          await VolunteerRepository().addNewVolunteer(userId, event.post);
      if (message == 'Successfully joined ${event.post.title} team') {
        emit(JoinSuccess(message: message));
      } else if (message == 'Maximum members reached') {
        emit(JoinError(message: message));
      } else {
        emit(JoinError(message: message));
      }
    });
  }
}
