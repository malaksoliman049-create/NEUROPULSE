import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                width: double.infinity,
                height: 120,
                color: const Color(0xFF3E6EA8),
                child: const Center(
                  child: Text(
                    "NeuroPulse",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 👋 Hello
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hello, Guest.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E6EA8),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ❤️ Heart Rate Card
            buildCard(
              icon: const Text("❤️", style: TextStyle(fontSize: 20)),
              title: "Heart Rate",
              value: "78 bpm",
              color: const Color(0xFF3E6EA8),
            ),

            // 🫁 SpO₂ Card (EMOJI)
            buildCard(
              icon: const Text("🫁", style: TextStyle(fontSize: 20)),
              title: "SpO₂",
              value: "97%",
              color: const Color(0xFF3E6EA8),
            ),

            const SizedBox(height: 10),

            // 🔴 Buttons
            buildButton("Start Assessment"),
            buildButton("Alert Notification"),

            const SizedBox(height: 10),

            // ⚪ Gray Buttons
            buildGrayButton("Health History"),
            buildGrayButton("Chat with AI"),

            const Spacer(),

            // 🔻 Bottom Nav (ICONS)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.grey[300],
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home_rounded, size: 28),
                  Icon(Icons.history_rounded, size: 28),
                  Icon(Icons.smart_toy_rounded, size: 28),
                  Icon(Icons.person_rounded, size: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Card
  Widget buildCard({
    required Widget icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            icon, // 👈 هنا بقى Widget بدل String
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔴 Red Button
  Widget buildButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // ⚪ Gray Button
  Widget buildGrayButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// ✂️ Header curve
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
