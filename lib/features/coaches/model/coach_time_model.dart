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

  factory CoachTimeModel.fromJson(Map<String, dynamic> json) {
    return CoachTimeModel(
      startTime: json['startTime'].toString().substring(11, 16),
      endTime: json['endTime'].toString().substring(11, 16),
      dayId: json['dayId'],
      isAvailable: false,
    );
  }
}