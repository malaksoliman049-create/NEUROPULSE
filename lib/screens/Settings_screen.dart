import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'header_clipper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isConnected = true;
  String lastSyncValue = "2";

  Map<String, Map<String, String>> localizedValues = {
    'en': {
      'settings': 'Settings',
      'connected': 'Device Connected',
      'disconnected': 'Device Disconnected',
      'lastSync': 'Last Sync : ',
      'minutesAgo': ' min ago',
      'sync': 'Sync Now',
      'logout': 'Log-Out',
    },
    'ar': {
      'settings': 'الإعدادات',
      'connected': 'الجهاز متصل',
      'disconnected': 'الجهاز غير متصل',
      'lastSync': 'آخر مزامنة : ',
      'minutesAgo': ' دقيقة مضت',
      'sync': 'مزامنة الآن',
      'logout': 'تسجيل الخروج',
    }
  };

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final isArabic = langProvider.isArabic;
    final primaryColor = const Color(0xFF4C82B4);

    String t(String key) => localizedValues[isArabic ? 'ar' : 'en']![key]!;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea( // أضفنا SafeArea لضمان اتساق المسافات في أعلى الشاشة
          child: Column(
            children: [
              /// 🔵 Header Section
              Stack(
                children: [
                  ClipPath(
                    clipper: HeaderClipper(),
                    child: Container(
                      height: 140, // جعلنا الارتفاع 140 ليطابق الكود الآخر
                      width: double.infinity,
                      color: primaryColor,
                      child: Center(
                        child: Text(
                          t('settings'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20, // حجم الخط 20 ليطابق الكود الآخر
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  /// 🔙 Back Button (تم تعديله ليطابق الكود المطلوب تماماً)
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

              /// 📱 Main Content Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// 🟢 Status Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD).withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: primaryColor.withValues(alpha: 0.1)),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              isConnected ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
                              size: 60,
                              color: isConnected ? Colors.green[700] : Colors.red[400],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              isConnected ? t('connected') : t('disconnected'),
                              style: TextStyle(
                                color: isConnected ? Colors.green[700] : Colors.red,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${t('lastSync')} $lastSyncValue ${t('minutesAgo')}",
                              style: const TextStyle(color: Colors.blueGrey, fontSize: 16),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      /// 🔄 Sync Button
                      _buildMenuButton(
                        t('sync'), 
                        primaryColor, 
                        onTap: () {}
                      ),
                      
                      const SizedBox(height: 15),

                      /// 🔴 Logout Button
                      _buildMenuButton(
                        t('logout'), 
                        const Color(0xFFD32F2F), 
                        onTap: () {}
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 📦 Button Widget
  Widget _buildMenuButton(String label, Color color, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}