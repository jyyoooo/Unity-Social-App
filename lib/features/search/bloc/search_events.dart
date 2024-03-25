part of 'search_bloc.dart';

sealed class SearchEvent {}

class SearchQuery extends SearchEvent {
  final String query;
  SearchQuery({required this.query});
}

class FilterByCategory extends SearchEvent {
  final String category;
  FilterByCategory({required this.category});
}

class FilterByDuration extends SearchEvent {
  final DurationFilter duration;
  FilterByDuration({required this.duration});
}
