import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sieutuvi/AI/TuVi/horoscope_service.dart';
import 'package:sieutuvi/models/cunghoangdao_model.dart';

import 'ai_provider.dart';
import 'chat_provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<EnumCungHoangDao> listCungHoangDao = EnumCungHoangDao.values;
  final List<Enum12ConGiap> listConGiap = Enum12ConGiap.values;

  ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();

  void _onSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<ChatProvider>().sendMessage(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatProvider>();
    final ai = context.watch<AIProvider>();

    // Scroll mỗi khi messages thay đổi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Chat"),
        actions: [
          IconButton(
            icon: Icon(
              chat.isOptionsVisible
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
            onPressed: () {
              chat.updateOptionVisible();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (chat.isOptionsVisible)
            Column(
              children: [
                _createRowHoroscopeOption(),
                // _createRowChineseHoroscopeOption(),
              ],
            ),

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: chat.messages.length,
              itemBuilder: (context, i) {
                final msg = chat.messages[i];
                final isUser = msg.role == "user";

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (ai.loading)
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: const [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text("AI đang trả lời..."),
                ],
              ),
            ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Nhập tin nhắn...",
                    ),
                    onSubmitted: (_) => _onSend(),
                  ),
                ),
                IconButton(onPressed: _onSend, icon: const Icon(Icons.send)),
              ],
            ),
          ),

          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _createRowHoroscopeOption() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      height: 55, // chiều cao cố định để scroll ngang
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: listCungHoangDao.map((op) {
            return Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ), // spacing giữa các option
              child: GestureDetector(
                onTap: () => _onOptionHoroscopeTap(op),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue, width: 1.2),
                  ),
                  child: Text(
                    op.vnName,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _createRowChineseHoroscopeOption() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      height: 55, // chiều cao cố định để scroll ngang
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: listConGiap.map((op) {
            return Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ), // spacing giữa các option
              child: GestureDetector(
                onTap: () => _onOptionChineseHoroscopeTap(op),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue, width: 1.2),
                  ),
                  child: Text(
                    op.vnName,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _onOptionHoroscopeTap(EnumCungHoangDao option) {
    context.read<ChatProvider>().sendHoroscope(option);
  }

  void _onOptionChineseHoroscopeTap(Enum12ConGiap option) {
    context.read<ChatProvider>().sendChineseHoroscope(option);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
