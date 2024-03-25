import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unitysocial/core/widgets/snack_bar.dart';
import 'package:unitysocial/features/recruit/bloc/recruit_bloc.dart';

class DateTimeRangeWidget extends StatelessWidget {
  const DateTimeRangeWidget({
    Key? key,
    required this.dateRange,
    required this.recruitProvider,
  }) : super(key: key);

  final DateTimeRange? dateRange;
  final RecruitBloc recruitProvider;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          dateRange != null
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      '${dateRange!.start.day} - ${dateRange!.start.month} - ${dateRange!.start.year}    to    ${dateRange!.end.day} - ${dateRange!.end.month} - ${dateRange!.end.year}',
                    ),
                  ),
                )
              : const Expanded(
                  child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Select duration of the cause'),
                )),
          IconButton(
            icon: const Icon(
              CupertinoIcons.calendar,
              color: CupertinoColors.activeBlue,
            ),
            onPressed: () async {
              final selectedDateTimeRange =
                  await getUpdatedDateTimeRange(context);
              if (selectedDateTimeRange != null) {
                if (selectedDateTimeRange.start.isBefore(today) ||
                    selectedDateTimeRange.end.day == today.day) {
                  return showSnackbar(context, 'Select a different date range');
                } else {
                  recruitProvider.add(DateRangeUpdateEvent(
                      updatedDateTimeRange: selectedDateTimeRange));
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

Future<DateTimeRange?> getUpdatedDateTimeRange(BuildContext context) async {
  return await showDateRangePicker(
    // initialDateRange: recruitProvider.dateRange,
    confirmText: 'done',
    context: context,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
}
