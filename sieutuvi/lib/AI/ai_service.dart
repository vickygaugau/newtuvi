import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sieutuvi/values/key.dart';

class AIService {
  static String apiKey = APIKey.openAI;

  static const String _url = "https://openrouter.ai/api/v1/chat/completions";

  static Stream<String> streamChat(String prompt) async* {
    apiKey = APIKey.openAI;
    final request = http.Request("POST", Uri.parse(_url));

    request.headers.addAll({
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
      "HTTP-Referer": "http://localhost",
      "X-Title": "SieuTuVi",
    });

    request.body = jsonEncode({
      "model": "google/gemini-2.0-flash:free",
      "messages": [
        {"role": "user", "content": "Your prompt here"},
      ],
      "stream": true,
    });

    final response = await request.send();

    // Kiểm tra status code trước
    if (response.statusCode != 200) {
      final body = await response.stream.bytesToString();
      try {
        final jsonData = jsonDecode(body);
        final errorMsg = jsonData["error"]?["message"] ?? "Unknown error";
        throw Exception("OpenAI API error: $errorMsg");
      } catch (_) {
        throw Exception("OpenAI API error: ${response.statusCode}");
      }
    }

    // Đọc từng chunk dữ liệu
    await for (final chunk in response.stream.transform(utf8.decoder)) {
      final lines = chunk.split("\n");

      for (final line in lines) {
        if (line.startsWith("data: ")) {
          final jsonStr = line.replaceFirst("data: ", "").trim();

          if (jsonStr == "[DONE]") continue;

          try {
            final jsonData = jsonDecode(jsonStr);
            final delta = jsonData["choices"][0]["delta"];

            if (delta != null && delta["content"] != null) {
              yield delta["content"];
            }
          } catch (_) {}
        }
      }
    }
  }
}
