import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../screens/header_clipper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Provider.of<LanguageProvider>(context).isArabic;
    final primaryColor = const Color(0xFF4C82B4);

    final String healthInfoTitle = isArabic ? "المعلومات الصحية" : "Health info";
    final String editBtn = isArabic ? "تعديل" : "Edit";

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea( // تم إضافة SafeArea لضمان اتساق مكان زر الرجوع
          child: Column(
            children: [
              /// 🔵 Header Section
              Stack(
                children: [
                  ClipPath(
                    clipper: HeaderClipper(),
                    child: Container(
                      height: 240,
                      width: double.infinity,
                      color: primaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: const AssetImage("assets/images/man.png"),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Ethan Williams",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 35,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.edit, size: 16),
                              label: Text(editBtn, style: const TextStyle(fontSize: 14)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B67A1),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// 🔙 Back Button (تم تعديله ليطابق الكود الموحد)
                  Positioned(
                    top: 20,
                    left: isArabic ? null : 10,
                    right: isArabic ? 10 : null,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// 🧠 Title
              Text(
                healthInfoTitle,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif',
                ),
              ),

              /// 📋 Health Info List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  children: [
                    _buildHealthCard(isArabic ? "العمر : 47" : "Age : 47", "assets/images/age.png"),
                    _buildHealthCard(isArabic ? "التدخين : لا" : "Smoking : No", "assets/images/smoking.svg"),
                    _buildHealthCard(isArabic ? "الطول : 165 سم" : "Height : 165 cm", "assets/images/height.png"),
                    _buildHealthCard(isArabic ? "الوزن : 65 كجم" : "Weight : 65 KG", "assets/images/weight.svg"),
                    _buildHealthCard(isArabic ? "أمراض القلب : 60" : "Heart disease : 60", "assets/images/Disease.png"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 📦 Health Card Widget
  Widget _buildHealthCard(String text, String iconPath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: iconPath.endsWith('.svg')
                ? SvgPicture.asset(iconPath)
                : Image.asset(iconPath, fit: BoxFit.contain),
          ),
          const SizedBox(width: 20),
          Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3B67A1),
            ),
          ),
        ],
      ),
    );
  }
}