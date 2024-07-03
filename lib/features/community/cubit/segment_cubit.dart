import 'package:flutter_bloc/flutter_bloc.dart';

class SegmentCubit extends Cubit<int> {
  SegmentCubit(super.initialState);

   void onPressed(int page) {
    emit(page);
  }
}
