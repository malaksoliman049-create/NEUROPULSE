import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HealthHistoryScreen extends StatelessWidget {
  const HealthHistoryScreen({super.key});

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
                      "Health History",
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

            // 📊 Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                statCard("assets/images/heart.png", "Heart Rate", "78 bpm"),
                statCard("assets/images/spo2.png", "SpO₂", "97%"),
                statCardIcon(Icons.warning, "Status", "Normal"),
              ],
            ),

            const SizedBox(height: 15),

            // 📈 Timeline
            containerBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Timeline",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  timelineItem("9:00 AM", "Normal", false),
                  timelineItem("11:30 AM", "High Heart Rate", true),
                  timelineItem("2:00 PM", "Low SpO₂", true),
                  timelineItem("4:00 PM", "Normal", false),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔔 Alerts
            containerBox(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text("Alerts History :",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text("View ALL >", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 10),

                  alertItem("High Heart Rate at 2:45 PM",
                      "110 bpm – High Heart Rate Alert"),
                  alertItem("Low SpO₂ at 10:10 AM",
                      "88% – Low SpO₂ Alert"),
                ],
              ),
            ),

            const Spacer(),

            // 🔻 Bottom Navigation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  navItem("assets/images/home.svg", "Home"),
                  navItem("assets/images/bot.svg", "Chatbot"),
                  navItem("assets/images/profile.svg", "Profile"),
                  navItem("assets/images/setting.svg", "Setting"),
                  navItem("assets/images/alert.svg", "Alert"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📊 Stat Card
  Widget statCard(String img, String title, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(img, width: 24),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 11)),
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget statCardIcon(IconData icon, String title, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.yellow),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 11)),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green)),
        ],
      ),
    );
  }

  Widget containerBox({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }

  Widget timelineItem(String time, String text, bool warning) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            warning ? Icons.warning : Icons.circle,
            size: 10,
            color: warning ? Colors.red : Colors.green,
          ),
          const SizedBox(width: 10),
          Text(time, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: warning ? Colors.red : Colors.black,
              fontWeight: warning ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget alertItem(String title, String sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.red),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.red)),
              Text(sub,
                  style: const TextStyle(
                      fontSize: 11, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget navItem(String icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, width: 24),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 11)),
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