import 'package:intl/intl.dart';

String thousandSeparators(String numberString) {
  if (numberString.isEmpty) {
    return "";
  }

  try {
    double number = double.parse(numberString);
    final formatter = NumberFormat('#,###', 'en_US');
    return formatter.format(number);
  } catch (e) {
    return numberString;
  }
}
