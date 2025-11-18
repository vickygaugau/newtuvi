import 'package:intl/intl.dart'; // để format giờ

class Utils {
  static String getCurrentTime24h() {
    final now = DateTime.now();
    return DateFormat('HH:mm').format(now);
  }
}
