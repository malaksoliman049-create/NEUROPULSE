import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../screens/header_clipper.dart';

class HealthHistoryScreen extends StatelessWidget {
  const HealthHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final isArabic = langProvider.isArabic;

    Map<String, Map<String, String>> tMap = {
      'en': {
        'title': 'Health History',
        'timeline': 'Timeline',
        'alerts': 'Alerts History',
        'view': 'View ALL >',
      },
      'ar': {
        'title': 'تاريخ الحالة الصحية',
        'timeline': 'الجدول الزمني',
        'alerts': 'سجل التنبيهات',
        'view': 'عرض الكل >',
      }
    };

    String t(String key) => tMap[isArabic ? 'ar' : 'en']![key]!;

    List<Map<String, dynamic>> history = [
      {"time": "9:00 AM", "status": "Normal", "warn": false},
      {"time": "11:30 AM", "status": "High Heart Rate", "warn": true},
      {"time": "2:00 PM", "status": "Low SpO₂", "warn": true},
    ];

    List<Map<String, String>> alerts = [
      {"title": "High Heart Rate", "value": "110 bpm"},
      {"title": "Low SpO₂", "value": "88%"},
    ];

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFEFEFEF),
        body: SafeArea(
          child: Column(
            children: [
              /// 🔵 HEADER
              Stack(
                children: [
                  ClipPath(
                    clipper: HeaderClipper(),
                    child: Container(
                      height: 140,
                      color: const Color(0xFF4C82B4),
                      child: Center(
                        child: Text(
                          t('title'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// 📈 TIMELINE
              containerBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t('timeline'),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ...history.map((e) => timelineItem(
                          e["time"],
                          e["status"],
                          e["warn"],
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// 🔔 ALERTS
              containerBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          t('alerts'),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          t('view'),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...alerts.map((e) => alertItem(e["title"]!, e["value"]!)),
                  ],
                ),
              ),
              
              // تم استبدال الـ Spacer والـ Navigation Container بمسافة بسيطة
              const SizedBox(height: 20), 
            ],
          ),
        ),
      ),
    );
  }

  // ================= Widgets البناء =================

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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 8,
            color: warning ? Colors.red : Colors.green,
          ),
          const SizedBox(width: 10),
          Text(time, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget alertItem(String title, String sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.red, size: 20),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14)),
              Text(sub, style: const TextStyle(fontSize: 11, color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }
}