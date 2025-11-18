import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sieutuvi/AI/ai_provider.dart';

import '../../values/key.dart';
import '../ai_service.dart';

class ChineseHoroscopeService {
  static Future<Map<String, dynamic>> fetchRawChineseHoroscope(
    String sign,
  ) async {
    final url = Uri.parse(
      "https://divineapi.com/api/1.0/get_chinese_horoscope.php",
    );

    final params = {
      "date": DateTime.now().toString(),
      "sign": "TIGER",
      "api_key": APIKey.chinese_horoscope,
      "timezone": 7.0,
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: jsonEncode(params),
    );

    if (response.statusCode != 200) {
      throw Exception("Lỗi khi fetch tử vi: ${response.body}");
    }

    return jsonDecode(response.body);
  }

  /// Gửi dữ liệu tử vi thô vào GPT để viết lại tiếng Việt
  static String generateVietnameseChineseHoroscope(
    Map<String, dynamic> rawData,
    String sign,
  ) {
    final prompt =
        """
Bạn là chuyên gia viết tử vi Việt Nam.

Dữ liệu tử vi gốc cho con giáp $sign:
${jsonEncode(rawData)}

Hãy viết đoạn tử vi 120–180 từ bằng tiếng Việt, chia thành:
- Tổng quan
- Công việc & tài chính
- Tình cảm
- Lời khuyên

Phong cách nhẹ nhàng, tích cực. Không nhắc đến API hay dữ liệu đầu vào.
""";

    return prompt;
  }

  /// Hàm tổng hợp: Fetch dữ liệu → gửi GPT → trả về tử vi tiếng Việt
  static Future<String> getChineseHoroscopeVI(String sign) async {
    final raw = await fetchRawChineseHoroscope(sign);
    final promt = generateVietnameseChineseHoroscope(raw, sign);
    return promt;
  }
}
