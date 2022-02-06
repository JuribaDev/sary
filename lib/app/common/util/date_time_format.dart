import 'package:intl/intl.dart';

class DateTimeFormat {
  static String getMonth(DateTime dateTime) {
    var formatter = DateFormat('MMM');
    return formatter.format(dateTime);
  }

  static String getDayOfMonth(DateTime dateTime) {
    var formatter = DateFormat('dd');
    return formatter.format(dateTime);
  }

  static String getFullDate(DateTime dateTime) {
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  static String getFullDateTime(DateTime dateTime) {
    var formatter = DateFormat('yyyy-MM-dd');
    String time = getTime(dateTime);
    return formatter.format(dateTime) + ' ' + time;
  }

  static String getDayOfWeek(DateTime dateTime) {
    var formatter = DateFormat('EEEE');
    return formatter.format(dateTime);
  }

  static String getTime(DateTime dateTime) {
    var formatter = DateFormat.jm();
    return formatter.format(dateTime);
  }
}
