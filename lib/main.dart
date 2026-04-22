import 'package:flutter/material.dart';
import 'package:neuropulse/screens/chatbot_screen.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/chatbot', // أول شاشة

      routes: {
     
        '/chatbot': (context) => const ChatbotScreen(),


      },
    );
  }
}