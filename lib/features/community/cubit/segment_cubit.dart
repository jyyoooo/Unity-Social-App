import 'package:flutter_bloc/flutter_bloc.dart';

class SegmentCubit extends Cubit<int> {
  SegmentCubit(super.initialState);

  static const segmentValue = [0, 1];

  void onPressed(int page) {
    emit(page);
  }
}
