import '../../features/coaches/model/coach_time_model.dart';

List<CoachTimeModel> getCoachDayList(List<CoachTimeModel> availableDays) {
  CoachTimeModel dayOff(index) {
    CoachTimeModel newDay = CoachTimeModel(
        startTime: "", endTime: "", dayId: index, isAvailable: false);
    return newDay;
  }

  List<CoachTimeModel> daysList = [];

  if (availableDays.isNotEmpty) {
    for (int day = 1; day <= 7; day++) {
      if (availableDays
          .any((element) => element.dayId == day)) // if day is available
      {
        CoachTimeModel dayOn =
            availableDays.firstWhere((element) => element.dayId == day);
        dayOn.isAvailable = true;
        daysList.add(dayOn);
      }
      // if day is off
      else {
        daysList.add(dayOff(day));
      }
    }
  } else {
    for (int index = 1; index <= 7; index++) {
      daysList.add(dayOff(index));
    }
  }
  return daysList;
}
