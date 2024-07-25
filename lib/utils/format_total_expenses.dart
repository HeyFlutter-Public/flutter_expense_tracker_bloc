import 'package:intl/intl.dart';

String formatTotalExpenses(double totalExpenses) {
  final currency = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
  final formattedValue = currency.format(totalExpenses.abs());
  return totalExpenses <= 0 ? formattedValue : "-$formattedValue";
}
