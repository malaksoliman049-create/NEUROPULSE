import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../screens/header_clipper.dart';

import 'patient_list_screen.dart';
import 'alerts_screen.dart';
import 'ProfileDoctor_screen.dart';
import 'chat_w_patient_screen.dart';

// ================= DOCTOR DASHBOARD =================

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({super.key});

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  int currentIndex = 0;

  void _navigateToPage(Widget page, int index) {
    setState(() {
      currentIndex = index;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    ).then((_) {
      setState(() {
        currentIndex = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: DoctorHomeContent(isArabic: isArabic),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF4C82B4),
          unselectedItemColor: Colors.grey,

          onTap: (index) {
            if (index == 0) {
              setState(() => currentIndex = 0);
            } else if (index == 1) {
              _navigateToPage(const PatientListScreen(), 1);
            } else if (index == 2) {
              _navigateToPage(const AlertsScreen(), 2);
            } else if (index == 3) {
              _navigateToPage(const ChatWPatientScreen(), 3);
            } else if (index == 4) {
              _navigateToPage(const ProfileDoctorScreen(), 4);
            }
          },

          items: [
            _buildItem("assets/images/home.svg", isArabic ? "الرئيسية" : "Home", 0),
            _buildItem("assets/images/patient.svg", isArabic ? "المرضى" : "Patients", 1),
            _buildItem("assets/images/alert.svg", isArabic ? "تنبيه" : "Alert", 2),
            _buildItem("assets/images/chat.svg", isArabic ? "المحادثات" : "Chats", 3),
            _buildItem("assets/images/profile.svg", isArabic ? "الحساب" : "Profile", 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildItem(String icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        width: 24,
        colorFilter: ColorFilter.mode(
          currentIndex == index
              ? const Color(0xFF4C82B4)
              : Colors.grey,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}

// ================= DOCTOR HOME CONTENT =================

class DoctorHomeContent extends StatelessWidget {
  final bool isArabic;

  const DoctorHomeContent({super.key, required this.isArabic});

  String t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 120,
                width: double.infinity,
                color: const Color(0xFF4C82B4),
                child: Center(
                  child: Text(
                    t("Doctor Dashboard", "لوحة الطبيب"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CARDS
            _buildCard(
              t("Total Patients", "إجمالي المرضى"),
              "120",
              "assets/images/total pa.png",
            ),

            _buildCard(
              t("High Risk Patients", "حالات حرجة"),
              "20",
              "assets/images/active.png",
            ),

            _buildCard(
              t("Active Alerts", "تنبيهات نشطة"),
              "5",
              "assets/images/risk.png",
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String value, String iconPath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF4C82B4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 28,
          ),

          const SizedBox(width: 12),

          Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
