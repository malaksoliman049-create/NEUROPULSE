import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'header_clipper.dart'; // تأكد من وجود ملف الكليبر لديك

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final isArabic = langProvider.isArabic;

    // دالة مساعدة للترجمة السريعة
    String t(String en, String ar) => isArabic ? ar : en;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            /// 🔵 Header Section
            Stack(
              children: [
                ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    color: const Color(0xFF4C82B4),
                    child: Center(
                      child: Text(
                        t("Alerts", "التنبيهات"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: isArabic ? null : 15,
                  right: isArabic ? 15 : null,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  ),
                ),
              ],
            ),

            /// 📢 Alerts List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  /// 🛑 High Risk Section (Highlighted as per Figma)
                  _buildHighRiskHighlight(
                    t("HIGH RISK ALERT", "تنبيه خطر مرتفع"),
                    t("Patient: Mohamed Ahmed", "المريض: محمد أحمد"),
                    t("Predicted risk: HIGH", "الخطر المتوقع: عالي"),
                    t("Time: May 24, 2024 - 10:30 AM", "الوقت: 24 مايو 2024 - 10:30 ص"),
                  ),

                  const SizedBox(height: 20),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t("All Alerts", "كل التنبيهات"),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4C82B4)),
                      ),
                      Text(
                        t("Newest v", "الأحدث v"),
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  
                  const Divider(),

                  /// List of regular alerts
                  _buildAlertItem(
                    title: t("High Risk", "خطر مرتفع"),
                    patient: t("Patient: Mohamed Ahmed", "المريض: محمد أحمد"),
                    prediction: t("Predicted risk: HIGH", "الخطر المتوقع: عالي"),
                    time: "10:30 AM\nMay 24, 2024",
                    color: Colors.red,
                    icon: Icons.report_problem,
                  ),
                  _buildAlertItem(
                    title: t("Medium Risk", "خطر متوسط"),
                    patient: t("Patient: Sara Mahmoud", "المريض: سارة محمود"),
                    prediction: t("Predicted risk: MEDIUM", "الخطر المتوقع: متوسط"),
                    time: "09:15 AM\nMay 24, 2024",
                    color: Colors.orange,
                    icon: Icons.warning_amber_rounded,
                  ),
                  _buildAlertItem(
                    title: t("Low Risk", "خطر منخفض"),
                    patient: t("Patient: Ahmed Ali", "المريض: أحمد علي"),
                    prediction: t("Predicted risk: LOW", "الخطر المتوقع: منخفض"),
                    time: "08:45 AM\nMay 24, 2024",
                    color: Colors.green,
                    icon: Icons.check_circle_outline,
                  ),
                  _buildAlertItem(
                    title: t("General Notification", "إشعار عام"),
                    patient: t("Patient: Emily Davis", "المريض: إيميلي ديفيز"),
                    prediction: t("New report is available", "تقرير جديد متاح"),
                    time: t("Yesterday\n06:30 PM", "أمس\n06:30 م"),
                    color: Colors.blue,
                    icon: Icons.notifications_none,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ويجت التنبيه الأهم (المظلل بالأعلى)
  Widget _buildHighRiskHighlight(String title, String patient, String risk, String time) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        border: const Border(left: BorderSide(color: Colors.red, width: 5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning, color: Colors.red, size: 40),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 5),
                Text(patient, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(risk, style: const TextStyle(color: Colors.red, fontSize: 13)),
                const SizedBox(height: 5),
                Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ويجت عناصر القائمة العادية
  Widget _buildAlertItem({
    required String title,
    required String patient,
    required String prediction,
    required String time,
    required Color color,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
                Text(patient, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                Text(prediction, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Text(
            time,
            textAlign: TextAlign.end,
            style: TextStyle(color: Colors.grey[500], fontSize: 11),
          ),
        ],
      ),
    );
  }
}