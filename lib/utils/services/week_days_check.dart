import 'package:flutter/cupertino.dart';

// List<int> getNumericCheckList(List<String> doneDays) {
//   // Define the order of the days of the week, starting from Saturday
//   List<String> allDays = ["saturday", "sunday", "monday", "tuesday", "wednesday", "thursday", "friday"];
//
//   // Get today's day of the week
//   String today = allDays[(DateTime.now().weekday % 7) +1];
//
//   // Initialize an empty list to hold the binary representation
//   List<int> binaryRepresentation = [];
//   if (doneDays.isNotEmpty) {
//     for (String day in allDays) {
//       // If the current day is in the doneDays list, add a 1 to the binary representation
//       // If the current day is today, add a 2 to the binary representation
//       // Otherwise, add a 0
//       if (day == today) {
//         binaryRepresentation.add(2);
//       } else {
//         binaryRepresentation.add(doneDays.contains(day) ? 1 : 0);
//       }
//     }
//   } else {
//     for (String day in allDays) {
//       debugPrint(day);
//       // If the current day is in the doneDays list, add a 1 to the binary representation
//       // If the current day is today, add a 2 to the binary representation
//       // Otherwise, add a 0-
//       if (day == today) {
//         binaryRepresentation.add(2);
//       } else {
//         binaryRepresentation.add(0);
//       }
//     }
//
//   }
//
//
//   // Return the binary representation
//   return binaryRepresentation;
// }

List<int> getNumericCheckList(List<String> doneDays) {
  // Define the order of the days of the week, starting from Saturday
  List<String> allDays = ["saturday", "sunday", "monday", "tuesday", "wednesday", "thursday", "friday"];

  // Get today's day of the week
  int todayIndexISO = DateTime.now().weekday % 7;
  int todayIndexCalc(todayIndexISO){
    switch (todayIndexISO){
      case 0:
        return 1;
      case 1:
        return 3;
      case 2:
        return 4;
      case 3:
        return 5;
      case 4:
        return 6;
      case 5:
        return 6;
      case 6:
        return 0;
      default:
        return 0;
    }
  }
  int todayIndex = todayIndexCalc(todayIndexISO);
  debugPrint(todayIndex.toString());
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
