import 'package:intl/intl.dart';

class DateFormatter {
  static String fullDateWithTime(DateTime date) {
    return DateFormat("dd MMM, yyyy • HH:mm", 'pt_BR').format(date);
  }
}