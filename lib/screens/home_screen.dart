import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isConnected = true;
  DateTime? lastSyncTime = DateTime.now();

  int heartRate = 78;
  int spo2 = 97;

  String lastAlert = "High";
  String insight = "Unstable";

  String getLastSyncText() {
    if (lastSyncTime == null) return "No Sync";

    final diff = DateTime.now().difference(lastSyncTime!);

    if (diff.inMinutes < 1) return "Just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
    if (diff.inHours < 24) return "${diff.inHours} hr ago";

    return "${diff.inDays} day ago";
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
                width: double.infinity,
                height: 120,
                color: const Color(0xFF4C82B4),
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

            // 🔌 Connection Status
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                isConnected
                    ? "Connected to smart watch"
                    : "Smart watch not connected",
                style: TextStyle(
                  color: isConnected ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ⏱️ Last Sync
            if (isConnected)
              buildMainCard("Last Sync: ${getLastSyncText()}"),

            const SizedBox(height: 10),

            // ❤️ Data
            if (isConnected) ...[
              buildCard(
                icon: Image.asset("assets/images/heart.png", width: 24),
                title: "Heart Rate",
                value: "$heartRate bpm",
              ),
              buildCard(
                icon: Image.asset("assets/images/spo2.png", width: 24),
                title: "SpO₂",
                value: "$spo2%",
              ),
              buildCard(
                icon: const Icon(Icons.warning, color: Colors.yellow),
                title: "Last Alert",
                value: lastAlert,
              ),
              buildCard(
                icon: const Icon(Icons.lightbulb, color: Colors.yellow),
                title: "Insight",
                value: insight,
              ),
            ],

            if (!isConnected)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Please connect your smart watch",
                  style: TextStyle(color: Colors.red),
                ),
              ),

            const SizedBox(height: 10),

            // ⚪ Health History
            buildGrayButton("Health History"),

            const Spacer(),

            // 🔻 Bottom Nav
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildNavItem("assets/images/home.svg", "Home"),
                  buildNavItem("assets/images/chatbot.svg", "Chatbot"),
                  buildNavItem("assets/images/profile.svg", "Profile"),
                  buildNavItem("assets/images/setting.svg", "Setting"),
                  buildNavItem("assets/images/alert.svg", "Alert"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔵 Main Card (Last Sync)
  Widget buildMainCard(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF4C82B4),
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

  // 🔹 Card
  Widget buildCard({
    required Widget icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF4C82B4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            icon,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  // 🔻 Bottom Nav Item
  Widget buildNavItem(String icon, String label) {
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