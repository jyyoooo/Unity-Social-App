import 'package:flutter_bloc/flutter_bloc.dart';

enum ButtonState { idle, loading }

class ButtonCubit extends Cubit<bool> {
  ButtonCubit() : super(false);

  void startLoading() => emit(true);
  void stopLoading()=> emit(false);

}
