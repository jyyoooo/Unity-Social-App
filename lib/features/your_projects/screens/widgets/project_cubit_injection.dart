import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/your_projects/bloc/update_cubits/date_range_cubit.dart';
import 'package:unitysocial/features/your_projects/bloc/update_cubits/location_cubit.dart';
import 'package:unitysocial/features/your_projects/screens/project_details.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final RecruitmentPost post;

  const ProjectDetailsScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // created scoped bloc providers to manage the state of the location and date range updates

    return MultiBlocProvider(
      providers: [
        BlocProvider<DateRangeCubit>(
          create: (_) => DateRangeCubit(
            DateTimeRange(start: post.duration.start, end: post.duration.end),
          ),
        ),
        BlocProvider<LocationCubit>(
          create: (_) => LocationCubit(post.location),
        ),
      ],
      child: ProjectDetails(
        post: post,
      ),
    );
  }
}
