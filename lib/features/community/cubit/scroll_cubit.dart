import 'package:bloc/bloc.dart';

class ScrollCubit extends Cubit<bool> {
  ScrollCubit() : super(false); // false means not scrolling down

  void scrollUp() => emit(false);

  void scrollDown() => emit(true);
}
