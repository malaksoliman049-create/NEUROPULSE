import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // --- متغيرات الحالة ---
  bool isConnected = true;
  String lastSyncValue = "2"; // القيمة الرقمية فقط
  bool isArabic = false; // المتغير المسؤول عن تغيير اللغة

  // قاموس النصوص (Translation Map)
  Map<String, Map<String, String>> localizedValues = {
    'en': {
      'settings': 'Settings',
      'connected': 'Device Connected',
      'disconnected': 'Device Disconnected',
      'lastSync': 'Last Sync : ',
      'minutesAgo': ' min ago',
      'disconnect': 'Disconnect',
      'connect': 'Connect',
      'sync': 'Sync Now',
      'language': 'Language',
      'logout': 'Log-Out',
      'home': 'Home',
      'chatbot': 'Chatbot',
      'profile': 'Profile',
      'setting': 'Setting',
      'alert': 'Alert',
    },
    'ar': {
      'settings': 'الإعدادات',
      'connected': 'الجهاز متصل',
      'disconnected': 'الجهاز غير متصل',
      'lastSync': 'آخر مزامنة : ',
      'minutesAgo': ' دقيقة مضت',
      'disconnect': 'قطع الاتصال',
      'connect': 'اتصال',
      'sync': 'مزامنة الآن',
      'language': 'اللغة',
      'logout': 'تسجيل الخروج',
      'home': 'الرئيسية',
      'chatbot': 'المساعد الذكي',
      'profile': 'الملف الشخصي',
      'setting': 'الإعدادات',
      'alert': 'تنبيه',
    }
  };

  String t(String key) {
    return localizedValues[isArabic ? 'ar' : 'en']![key]!;
  }

  void toggleLanguage() {
    setState(() {
      isArabic = !isArabic;
    });
  }

  @override
  Widget build(BuildContext context) {
    // تحديد اتجاه الصفحة بناءً على اللغة
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // الجزء العلوي الأزرق
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Color(0xFF3B67A1),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(MediaQuery.of(context).size.width, 100),
                    ),
                  ),
                ),
                Positioned(
                  top: 55,
                  child: Text(
                    t('settings'),
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // صورة الساعة
            Opacity(
              opacity: isConnected ? 1.0 : 0.5,
              child: Image.network(
                'https://support.apple.com/guide/watch/faces-and-features-apde9218b440/watchos/15.0/static/images/hero-watch-faces.png',
                height: 180,
              ),
            ),

            SizedBox(height: 20),

            // كارت الحالة
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFF0F7FF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    isConnected ? t('connected') : t('disconnected'),
                    style: TextStyle(
                      color: isConnected ? Colors.green : Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${t('lastSync')} $lastSyncValue ${t('minutesAgo')}",
                    style: TextStyle(color: Color(0xFF5A7B9A), fontSize: 16),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),

            // أزرار التحكم
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  label: isConnected ? t('disconnect') : t('connect'),
                  color: isConnected ? Colors.red[700]! : Colors.green[700]!,
                  onTap: () => setState(() => isConnected = !isConnected),
                ),
                _buildActionButton(
                  label: t('sync'),
                  color: Color(0xFF3B67A1),
                  onTap: () {},
                ),
              ],
            ),

            SizedBox(height: 30),

            // أزرار القائمة (اللغة وتسجيل الخروج)
            _buildMenuButton(t('language'), Color(0xFF3B67A1), onTap: toggleLanguage),
            SizedBox(height: 15),
            _buildMenuButton(t('logout'), Color(0xFF8BA3C0), onTap: () {}),
          ],
        ),

        // Bottom Navigation
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF3B67A1),
          unselectedItemColor: Colors.grey,
          currentIndex: 3,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: t('home')),
            BottomNavigationBarItem(icon: Icon(Icons.face_retouching_natural), label: t('chatbot')),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: t('profile')),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: t('setting')),
            BottomNavigationBarItem(icon: Icon(Icons.warning_amber_rounded), label: t('alert')),
          ],
        ),
      ),
    );
  }

  // ويجت الأزرار
  Widget _buildActionButton({required String label, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4))],
        ),
        child: Center(
          child: Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildMenuButton(String label, Color color, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(label, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}