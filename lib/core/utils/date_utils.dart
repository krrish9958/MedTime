import 'package:intl/intl.dart';

String formatDateTime(DateTime value) =>
    DateFormat('dd MMM yyyy, hh:mm a').format(value);
String formatDate(DateTime value) => DateFormat('dd MMM yyyy').format(value);
String formatTime(DateTime value) => DateFormat('hh:mm a').format(value);
