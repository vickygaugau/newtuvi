import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sieutuvi/AI/ai_provider.dart';

import '../ai_service.dart';

class HoroscopeService {
  /// Fetch tử vi từ API Aztro (miễn phí)
  static Future<Map<String, dynamic>> fetchRawHoroscope(String sign) async {
    final url = Uri.parse(
      "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/daily?sign=$sign&day=TODAY",
    );

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    );

    if (response.statusCode != 200) {
      throw Exception("Lỗi khi fetch tử vi: ${response.body}");
    }

    return jsonDecode(response.body);
  }

  /// Gửi dữ liệu tử vi thô vào GPT để viết lại tiếng Việt
  static String generateVietnameseHoroscope(
    Map<String, dynamic> rawData,
    String sign,
  ) {
    final prompt =
        """
Bạn là chuyên gia viết tử vi Việt Nam.

Dữ liệu tử vi gốc cho cung $sign:
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
  static Future<String> getHoroscopeVI(String sign) async {
    final raw = await fetchRawHoroscope(sign);
    final promt = generateVietnameseHoroscope(raw, sign);
    return promt;
  }
}
