import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class Obscurity extends Cubit<bool> {
  Obscurity() : super(true);
  void toggleObscure() {
    emit(!state);
    log(state.toString());
  }
}
