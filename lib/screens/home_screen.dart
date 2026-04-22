import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

// 🧠 Model
class HealthData {
  final int heartRate;
  final int spo2;
  final String lastAlert;
  final String insight;
  final bool isConnected;
  final DateTime? lastSyncTime;

  HealthData({
    required this.heartRate,
    required this.spo2,
    required this.lastAlert,
    required this.insight,
    required this.isConnected,
    this.lastSyncTime,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = const [
      HomeContent(),
      ChatbotScreen(),
      ProfileScreen(),
      SettingsScreen(),
      AlertScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4C82B4),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: navIcon("assets/images/home.svg"),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: navIcon("assets/images/bot.svg"),
            label: "Chatbot",
          ),
          BottomNavigationBarItem(
            icon: navIcon("assets/images/profile.svg"),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: navIcon("assets/images/setting.svg"),
            label: "Setting",
          ),
          BottomNavigationBarItem(
            icon: navIcon("assets/images/alert.svg"),
            label: "Alert",
          ),
        ],
      ),
    );
  }

  // 🔥 بدون تغيير ألوان الأيقونات
  Widget navIcon(String path) {
    final isSvg = path.endsWith(".svg");

    return isSvg
        ? SvgPicture.asset(
            path,
            width: 24,
          )
        : Image.asset(
            path,
            width: 24,
          );
  }
}

// 🏠 Home Content
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  HealthData data = HealthData(
    heartRate: 78,
    spo2: 97,
    lastAlert: "High",
    insight: "Unstable",
    isConnected: true,
    lastSyncTime: DateTime.now(),
  );

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      data = HealthData(
        heartRate: 80,
        spo2: 95,
        lastAlert: "Normal",
        insight: "Stable",
        isConnected: true,
        lastSyncTime: DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: SafeArea(
        child: SingleChildScrollView(
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ❤️ Cards
              if (data.isConnected) ...[
                buildCard(
                  "assets/images/heart.png",
                  "Heart Rate",
                  "${data.heartRate} bpm",
                ),
                buildCard(
                  "assets/images/spo2.png",
                  "SpO₂",
                  "${data.spo2}%",
                ),
                buildCard(
                  "assets/images/last.svg",
                  "Last Alert",
                  data.lastAlert,
                ),
                buildCard(
                  "assets/images/insight.png",
                  "Insight",
                  data.insight,
                ),
              ],

              if (!data.isConnected)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Please connect your smart watch",
                    style: TextStyle(color: Colors.red),
                  ),
                ),

              const SizedBox(height: 10),

              buildGrayButton("Health History"),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // 📦 Card (بدون تغيير لون الأيقونة)
  Widget buildCard(String iconPath, String title, String value) {
    final isSvg = iconPath.endsWith(".svg");

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF4C82B4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          isSvg
              ? SvgPicture.asset(
                  iconPath,
                  width: 30,
                  height: 30,
                )
              : Image.asset(
                  iconPath,
                  width: 30,
                  height: 30,
                ),

          const SizedBox(width: 12),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGrayButton(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

// 📱 Screens
class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Chatbot Screen")),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Profile Screen")),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Settings Screen")),
    );
  }
}

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Alert Screen")),
    );
  }
}

// ✂️ Header Shape
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
