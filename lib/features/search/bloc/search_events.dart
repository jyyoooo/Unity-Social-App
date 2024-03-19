part of 'search_bloc.dart';

sealed class SearchEvent {}

class SearchQuery extends SearchEvent {
  final String query;
  SearchQuery({required this.query});
}
