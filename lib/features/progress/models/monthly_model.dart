class MonthlyProgressModel {
  final List<DateTime?> dates;

  MonthlyProgressModel({
    required this.dates,
  });

  factory MonthlyProgressModel.fromJson(Map<String, dynamic> json) {
    List<dynamic>? data = json['data'];
    List<DateTime?> parsedDates = data
        ?.map((dateString) => DateTime.tryParse(dateString))
        .toList() ?? [];

    return MonthlyProgressModel(
      dates: parsedDates,
    );
  }
}
