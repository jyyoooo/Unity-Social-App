import 'package:flutter_bloc/flutter_bloc.dart';

class SignOutCubit extends Cubit<bool> {
  SignOutCubit() : super(false);

  void startSignOut() => emit(true);

  void completeSignOut() => emit(false);
}
