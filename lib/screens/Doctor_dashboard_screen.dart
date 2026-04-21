import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoctorDashboard extends StatefulWidget {
  final bool isArabic;

  const DoctorDashboard({super.key, required this.isArabic});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  // --- 💾 المتغيرات (Variable Data) ---
  int totalPatients = 120;
  int highRiskCount = 20;
  int activeAlerts = 10;
  
  // قيم الرسم البياني (كمثال)
  double lowRiskPercent = 20.0;
  double mediumRiskPercent = 40.0;
  double highRiskPercent = 60.0;

  // قاموس الترجمة
  Map<String, Map<String, String>> localized = {
    'en': {
      'title': 'Doctor Dashboard',
      'total_p': 'Total Patients',
      'high_r': 'High Risk Patients',
      'active_a': 'Active Alerts',
      'overview': 'Patients Risk Overview',
      'view_btn': 'View Patients',
      'low': 'Low',
      'medium': 'Medium',
      'high': 'High',
      'home': 'Home',
      'patients': 'Patients',
      'messages': 'Messages',
    },
    'ar': {
      'title': 'لوحة تحكم الطبيب',
      'total_p': 'إجمالي المرضى',
      'high_r': 'مرضى عالي الخطورة',
      'active_a': 'التنبيهات النشطة',
      'overview': 'نظرة عامة على مخاطر المرضى',
      'view_btn': 'عرض المرضى',
      'low': 'منخفض',
      'medium': 'متوسط',
      'high': 'مرتفع',
      'home': 'الرئيسية',
      'patients': 'المرضى',
      'messages': 'الرسائل',
    }
  };

  String t(String key) => localized[widget.isArabic ? 'ar' : 'en']![key]!;

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
              // 🔵 Header
              Stack(
                alignment: Alignment.center,
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
                    top: 60,
                    child: Text(
                      t('title'),
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Serif'),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      // 💳 Total Patients Card (Blue)
                      _buildDashboardCard(t('total_p'), totalPatients.toString(), const Color(0xFF3B67A1), Icons.group_add),
                      
                      const SizedBox(height: 15),

                      // 💳 High Risk Card (Red)
                      _buildDashboardCard(t('high_r'), highRiskCount.toString(), const Color(0xFFB71C1C), Icons.warning_amber_rounded),

                      const SizedBox(height: 15),

                      // 💳 Active Alerts Card (Grey-Blue)
                      _buildDashboardCard(t('active_a'), activeAlerts.toString(), const Color(0xFF6A859A), Icons.notifications_active),

                      const SizedBox(height: 20),

                      // 📊 Patients Risk Overview (Chart Section)
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6A859A),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t('overview'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildBar(t('low'), lowRiskPercent, Colors.green),
                                _buildBar(t('medium'), mediumRiskPercent, const Color(0xFF3B67A1)),
                                _buildBar(t('high'), highRiskPercent, const Color(0xFFB71C1C)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 🔘 View Patients Button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6A859A),
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(t('view_btn'), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),

              // 🔻 Bottom Navigation
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: Colors.grey[50], border: const Border(top: BorderSide(color: Colors.black12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(Icons.home_outlined, t('home'), true),
                    _buildNavItem(Icons.person_add_alt, t('patients'), false),
                    _buildNavItem(Icons.chat_bubble_outline, t('messages'), false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ويجت الكروت
  Widget _buildDashboardCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 45),
          const SizedBox(width: 15),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ويجت أعمدة الرسم البياني
  Widget _buildBar(String label, double height, Color color) {
    return Column(
      children: [
        Container(
          height: height,
          width: 40,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // ويجت الـ Nav Item
  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF3B67A1) : Colors.grey, size: 28),
        Text(label, style: TextStyle(color: isActive ? const Color(0xFF3B67A1) : Colors.grey, fontSize: 12)),
      ],
    );
  }
}