import 'package:flutter_bloc/flutter_bloc.dart';

class LocationCubit extends Cubit<String> {
  LocationCubit(String initialLocation) : super(initialLocation);

  void updateLocation(String newLocation) {
    emit(newLocation);
  }
}

class InitialLocation {}
