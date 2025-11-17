import 'package:flutter/cupertino.dart';

import 'ai_service.dart';

class AIProvider with ChangeNotifier {
  String _text = "";
  bool _loading = false;

  String get text => _text;
  bool get loading => _loading;

  Future<void> ask(String prompt) async {
    _text = "";
    _loading = true;
    notifyListeners();

    final stream = AIService.streamChat(prompt);

    await for (final chunk in stream) {
      await Future.delayed(Duration(milliseconds: 50));
      _text += chunk;
      notifyListeners();
    }

    _loading = false;
    notifyListeners();
  }
}
