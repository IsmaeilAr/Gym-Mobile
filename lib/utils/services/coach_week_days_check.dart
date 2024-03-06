import '../../features/coaches/model/coach_time_model.dart';

List<CoachTimeModel> getCoachDayList(List<CoachTimeModel> availableDays) {
  CoachTimeModel dayOff(index) {
    CoachTimeModel newDay = CoachTimeModel(
        startTime: "", endTime: "", dayId: index, isAvailable: false);
    return newDay;
  }

  List<CoachTimeModel> daysList = [];

  List<int> allDays = [1, 2, 3, 4, 5, 6, 7];

  if (availableDays.isNotEmpty) {
    for (int day in allDays) {
      if (allDays.contains(availableDays[day].dayId)) // if day is available
      {
        CoachTimeModel dayOn = availableDays[day];
        dayOn.isAvailable = true;
        daysList.add(dayOn);
      }
      // if day is off
      else {
        daysList.add(dayOff(day));
      }
    }
  }
  // if no days set yet
  else {
    for (int index = 1; index < 8; index++) {
      daysList.add(dayOff(index));
    }
  }
  return daysList;
}
