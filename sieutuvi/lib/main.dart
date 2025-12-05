import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as _;
import 'package:provider/provider.dart';
import 'package:sieutuvi/screens/dashboard_screen.dart';
import 'package:sieutuvi/values/debouncer.dart';
import 'package:sieutuvi/values/utils.dart';
import 'package:sieutuvi/viewmodels/dashboard_viewmodel.dart';

import 'AI/ai_provider.dart';
import 'AI/chat_page.dart';
import 'AI/chat_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => AIProvider()),
        ChangeNotifierProxyProvider<AIProvider, ChatProvider>(
          create: (context) => ChatProvider(
            aiProvider: Provider.of<AIProvider>(context, listen: false),
          ),
          update: (context, ai, chat) {
            chat ??= ChatProvider(aiProvider: ai);
            chat.updateAi(ai);
            return chat;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.cutoutHeight = MediaQuery.of(context).viewPadding.top;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DashboardScreen(),
    );
  }
}
