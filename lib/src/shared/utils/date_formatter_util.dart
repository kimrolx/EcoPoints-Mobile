import 'package:intl/intl.dart';

class DateFormatterUtil {
  static String formatDate(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy \'at\' HH:mm').format(dateTime);
  }
}
