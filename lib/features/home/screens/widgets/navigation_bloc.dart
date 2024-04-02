import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationVisibility { showNavBar, hideNavBar }

class NavigationCubit extends Cubit<NavigationVisibility> {
  NavigationCubit() : super(NavigationVisibility.showNavBar);

  void showNavBar() => emit(NavigationVisibility.showNavBar);

  void hideNavBar() => emit(NavigationVisibility.hideNavBar);
}
