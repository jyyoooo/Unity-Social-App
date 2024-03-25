import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_location_search/flutter_location_search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:unitysocial/core/widgets/custom_button.dart';
import 'package:unitysocial/core/widgets/unity_appbar.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/recruit/screens/widgets/date_time_range_widgets.dart';
import 'package:unitysocial/features/recruit/screens/widgets/text_field_header_widget.dart';
import 'package:unitysocial/features/your_projects/bloc/update_cubits/date_range_cubit.dart';
import 'package:unitysocial/features/your_projects/bloc/update_cubits/location_cubit.dart';
import 'package:unitysocial/features/your_projects/screens/widgets/project_status_widgets.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({super.key, required this.post});

  final RecruitmentPost post;

  @override
  Widget build(BuildContext context) {
    // created scoped bloc providers to manage the state of the location and date range updates
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: UnityAppBar(
            title: post.title,
            showBackBtn: true,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            _showProjectStatus(post),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextFieldHeader(title: 'Desctiption'),
                  _description(),
                  // const SizedBox(height: 10),
                  const TextFieldHeader(title: 'Duration'),
                  _showDateRange(context, (updatedDateRange) {
                    // Use updatedDateRange as needed
                    log('Updated Date Range: $updatedDateRange');
                  }),
                  // const SizedBox(height: 10),
                  const TextFieldHeader(title: 'Location'),
                  _showLocation(context, (updatedLocation) {
                    // Use updatedLocation as needed
                    log('Updated Location: $updatedLocation');
                  }),
                  SizedBox(width: 200,
                    child: LocationSearchWidget(
                      
                      onPicked: (data) {},
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: CustomButton(
                      label: 'Update Project',
                      onPressed: () {
                        // Use context.read<LocationCubit>().state and context.read<DateRangeCubit>().state as needed
                        final updatedLocation =
                            context.read<LocationCubit>().state;
                        final updatedDateRange =
                            context.read<DateRangeCubit>().state;
                        log('Updated Location: $updatedLocation');
                        log('Updated Date Range: $updatedDateRange');
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Card _description() {
    return Card(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(post.description, style: const TextStyle()),
        ));
  }
}

Card _showProjectStatus(RecruitmentPost post) {
  return Card(
    elevation: 0,
    color: CupertinoColors.systemGrey5,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Project status'),
        ),
        post.isApproved ? approvedMessage() : pendingMessage()
      ],
    ),
  );
}

Padding _showLocation(context, Function(String) onLocationUpdated) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: BlocBuilder<LocationCubit, String>(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Row(
              children: [
                const Icon(CupertinoIcons.location, size: 20),
                const SizedBox(width: 10),
                Expanded(child: Text(state)),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              final updatedLocation = await LocationSearch.show(
                  searchBarTextColor: CupertinoColors.activeBlue,
                  context: context,
                  lightAdress: true,
                  mode: Mode.fullscreen);
              if (updatedLocation != null) {
                context
                    .read<LocationCubit>()
                    .updateLocation(updatedLocation.address.toString());
                onLocationUpdated(updatedLocation.address.toString());
              }
            },
            icon: const Icon(
              CupertinoIcons.pen,
              color: CupertinoColors.activeBlue,
            ),
          ),
        ],
      ),
    ),
  );
}

Card _showDateRange(context, Function(DateTimeRange) onDateRangeUpdated) {
  return Card(
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<DateRangeCubit, DateTimeRange>(
        builder: (context, dateRange) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(CupertinoIcons.calendar),
                  const SizedBox(width: 10),
                  Text(
                    '${dateRange.start.day} ${DateFormat.MMMM().format(dateRange.start)} ',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  ),
                  const Text('to'),
                  Text(
                    ' ${dateRange.end.day} ${DateFormat.MMMM().format(dateRange.end)}',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              IconButton(
                onPressed: () async {
                  final updatedDateTimeRange =
                      await getUpdatedDateTimeRange(context);
                  if (updatedDateTimeRange != null) {
                    context
                        .read<DateRangeCubit>()
                        .updateDateRange(updatedDateTimeRange);
                    onDateRangeUpdated(updatedDateTimeRange);
                  }
                },
                icon: const Icon(
                  CupertinoIcons.pen,
                  color: CupertinoColors.activeBlue,
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
