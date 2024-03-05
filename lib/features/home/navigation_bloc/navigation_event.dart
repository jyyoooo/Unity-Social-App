part of 'navigation_bloc.dart';

class NavigationEvent {}

class ChangeScreenEvent extends NavigationEvent {
  final int index;
  ChangeScreenEvent({required this.index});
}
