part of 'search_bloc.dart';

sealed class SearchState {}

class InitialSearch extends SearchState {}

class LoadingSearch extends SearchState {}

class SuccessSearch extends SearchState {
  final List<RecruitmentPost> queryResults;
  SuccessSearch({required this.queryResults});
}

class ErrorSearch extends SearchState {}
