

List<int> getNumericCheckList(List<String> doneDays) {
  // Define the order of the days of the week, starting from Saturday
  List<String> allDays = [
    "saturday",
    "sunday",
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday"
  ];

  // Get today's day of the week
  int todayIndexISO = DateTime.now().weekday;

  int todayIndexCalc(todayIndexISO) {
    switch (todayIndexISO) {
      case 1:
        return 2;
      case 2:
        return 3;
      case 3:
        return 4;
      case 4:
        return 5;
      case 5:
        return 6;
      case 6:
        return 0;
      case 7:
        return 1;
      default:
        return 0;
    }
  }
  int todayIndex = todayIndexCalc(todayIndexISO);
  String today = allDays[todayIndex];

  List<int> binaryRepresentation = [];

  if (doneDays.isNotEmpty) {
    for (String day in allDays) {
      if (day == today) {
        binaryRepresentation.add(2);
      } else {
        binaryRepresentation.add(doneDays.contains(day) ? 1 : 0);
      }
    }
  } else {
    for (String day in allDays) {
      if (day == today) {
        binaryRepresentation.add(2);
      } else {
        binaryRepresentation.add(0);
      }
    }
  }
  return binaryRepresentation;
}

