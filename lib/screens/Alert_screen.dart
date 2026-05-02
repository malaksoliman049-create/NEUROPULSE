import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../screens/header_clipper.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    final primaryColor = const Color(0xFF4C82B4);

    // النصوص المترجمة بناءً على حالة اللغة
    final String riskTitle = isArabic ? "خطر السكتة الدماغية: مرتفع" : "Stroke Risk: High";
    final String heartRate = isArabic ? "معدل ضربات القلب: 145 نبضة" : "HeartRate : 145 bpm";
    final String spo2 = isArabic ? "نسبة الأكسجين: 82%" : "Spo2 82%";
    final String notifyDoc = isArabic ? "إبلاغ الطبيب!" : "Notify Doctor!";
    final String callEmergency = isArabic ? "اتصال بالطوارئ!" : "Call Emergency!";

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            /// 🔵 Header Section (تم حذف كلمة Alert)
            Stack(
              children: [
                ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    height: 160, // تقليل الارتفاع قليلاً ليناسب التصميم بدون نص
                    width: double.infinity,
                    color: primaryColor,
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

            const SizedBox(height: 10),

            /// 🔴 Red Alert Card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD32F2F), 
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            riskTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Serif',
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            heartRate,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Serif',
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            spo2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Serif',
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const Spacer(),

                    /// 🔘 Action Buttons (نفس ألوان ومقاسات الصورة)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Notify Doctor Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF78909C), // الرمادي المائل للأزرق
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              notifyDoc,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Call Emergency Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD32F2F), // الأحمر
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              callEmergency,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}