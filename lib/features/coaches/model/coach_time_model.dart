class CoachTimeModel {
  final String startTime;
  final String endTime;
  final int dayId;

  CoachTimeModel({
    required this.startTime,
    required this.endTime,
    required this.dayId,
  });

  factory CoachTimeModel.fromJson(Map<String, dynamic> json) {
    return CoachTimeModel(
      startTime: json['startTime'].toString().substring(11, 16),
      endTime: json['endTime'].toString().substring(11, 16),
      dayId: json['dayId'],
    );
  }
}