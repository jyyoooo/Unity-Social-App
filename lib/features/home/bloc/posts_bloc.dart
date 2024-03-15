import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/features/home/data/source/posts_repo.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';

part 'posts_event.dart';
part 'posts_states.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<FetchAllPosts>((event, emit) async {
      emit(LoadingPosts());
      final posts =
          await PostsRepository().fetchAllPostsFromCategory(event.category);
      if (event.category == 'Animals') {
        emit(AnimalsPosts(allPosts: posts));
      } else if (event.category == 'Humanitarian') {
        emit(HumanitarianPosts(allPosts: posts));
      } else if (event.category == 'Water') {
        emit(WaterPosts(allPosts: posts));
      } else if (event.category == 'Environment') {
        emit(EnvironmentPosts(allPosts: posts));
      }
    });
  }
}
