import 'package:intl/intl.dart';

String formatDate({required String inputDate, String? format}) {
  DateTime dateTime = DateTime.parse(inputDate);

  DateFormat outputFormat =
      DateFormat(format != null ? 'dd/MM/yyyy' : 'dd-MM-yyyy');

  return outputFormat.format(dateTime);
}