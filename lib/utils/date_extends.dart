import 'package:intl/intl.dart';

class DateExtends {
   static String format (int timestamp) {
     String formatDate = DateFormat("MM-dd HH:mm").format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
    return formatDate;
  }
}
