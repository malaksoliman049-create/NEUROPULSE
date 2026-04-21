import 'package:flutter/material.dart';

class ChatWithPatient extends StatelessWidget {
  final bool isArabic;

  const ChatWithPatient({super.key, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            // 🔵 Header
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3B67A1),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(400, 80),
                    ),
                  ),
                ),

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Icon(
                          isArabic ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),

                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                          ),
                        ),

                        const SizedBox(width: 10),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Ahmed Ali",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Serif',
                              ),
                            ),
                            Text(
                              isArabic ? "متصل الآن" : "Online",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),
                        const Icon(Icons.more_vert, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // 💬 Chat Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // رسالة الدكتور
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isArabic
                              ? "كيف تشعر اليوم؟"
                              : "How are you feeling today?",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // رسالة المريض
                    Align(
                      alignment:
                          isArabic ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9BB3C9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isArabic ? "أشعر بدوخة" : "I feel dizzy",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ✉️ Input Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      decoration: InputDecoration(
                        hintText: isArabic
                            ? "اكتب رسالتك هنا..."
                            : "Type your message here...",
                        hintStyle: TextStyle(color: Colors.blue[700]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Icon(Icons.send, color: Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}