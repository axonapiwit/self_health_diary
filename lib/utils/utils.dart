import 'package:intl/intl.dart';

class Utils {
  static formatWeight(double weight) => '\$ ${weight.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
  static formatTime(DateTime time) => DateFormat('HH:mm').format(time);
}


