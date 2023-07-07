import 'package:intl/intl.dart';

class AppFormat{
  static String justDate (DateTime datetime){
    return DateFormat('yyyy-MM-dd').format(datetime);
  }
}