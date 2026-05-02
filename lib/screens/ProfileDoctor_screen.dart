import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'header_clipper.dart'; // تأكد من استيراد الكليبر الخاص بك

class ProfileDoctorScreen extends StatelessWidget {
  const ProfileDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final isArabic = langProvider.isArabic;

    // دالة مساعدة للترجمة
    String t(String en, String ar) => isArabic ? ar : en;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            /// 🔵 Header Section (Profile Doctor)
            Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    height: 220,
                    width: double.infinity,
                    color: const Color(0xFF4C82B4),
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
                Column(
                  children: [
                    const SizedBox(height: 60),
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 50, color: Color(0xFF4C82B4)),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Jhon Williams", // يمكن جلب الاسم من الـ Backend لاحقاً
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // زر التعديل (Edit) كما في الصورة
                    GestureDetector(
                      onTap: () {
                        // أضف وظيفة التعديل هنا
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A3D63),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.edit, color: Colors.white, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              t("Edit", "تعديل"),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// 📄 Personal Information Section
            Text(
              t("Personal Information", "المعلومات الشخصية"),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif',
                color: Color(0xFF4C82B4),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                children: [
                  _buildInfoField(t("Specialization :", "التخصص :"), t("General", "عام")),
                  _buildInfoField(t("Phone Number :", "رقم الهاتف :"), "01010734368"),
                  _buildInfoField(t("Years of experience :", "سنوات الخبرة :"), t("10 years", "10 سنوات")),
                  _buildInfoField(t("Email :", "البريد الإلكتروني :"), "Jhon@gmail.com"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ويجت لبناء حقول المعلومات (مطابقة لتصميم الكروت في Figma)
  Widget _buildInfoField(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD), // لون خلفية الكارت الفاتح
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF4C82B4),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}