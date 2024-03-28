import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoachTimeModel {
  final String startTime;
  final String endTime;
  final int dayId;
  bool isAvailable;

  CoachTimeModel({
    required this.startTime,
    required this.endTime,
    required this.dayId,
    required this.isAvailable,
  });

  static String extractTime(
    String dateTimeString,
  ) {
    // todo localize
    String instantLocale =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final formattedTime = DateFormat('h:mm a', instantLocale).format(dateTime);
    return formattedTime;
  }

  factory CoachTimeModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CoachTimeModel(
      startTime: extractTime(
        json['startTime'],
      ),
      endTime: extractTime(
        json['endTime'],
      ),
      dayId: json['dayId'],
      isAvailable: false,
    );
  }
}
