import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../screens/header_clipper.dart';
import 'health_history.dart';
import 'chatbot_screen.dart';
import 'alert_screen.dart';
import 'Profile_screen.dart';
import 'Settings_screen.dart';

// ================= MODEL =================

class HealthData {
  final int heartRate;
  final int spo2;
  final String lastAlert;
  final String insight;
  final bool isConnected;

  HealthData({
    required this.heartRate,
    required this.spo2,
    required this.lastAlert,
    required this.insight,
    required this.isConnected,
  });
}

// ================= HOME SCREEN =================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  // وظيفة لمساعدة التنقل وإعادة التصفير عند العودة
  void _navigateToPage(Widget page, int index) {
    setState(() {
      currentIndex = index; // جعل الأيقونة تنور أزرق عند الضغط
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    ).then((_) {
      // ✨ هذا الكود يتنفذ فوراً عند الرجوع (Back) من الشاشة المفتوحة
      setState(() {
        currentIndex = 0; // إعادة اللون الأزرق لأيقونة الهوم
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: HomeContent(isArabic: isArabic),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF4C82B4),
          unselectedItemColor: Colors.grey,

          onTap: (index) {
            if (index == 0) {
              setState(() => currentIndex = 0);
            } else if (index == 1) {
              _navigateToPage(const ChatbotScreen(), 1);
            } else if (index == 2) {
              _navigateToPage(const AlertScreen(), 2);
            } else if (index == 3) {
              _navigateToPage(const ProfileScreen(), 3);
            } else if (index == 4) {
              _navigateToPage(const SettingsScreen(), 4);
            }
          },

          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/home.svg", 
                width: 24,
                colorFilter: ColorFilter.mode(
                  currentIndex == 0 ? const Color(0xFF4C82B4) : Colors.grey, 
                  BlendMode.srcIn
                ),
              ),
              label: isArabic ? "الرئيسية" : "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/bot.svg", 
                width: 24,
                colorFilter: ColorFilter.mode(
                  currentIndex == 1 ? const Color(0xFF4C82B4) : Colors.grey, 
                  BlendMode.srcIn
                ),
              ),
              label: isArabic ? "المحادثة" : "Chatbot",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/alert.svg", 
                width: 24,
                colorFilter: ColorFilter.mode(
                  currentIndex == 2 ? const Color(0xFF4C82B4) : Colors.grey, 
                  BlendMode.srcIn
                ),
              ),
              label: isArabic ? "تنبيه" : "Alert",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/profile.svg", 
                width: 24,
                colorFilter: ColorFilter.mode(
                  currentIndex == 3 ? const Color(0xFF4C82B4) : Colors.grey, 
                  BlendMode.srcIn
                ),
              ),
              label: isArabic ? "البروفايل" : "Profile",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/setting.svg", 
                width: 24,
                colorFilter: ColorFilter.mode(
                  currentIndex == 4 ? const Color(0xFF4C82B4) : Colors.grey, 
                  BlendMode.srcIn
                ),
              ),
              label: isArabic ? "الإعدادات" : "Setting",
            ),
          ],
        ),
      ),
    );
  }
}

// ================= HOME CONTENT =================

class HomeContent extends StatefulWidget {
  final bool isArabic;

  const HomeContent({super.key, required this.isArabic});

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
  );

  Map<String, Map<String, String>> tMap = {
    'en': {
      'heart': 'Heart Rate',
      'spo2': 'SpO₂',
      'alert': 'Last Alert',
      'insight': 'Insight',
      'history': 'Health History',
    },
    'ar': {
      'heart': 'نبض القلب',
      'spo2': 'الأكسجين',
      'alert': 'آخر تنبيه',
      'insight': 'التقييم',
      'history': 'تاريخ الصحة',
    }
  };

  String t(String key) => tMap[widget.isArabic ? 'ar' : 'en']![key]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: HeaderClipper(),
                child: Container(
                  height: 120,
                  width: double.infinity,
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

              buildCard("assets/images/heart.png", t('heart'), "${data.heartRate} bpm"),
              buildCard("assets/images/spo2.png", t('spo2'), "${data.spo2}%"),
              buildCard("assets/images/last.svg", t('alert'), data.lastAlert),
              buildCard("assets/images/insight.png", t('insight'), data.insight),

              const SizedBox(height: 20),

              buildGrayButton(
                t('history'),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HealthHistoryScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String iconPath, String title, String value) {
    final isSvg = iconPath.endsWith(".svg");

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF4C82B4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          isSvg
              ? SvgPicture.asset(iconPath, width: 30)
              : Image.asset(iconPath, width: 30),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(color: Colors.white)),
          const Spacer(),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget buildGrayButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}