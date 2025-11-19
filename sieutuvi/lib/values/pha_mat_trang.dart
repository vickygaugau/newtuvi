import 'dart:math';

class MoonPhase {
  // Tính Julian Day từ DateTime
  static double julianDay(DateTime date) {
    int year = date.year;
    int month = date.month;
    double day =
        date.day + (date.hour + date.minute / 60 + date.second / 3600) / 24;

    if (month <= 2) {
      year -= 1;
      month += 12;
    }

    int A = year ~/ 100;
    int B = 2 - A + (A ~/ 4);

    double JD =
        (365.25 * (year + 4716)).floor() +
        (30.6001 * (month + 1)).floor() +
        day +
        B -
        1524.5;

    return JD;
  }

  // Hàm tính pha mặt trăng
  static Map<String, dynamic> getMoonPhase(DateTime date) {
    double JD = julianDay(date);

    const double synodicMonth = 29.53058867;
    const double epoch = 2451550.1; // mốc trăng non 2000-01-06

    double days = JD - epoch;
    double age = days % synodicMonth;
    double fraction = age / synodicMonth;

    double phaseAngleDeg = fraction * 360;
    double phaseRad = fraction * 2 * pi;

    double illumination = (1 - cos(phaseRad)) / 2;

    String phaseName = _phaseName(fraction);

    return {
      "julian_day": JD,
      "age_days": age,
      "fraction": fraction,
      "phase_angle_deg": phaseAngleDeg,
      "illumination": illumination,
      "name": phaseName,
    };
  }

  // Tên pha dựa trên fraction
  static String _phaseName(double f) {
    if (f < 0.02 || f > 0.98) return "New Moon (Trăng non)";
    if (f < 0.25) return "Waxing Crescent (Lưỡi liềm lên)";
    if ((f - 0.25).abs() < 0.02) return "First Quarter (Bán nguyệt lên)";
    if (f < 0.5) return "Waxing Gibbous (Khuyết lớn lên)";
    if ((f - 0.5).abs() < 0.02) return "Full Moon (Trăng tròn)";
    if (f < 0.75) return "Waning Gibbous (Khuyết giảm)";
    if ((f - 0.75).abs() < 0.02) return "Last Quarter (Bán nguyệt xuống)";
    return "Waning Crescent (Lưỡi liềm giảm)";
  }

  void calcMoon() {
    final now = DateTime.now(); // hoặc DateTime.utc(...)
    final phase = MoonPhase.getMoonPhase(now);

    print("Pha: ${phase["name"]}");
    print("Tỷ lệ sáng: ${(phase["illumination"] * 100).toStringAsFixed(1)}%");
    print("Góc pha: ${phase["phase_angle_deg"].toStringAsFixed(2)}°");
    print("Chu kỳ: ${(phase["fraction"] * 100).toStringAsFixed(1)}%");
  }
}
