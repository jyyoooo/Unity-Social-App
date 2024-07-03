import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<double> {
  SliderCubit() : super(0.0);

  void slide(double value) {
    emit(value);
  }
}
