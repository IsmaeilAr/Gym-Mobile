import 'dart:developer';
import 'package:intl/intl.dart';

extension TimeFormattingExtension on String {
  String formatTimestamp() {
    // todo localize
    try {
      DateTime dateTime = DateTime.parse(this);
      return DateFormat.jm().format(dateTime);
    } catch (e) {
      log("Error formatting timestamp: $e");
      return "Invalid timestamp";
    }
  }
}


extension TimestampFormatter on DateTime {
  String currentFormatted() {
    final now = DateTime.now();
    if (year == now.year &&
        month == now.month &&
        day == now.day) {
      // If the date is today, display only the time
      return '$hour:$minute';
    } else {
      // If not today, display only the date
      return '$year/$month/$day';
    }
  }
}
