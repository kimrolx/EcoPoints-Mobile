import 'package:intl/intl.dart';

class DateFormatterUtil {
  static String formatDateWithTime(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy \'at\' hh:mma').format(dateTime);
  }

  static String formatDateWithoutTime(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy').format(dateTime);
  }
}
