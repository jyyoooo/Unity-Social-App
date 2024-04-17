import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/features/recruit/data/models/location_model.dart';

class LocationCubit extends Cubit<Location> {
  LocationCubit(Location initialLocation) : super(initialLocation);

  void updateLocation(Location newLocation) {
    emit(newLocation);
  }
}
