import 'package:flutter/material.dart';

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
    {"type": "bot", "text": "Do you have a history of Hypertension?"},
    {"type": "user", "text": "Yes, I do have Hypertension."},
    {"type": "bot", "text": "Do you have Diabetes?"},
    {"type": "user", "text": "No, I don't."},
  ];

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "type": "user",
        "text": controller.text.trim(),
      });

      // fake bot reply (مؤقت لحد backend)
      messages.add({
        "type": "bot",
        "text": "Got it 👍",
      });

      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),

      body: SafeArea(
        child: Column(
          children: [
            // 🔵 Header
            ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 140,
                color: const Color(0xFF4C82B4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Spacer(),
                    const Text(
                      "Health Assistant",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 💬 Messages
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

            // 📝 Input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Type your message here...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send, color: Colors.blue),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 🤖 Bot Message
  Widget botMessage(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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

  // 👤 User Message
  Widget userMessage(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue[300],
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

// ✂️ Header Curve
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 30);

    path.quadraticBezierTo(
      size.width / 2,
      size.height + 30,
      size.width,
      size.height - 30,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
