import 'package:flutter/cupertino.dart';
import 'package:sieutuvi/AI/TuVi/chinese_horoscope_service.dart';
import 'package:sieutuvi/AI/TuVi/horoscope_service.dart';
import 'package:sieutuvi/models/cunghoangdao_model.dart';

import 'ai_provider.dart';
import 'chat_message_model.dart';

class ChatProvider with ChangeNotifier {
  AIProvider _aiProvider;
  bool isOptionsVisible = true;
  ChatProvider({required AIProvider aiProvider}) : _aiProvider = aiProvider;

  void updateOptionVisible() {
    isOptionsVisible = !isOptionsVisible;
    notifyListeners();
  }

  void updateAi(AIProvider aiProvider) {
    _aiProvider = aiProvider;
  }

  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  /// Message đang trả lời (stream)
  String streamingText = "";

  Future<void> sendMessage(String text) async {
    // 1. Add message của user
    _messages.add(ChatMessage(role: "user", text: text));
    notifyListeners();

    // 2. Tạo tin nhắn rỗng cho assistant (để stream vào)
    streamingText = "";
    final botMessage = ChatMessage(role: "assistant", text: "");
    _messages.add(botMessage);
    notifyListeners();

    // 3. Stream từ AIProvider
    _aiProvider.ask(text);

    // Lắng nghe text thay đổi trong AIProvider
    _aiProvider.addListener(() {
      if (_aiProvider.loading) {
        // update nội dung đang stream
        streamingText = _aiProvider.text;
        _messages[_messages.length - 1] = ChatMessage(
          role: "assistant",
          text: streamingText,
        );
        notifyListeners();
      }
    });
  }

  Future<void> sendHoroscope(EnumCungHoangDao cunghoangdao) async {
    // 1. Add message của user
    _messages.add(ChatMessage(role: "user", text: cunghoangdao.prompt));
    notifyListeners();

    // 2. Tạo tin nhắn rỗng cho assistant (để stream vào)
    streamingText = "";
    final botMessage = ChatMessage(role: "assistant", text: "");
    _messages.add(botMessage);
    notifyListeners();

    // 3. Stream từ AIProvider
    String promt = await HoroscopeService.getHoroscopeVI(cunghoangdao.name);
    _aiProvider.ask(promt);

    // Lắng nghe text thay đổi trong AIProvider
    _aiProvider.addListener(() {
      if (_aiProvider.loading) {
        // update nội dung đang stream
        streamingText = _aiProvider.text;
        _messages[_messages.length - 1] = ChatMessage(
          role: "assistant",
          text: streamingText,
        );
        notifyListeners();
      }
    });
  }

  Future<void> sendChineseHoroscope(Enum12ConGiap congiap) async {
    // 1. Add message của user
    _messages.add(ChatMessage(role: "user", text: congiap.prompt));
    notifyListeners();

    // 2. Tạo tin nhắn rỗng cho assistant (để stream vào)
    streamingText = "";
    final botMessage = ChatMessage(role: "assistant", text: "");
    _messages.add(botMessage);
    notifyListeners();

    // 3. Stream từ AIProvider
    String promt = await ChineseHoroscopeService.getChineseHoroscopeVI(
      congiap.name,
    );
    _aiProvider.ask(promt);

    // Lắng nghe text thay đổi trong AIProvider
    _aiProvider.addListener(() {
      if (_aiProvider.loading) {
        // update nội dung đang stream
        streamingText = _aiProvider.text;
        _messages[_messages.length - 1] = ChatMessage(
          role: "assistant",
          text: streamingText,
        );
        notifyListeners();
      }
    });
  }
}
