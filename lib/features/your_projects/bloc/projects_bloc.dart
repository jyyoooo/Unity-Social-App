import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/your_projects/data/projects_repo.dart';

part 'project_event.dart';
part 'projects_states.dart';

class ProjectsBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectsBloc() : super(Initial()) {
    on<FetchUserProjects>((event, emit) async {
      emit(LoadingProjects());
      final posts = await ProjectRepo().fetchUserProjects(event.hostId);
      emit(FetchSuccess(posts: posts));
    });

    on<UpdateUserProject>((event, emit) async {
      await ProjectRepo().requestUpdateProject();
      emit(UpdateSuccess(postID: event.postID));
    });
  }
}
