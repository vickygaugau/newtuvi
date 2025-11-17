import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const _apiKey =
      "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";
  static String get apiKey => _apiKey;

  static const String _url = "https://api.openai.com/v1/chat/completions";

  static Stream<String> streamChat(String prompt) async* {
    final request = http.Request("POST", Uri.parse(_url));

    request.headers.addAll({
      "Content-Type": "application/json",
      "Authorization": "Bearer $_apiKey",
    });

    request.body = jsonEncode({
      "model": "gpt-4o-mini",
      "messages": [
        {"role": "user", "content": prompt},
      ],
      "stream": true,
    });

    final response = await request.send();

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
