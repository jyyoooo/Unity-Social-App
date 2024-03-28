import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_location_search/flutter_location_search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:unitysocial/features/recruit/data/models/recruitment_model.dart';
import 'package:unitysocial/features/recruit/screens/widgets/date_time_range_widgets.dart';
import 'package:unitysocial/features/your_projects/bloc/update_cubits/date_range_cubit.dart';
import 'package:unitysocial/features/your_projects/bloc/update_cubits/location_cubit.dart';
import 'package:unitysocial/features/your_projects/screens/widgets/project_status_widgets.dart';

Card description(RecruitmentPost post) {
  return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(post.description, style: const TextStyle()),
      ));
}

Card showProjectStatus(RecruitmentPost post) {
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
        post.duration.end.isBefore(DateTime.now())
            ? expiredMessage()
            : post.isApproved
                ? approvedMessage()
                : pendingMessage()
      ],
    ),
  );
}

Padding showLocation(
    context, Function(String) onLocationUpdated, RecruitmentPost post) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: BlocBuilder<LocationCubit, String>(
      builder: (context, stateLocation) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Row(
              children: [
                const Icon(CupertinoIcons.location, size: 20),
                const SizedBox(width: 10),
                Expanded(child: Text(stateLocation,),),
              ],
            ),
          ),
          post.duration.end.day < DateTime.now().day
              ? const SizedBox()
              : IconButton(
                  onPressed: () async {
                    final updatedLocation = await LocationSearch.show(
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

Card showDateRange(
    context, Function(DateTimeRange) onDateRangeUpdated, RecruitmentPost post) {
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
              post.duration.end.day < DateTime.now().day
                  ? const SizedBox()
                  : IconButton(
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
