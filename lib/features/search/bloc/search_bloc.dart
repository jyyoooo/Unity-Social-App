import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:unitysocial/core/enums/search_filters.dart';
import 'package:unitysocial/features/home/data/source/posts_repo.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/search/data/search_repository.dart';

part 'search_events.dart';
part 'search_states.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(InitialSearch()) {
    on<SearchQuery>((event, emit) async {
      emit(LoadingSearch());
      log('in search event');
      final List<RecruitmentPost> queryResults =
          await SearchRepository().searchThisQuery(event.query);
      // log('searchREs : ${queryResults}');
      emit(SuccessSearch(queryResults: queryResults));
    });
    on<FilterByCategory>((event, emit) async {
      final fetchedPostsFromCategory =
          await PostsRepository().fetchAllPostsFromCategory(event.category);
      emit(SuccessSearch(queryResults: fetchedPostsFromCategory));
    });
    on<FilterByDuration>((event, emit) async {
      await SearchRepository().filterByDuration(event.duration);
    });
  }
}
