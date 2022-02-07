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
    var formatter = DateFormat.yMd().add_jm();
    return formatter.format(dateTime);
  }
  static DateTime convertStringToDateTime(String dateTime) {
    var formatter =  DateFormat.yMd().add_jm().parse(dateTime);
   
    return formatter;
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
