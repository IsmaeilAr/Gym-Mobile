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

  static String extractTime(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final formattedTime = DateFormat('h:mm a').format(dateTime);
    return formattedTime;
  }

  factory CoachTimeModel.fromJson(Map<String, dynamic> json) {
    return CoachTimeModel(
      startTime: extractTime(json['startTime']),
      endTime: extractTime(json['endTime']),
      dayId: json['dayId'],
      isAvailable: false,
    );
  }
}
