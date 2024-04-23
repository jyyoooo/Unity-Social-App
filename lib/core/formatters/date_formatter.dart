import 'package:intl/intl.dart';

String formatPublishedDate(String publishedAt) {
  DateTime dateTime = DateTime.parse(publishedAt);

  DateFormat formatter = DateFormat('d MMM, yyyy - HH:mm');
  String formattedDate = formatter.format(dateTime.toLocal());

  return formattedDate;
}
