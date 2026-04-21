import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  final bool isArabic;

  const ChatScreen({super.key, required this.isArabic});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // --- 💾 بيانات الرسائل ---
  final List<Map<String, dynamic>> messages = [
    {
      "text": "How are you feeling today?",
      "isMe": true, // رسالة الطبيب
    },
    {
      "text": "I feel dizzy",
      "isMe": false, // رسالة المريض
    },
  ];

  // قاموس الترجمة
  Map<String, Map<String, String>> localizedValues = {
    'en': {
      'online': 'Online',
      'type_hint': 'Type your message here...',
      'doctor_msg': 'How are you feeling today?',
      'patient_msg': 'I feel dizzy',
    },
    'ar': {
      'online': 'متصل الآن',
      'type_hint': 'اكتب رسالتك هنا...',
      'doctor_msg': 'كيف تشعر اليوم؟',
      'patient_msg': 'أشعر بدوار',
    }
  };

  String t(String key) => localizedValues[widget.isArabic ? 'ar' : 'en']![key] ?? key;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Directionality(
        textDirection: widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              // 🔵 Header (يحتوي على صورة واسم المريض)
              Stack(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B67A1),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(MediaQuery.of(context).size.width, 80),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: widget.isArabic ? null : 10,
                    right: widget.isArabic ? 10 : null,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    top: 55,
                    left: widget.isArabic ? null : 55,
                    right: widget.isArabic ? 55 : null,
                    child: Row(
                      children: [
                        // صورة المريض (Avatar)
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Color(0xFF3B67A1), size: 35),
                        ),
                        const SizedBox(width: 12),
                        // اسم المريض وحالته
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Ahmed Ali",
                              style: TextStyle(
                                color: Colors.white, 
                                fontSize: 18, 
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Serif'
                              ),
                            ),
                            Text(
                              t('online'),
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.videocam_outlined, color: Colors.white, size: 28),
                        const SizedBox(width: 15),
                        const Icon(Icons.more_horiz, color: Colors.white, size: 28),
                      ],
                    ),
                  ),
                ],
              ),

              // 💬 منطقة الرسائل
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    String displayText = msg['text'];
                    
                    if (displayText == "How are you feeling today?") displayText = t('doctor_msg');
                    if (displayText == "I feel dizzy") displayText = t('patient_msg');

                    return _buildChatBubble(displayText, msg['isMe']);
                  },
                ),
              ),

              // ⌨️ حقل الإدخال
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F4F7),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: t('type_hint'),
                            border: InputBorder.none,
                            hintStyle: const TextStyle(color: Color(0xFF6A859A), fontSize: 15),
                          ),
                        ),
                      ),
                      const Icon(Icons.send, color: Color(0xFF3B67A1), size: 28),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFE3F2FD) : const Color(0xFFA9C2D6),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 20),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF3B67A1),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
          ),
        ),
      ),
    );
  }
}