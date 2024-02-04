class DateService {
  static int daysLeft(DateTime targetDate) {
    final now = DateTime.now();
    final difference = targetDate.difference(now);
    return difference.inDays;
  }
}



// class AgeCalculatorService {
//   static int calculateAge(DateTime dateOfBirth) {
//     final now = DateTime.now();
//     final years = now.year - dateOfBirth.year;
//     final isBeforeBirthday =
//         now.month < dateOfBirth.month ||
//             (now.month == dateOfBirth.month && now.day < dateOfBirth.day);
//     return isBeforeBirthday ? years - 1 : years;
//   }
// }
