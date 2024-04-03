import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
    return Card(
      color: Colors.grey[200],
      elevation: .2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          final selectedDateTimeRange = await getUpdatedDateTimeRange(context);
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
        child: Row(
          children: [
            dateRange != null
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${dateRange!.start.day} ${DateFormat.MMMM().format(dateRange!.start)} ',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                          ),
                          const Text('to'),
                          Text(
                            ' ${dateRange!.end.day} ${DateFormat.MMMM().format(dateRange!.end)}',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Select duration of the cause',
                      style: TextStyle(
                          color: Colors.black87.withOpacity(.7),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                CupertinoIcons.calendar,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ],
        ),
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
