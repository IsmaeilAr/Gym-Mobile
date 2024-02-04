class DayListModel {
  final List<String> days;

  DayListModel({required this.days});

  factory DayListModel.fromJson(Map<String, dynamic> json) {
    List<String> data = List<String>.from(json['data']);
    return DayListModel(days: data);
  }
}
