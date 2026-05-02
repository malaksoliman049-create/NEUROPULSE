import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'header_clipper.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController controller = TextEditingController();

  List<Map<String, String>> messages = [
    {"type": "bot", "text": "How old are you?"},
    {"type": "user", "text": "I'm 45 years old."},
    {"type": "bot", "text": "Do you have Hypertension?"},
    {"type": "user", "text": "Yes, I do."},
  ];

  Map<String, Map<String, String>> tMap = {
    'en': {
      'title': 'Health Assistant',
      'hint': 'Type your message here...',
      'got': 'Got it 👍',
    },
    'ar': {
      'title': 'المساعد الصحي',
      'hint': 'اكتب رسالتك هنا...',
      'got': 'تم 👍',
    }
  };

  void sendMessage(String Function(String) t) {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({"type": "user", "text": text});
      messages.add({"type": "bot", "text": t('got')});
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final isArabic = langProvider.isArabic;

    String t(String key) => tMap[isArabic ? 'ar' : 'en']![key]!;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFEFEFEF),
        body: SafeArea(
          child: Column(
            children: [
              // HEADER مع زرار الرجوع ثابت ناحية الشمال
              Stack(
                children: [
                  ClipPath(
                    clipper: HeaderClipper(),
                    child: Container(
                      height: 140,
                      color: const Color(0xFF4C82B4),
                      child: Center(
                        child: Text(
                          t('title'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // ✅ زرار الرجوع مثبت ناحية الشمال دائماً
                  Positioned(
                    top: 20,
                    left: 10, // ثابت لليسار
                    child: IconButton(
                      // استخدمت ArrowBack العادي عشان يكون اتجاهه منطقي لليسار
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      onPressed: () {
                        Navigator.pop(context); 
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // قائمة الرسائل
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return msg["type"] == "user"
                        ? userMessage(msg["text"]!)
                        : botMessage(msg["text"]!);
                  },
                ),
              ),

              // منطقة الإدخال
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: t('hint'),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => sendMessage(t),
                      icon: const Icon(Icons.send, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget botMessage(String text) {
    return Row(
      children: [
        const Icon(Icons.smart_toy, color: Colors.blue),
        const SizedBox(width: 8),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(text),
        ),
      ],
    );
  }

  Widget userMessage(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.person, color: Colors.grey),
      ],
    );
  }
}