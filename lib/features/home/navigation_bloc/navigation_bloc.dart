import 'dart:async';
import 'package:bloc/bloc.dart';
part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<ChangeScreenEvent>(indexChagerEvent);
  }

  FutureOr<void> indexChagerEvent(
      ChangeScreenEvent event, Emitter<NavigationState> emit) {
    emit(NavigationState(index: event.index));
  }
}
