import 'package:intl/intl.dart';
// ------------------------ FUNCTIONS ------------------------
//  File where we store functions used in different files

String toDate(DateTime dateTime) {
  final date = DateFormat.yMMMEd().format(dateTime);

  return '$date';
}

String toTime(DateTime dateTime) {
  final time = DateFormat.Hm().format(dateTime);

  return '$time';
}
