// import 'dart:math';
//
// class MoonPhaseResult {
//   final String name;
//   final String icon;
//
//   MoonPhaseResult(this.name, this.icon);
// }
//
// class MoonPhase {
//   // Tính Julian Day từ DateTime
//   static double julianDay(DateTime date) {
//     int year = date.year;
//     int month = date.month;
//     double day =
//         date.day + (date.hour + date.minute / 60 + date.second / 3600) / 24;
//
//     if (month <= 2) {
//       year -= 1;
//       month += 12;
//     }
//
//     int A = year ~/ 100;
//     int B = 2 - A + (A ~/ 4);
//
//     double JD =
//         (365.25 * (year + 4716)).floor() +
//         (30.6001 * (month + 1)).floor() +
//         day +
//         B -
//         1524.5;
//
//     return JD;
//   }
//
//   // Hàm tính pha mặt trăng
//   MoonPhaseResult getMoonPhase(DateTime date) {
//     double JD = julianDay(date);
//
//     const double synodicMonth = 29.53058867;
//     const double epoch = 2451550.1; // mốc trăng non 2000-01-06
//
//     double days = JD - epoch;
//     double age = days % synodicMonth;
//     double fraction = age / synodicMonth;
//
//     double phaseAngleDeg = fraction * 360;
//     double phaseRad = fraction * 2 * pi;
//
//     double illumination = (1 - cos(phaseRad)) / 2;
//
//     return getMoonPhaseInfo(fraction);
//   }
//
//   // Tên pha dựa trên fraction
//   MoonPhaseResult getMoonPhaseInfo(double fraction) {
//     if (fraction < 0.0625 || fraction >= 0.9375) {
//       return MoonPhaseResult("New Moon", "assets/moon/0_new.png");
//     } else if (fraction < 0.1875) {
//       return MoonPhaseResult(
//         "Waxing Crescent",
//         "assets/moon/1_waxing_crescent.png",
//       );
//     } else if (fraction < 0.3125) {
//       return MoonPhaseResult(
//         "First Quarter",
//         "assets/moon/2_first_quarter.png",
//       );
//     } else if (fraction < 0.4375) {
//       return MoonPhaseResult(
//         "Waxing Gibbous",
//         "assets/moon/3_waxing_gibbous.png",
//       );
//     } else if (fraction < 0.5625) {
//       return MoonPhaseResult("Full Moon", "assets/moon/4_full.png");
//     } else if (fraction < 0.6875) {
//       return MoonPhaseResult(
//         "Waning Gibbous",
//         "assets/moon/5_waning_gibbous.png",
//       );
//     } else if (fraction < 0.8125) {
//       return MoonPhaseResult("Last Quarter", "assets/moon/6_last_quarter.png");
//     } else {
//       return MoonPhaseResult(
//         "Waning Crescent",
//         "assets/moon/7_waning_crescent.png",
//       );
//     }
//   }
// }
