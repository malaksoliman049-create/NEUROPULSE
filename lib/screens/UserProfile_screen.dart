import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final bool isArabic; // متغير للتحكم في اللغة

  const UserProfileScreen({super.key, this.isArabic = false});

  @override
  Widget build(BuildContext context) {
    // نصوص الصفحة بناءً على اللغة
    final String title = isArabic ? "الملف الشخصي" : "Profile";
    final String healthInfoTitle = isArabic ? "المعلومات الصحية" : "Health info";
    final String editBtn = isArabic ? "تعديل" : "Edit";
    
    return Scaffold(
      backgroundColor: Colors.white,
      // استخدمي Directionality لقلب اتجاه الشاشة بالكامل للعربي
      body: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Column(
          children: [
            // 🔵 Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              decoration: const BoxDecoration(
                color: Color(0xFF3B67A1),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // أيقونة الرجوع تتغير حسب اللغة
                        IconButton(
                          icon: Icon(isArabic ? Icons.arrow_back_ios_new : Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Text(
                          title,
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Serif'),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Ethan Williams",
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Serif'),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                    label: Text(editBtn, style: const TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C4E7A),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Text(
              healthInfoTitle,
              style: const TextStyle(color: Color(0xFF3B67A1), fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Serif'),
            ),
            const SizedBox(height: 10),

            // 📋 Health Cards
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildHealthCard(isArabic ? "العمر : 47" : "Age : 47", Icons.calendar_month, Colors.orangeAccent),
                  _buildHealthCard(isArabic ? "التدخين : لا" : "Smoking : No", Icons.smoke_free, Colors.redAccent),
                  _buildHealthCard(isArabic ? "الطول : 165 سم" : "Height : 165 cm", Icons.height, Colors.blueAccent),
                  _buildHealthCard(isArabic ? "الوزن : 65 كجم" : "Weight : 65KG", Icons.monitor_weight, Colors.deepOrange),
                ],
              ),
            ),

            // 🏠 Bottom Navigation Bar
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthCard(String text, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 40),
        title: Text(
          text,
          style: const TextStyle(color: Color(0xFF3B67A1), fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Serif'),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_outlined, isArabic ? "الرئيسية" : "Home"),
          _navItem(Icons.smart_toy_outlined, isArabic ? "البوت" : "Chatbot"),
          _navItem(Icons.person, isArabic ? "بروفايل" : "Profile", isActive: true),
          _navItem(Icons.settings_outlined, isArabic ? "الإعدادات" : "Setting"),
          _navItem(Icons.warning_amber_rounded, isArabic ? "تنبيه" : "Alert"),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF3B67A1) : Colors.grey, size: 28),
        Text(label, style: TextStyle(color: isActive ? const Color(0xFF3B67A1) : Colors.grey, fontSize: 11)),
      ],
    );
  }
}