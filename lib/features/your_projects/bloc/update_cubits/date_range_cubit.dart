
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateRangeCubit extends Cubit<DateTimeRange> {
  DateRangeCubit(DateTimeRange initialDateRange)
      : super(initialDateRange);

  void updateDateRange(DateTimeRange newDateRange) {
    emit(newDateRange);
  }
}
