import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitysocial/core/constants/custom_button.dart';
import 'package:unitysocial/core/constants/snack_bar.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/recruit/data/models/location_model.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/recruit/screens/widgets/text_field_header_widget.dart';
import 'package:unitysocial/features/your_projects/bloc/projects_bloc.dart';
import 'package:unitysocial/features/your_projects/bloc/update_cubits/location_cubit.dart';
import '../bloc/update_cubits/date_range_cubit.dart';
import 'widgets/details_widgets.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({super.key, required this.post});

  final RecruitmentPost post;

  @override
  Widget build(BuildContext context) {
    final updatedLocation = context.read<LocationCubit>().state;
    final updatedDateRange = context.read<DateRangeCubit>().state;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: UnityAppBar(
            title: post.title,
            showBackBtn: true,
            smallTitle: true,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            showProjectStatus(post),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextFieldHeader(title: 'Desctiption'),
                  description(post),
                  const TextFieldHeader(title: 'Duration'),
                  showDateRange(context, (updatedDateRange) {
                    log('Updated Date Range: $updatedDateRange');
                  }, post),
                  const TextFieldHeader(title: 'Location'),
                  showLocation(context, (updatedLocation) {
                    log('Updated Location: $updatedLocation');
                  }, post),
                  const Spacer(),
                  Center(
                    child: post.duration.end.day < DateTime.now().day
                        ? null
                        : CustomButton(
                            label: 'Update Project',
                            onPressed: () {
                              log('BTNUpdated Location: $updatedLocation');
                              log('BTNUpdated Date Range: $updatedDateRange');
                              if (updatedDateRange.start
                                  .isBefore(post.duration.start)) {
                                showSnackbar(
                                    context,
                                    'pick a later date to update',
                                    CupertinoColors.systemRed);
                              } else {
                                BlocProvider.of<ProjectsBloc>(context).add(
                                  UpdateUserProject(
                                    postID: post.id!,
                                    updatedDateRange: updatedDateRange,
                                    updatedLocation: Location(
                                        address: updatedLocation!.address,
                                        latitude: updatedLocation.latitude,
                                        longitude: updatedLocation.longitude),
                                  ),
                                );
                              }
                            },
                          ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 70)
          ],
        ),
      ),
    );
  }
}
