part of 'navigation_bloc.dart';

class NavigationState {
  final int index;
  NavigationState({required this.index});
}

final class NavigationInitial extends NavigationState {
  NavigationInitial() : super(index: 0);
}
