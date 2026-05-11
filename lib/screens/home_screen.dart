import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import 'health_history.dart';
import 'chatbot_screen.dart';
import 'alert_screen.dart';
import 'Profile_screen.dart';
import 'Settings_screen.dart';

/// ================= MODEL =================

class HealthData {

  final int heartRate;
  final int spo2;
  final String lastAlert;
  final String insight;
  final bool isConnected;

  HealthData({

    required this.heartRate,
    required this.spo2,
    required this.lastAlert,
    required this.insight,
    required this.isConnected,
  });
}

/// ================= HOME SCREEN =================

class HomeScreen extends StatefulWidget {

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  int currentIndex = 0;

  /// 🔄 NAVIGATION
  void _navigateToPage(
    Widget page,
    int index,
  ) {

    setState(() {
      currentIndex = index;
    });

    Navigator.push(

      context,

      MaterialPageRoute(
        builder: (_) => page,
      ),

    ).then((_) {

      setState(() {
        currentIndex = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final isArabic =
        Provider.of<LanguageProvider>(
          context,
        ).isArabic;

    const primaryColor =
        Color(0xFF4C82B4);

    return AnnotatedRegion<
        SystemUiOverlayStyle>(

      value:
          const SystemUiOverlayStyle(

        statusBarColor:
            Colors.transparent,

        statusBarIconBrightness:
            Brightness.light,
      ),

      child: Directionality(

        textDirection:
            isArabic
                ? TextDirection.rtl
                : TextDirection.ltr,

        child: Scaffold(

          backgroundColor:
              const Color(
            0xFFF2F2F2,
          ),

          body: HomeContent(
            isArabic: isArabic,
          ),

          bottomNavigationBar:
              BottomNavigationBar(

            currentIndex:
                currentIndex,

            type:
                BottomNavigationBarType
                    .fixed,

            backgroundColor:
                Colors.white,

            selectedItemColor:
                primaryColor,

            unselectedItemColor:
                Colors.grey,

            selectedLabelStyle:
                const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),

            onTap: (index) {

              if (index == 0) {

                setState(() {
                  currentIndex = 0;
                });

              } else if (index == 1) {

                _navigateToPage(
                  const ChatbotScreen(),
                  1,
                );

              } else if (index == 2) {

                _navigateToPage(
                  const AlertScreen(),
                  2,
                );

              } else if (index == 3) {

                _navigateToPage(
                  const ProfileScreen(),
                  3,
                );

              } else if (index == 4) {

                _navigateToPage(
                  const SettingsScreen(),
                  4,
                );
              }
            },

            items: [

              BottomNavigationBarItem(

                icon: SvgPicture.asset(

                  "assets/images/home.svg",

                  width: 24,

                  colorFilter:
                      ColorFilter.mode(

                    currentIndex == 0
                        ? primaryColor
                        : Colors.grey,

                    BlendMode.srcIn,
                  ),
                ),

                label:
                    isArabic
                        ? "الرئيسية"
                        : "Home",
              ),

              BottomNavigationBarItem(

                icon: SvgPicture.asset(

                  "assets/images/bot.svg",

                  width: 24,

                  colorFilter:
                      ColorFilter.mode(

                    currentIndex == 1
                        ? primaryColor
                        : Colors.grey,

                    BlendMode.srcIn,
                  ),
                ),

                label:
                    isArabic
                        ? "المحادثة"
                        : "Chatbot",
              ),

              BottomNavigationBarItem(

                icon: SvgPicture.asset(

                  "assets/images/alert.svg",

                  width: 24,

                  colorFilter:
                      ColorFilter.mode(

                    currentIndex == 2
                        ? primaryColor
                        : Colors.grey,

                    BlendMode.srcIn,
                  ),
                ),

                label:
                    isArabic
                        ? "تنبيه"
                        : "Alert",
              ),

              BottomNavigationBarItem(

                icon: SvgPicture.asset(

                  "assets/images/profile.svg",

                  width: 24,

                  colorFilter:
                      ColorFilter.mode(

                    currentIndex == 3
                        ? primaryColor
                        : Colors.grey,

                    BlendMode.srcIn,
                  ),
                ),

                label:
                    isArabic
                        ? "البروفايل"
                        : "Profile",
              ),

              BottomNavigationBarItem(

                icon: SvgPicture.asset(

                  "assets/images/setting.svg",

                  width: 24,

                  colorFilter:
                      ColorFilter.mode(

                    currentIndex == 4
                        ? primaryColor
                        : Colors.grey,

                    BlendMode.srcIn,
                  ),
                ),

                label:
                    isArabic
                        ? "الإعدادات"
                        : "Settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ================= HOME CONTENT =================

class HomeContent
    extends StatefulWidget {

  final bool isArabic;

  const HomeContent({

    super.key,

    required this.isArabic,
  });

  @override
  State<HomeContent> createState() =>
      _HomeContentState();
}

class _HomeContentState
    extends State<HomeContent> {

  HealthData data = HealthData(

    heartRate: 78,

    spo2: 97,

    lastAlert: "High",

    insight: "Unstable",

    isConnected: true,
  );

  final Map<String,
      Map<String, String>> tMap = {

    'en': {

      'heart':
          'Heart Rate',

      'spo2':
          'SpO₂',

      'alert':
          'Last Alert',

      'insight':
          'Insight',

      'history':
          'Health History',
    },

    'ar': {

      'heart':
          'نبض القلب',

      'spo2':
          'الأكسجين',

      'alert':
          'آخر تنبيه',

      'insight':
          'التقييم',

      'history':
          'السجل الصحي',
    }
  };

  String t(String key) {

    return tMap[
        widget.isArabic
            ? 'ar'
            : 'en']![key]!;
  }

  @override
  Widget build(BuildContext context) {

    const 
        Color(0xFF4C82B4);

    return SafeArea(

      child: SingleChildScrollView(

        child: Column(
          children: [

            /// 🔵 HEADER
            Stack(
              children: [

                Container(

                  height: 170,
                  width: double.infinity,

                  decoration:
                      BoxDecoration(
color:
                            const Color(
                          0xFF4C82B4,
                        ),
                    borderRadius:
                        BorderRadius
                            .vertical(

                      bottom:
                          Radius
                              .elliptical(

                        MediaQuery.of(
                                context)
                            .size
                            .width,

                        60,
                      ),
                    ),
                  ),
                ),

                const Positioned(

                  top: 80,
                  left: 0,
                  right: 0,

                  child: Center(

                    child: Text(

                      "NeuroPulse",

                      style:
                          TextStyle(

                        color:
                            Colors.white,

                        fontSize:
                            24,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 25,
            ),

            /// ❤️ HEART
            buildCard(

              "assets/images/heart.png",

              t('heart'),

              "${data.heartRate} bpm",
            ),

            /// 🫁 SPO2
            buildCard(

              "assets/images/spo2.png",

              t('spo2'),

              "${data.spo2}%",
            ),

            /// 🚨 ALERT
            buildCard(

              "assets/images/last.svg",

              t('alert'),

              data.lastAlert,
            ),

            /// 📊 INSIGHT
            buildCard(

              "assets/images/insight.png",

              t('insight'),

              data.insight,
            ),

            const SizedBox(
              height: 25,
            ),

            /// 📁 HISTORY BUTTON
            buildGrayButton(

              t('history'),

              () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:
                        (context) =>
                            const HealthHistoryScreen(),
                  ),
                );
              },
            ),

            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  /// 🔵 CARD
  Widget buildCard(

    String iconPath,
    String title,
    String value,

  ) {

    final isSvg =
        iconPath.endsWith(".svg");

    return Container(

      margin:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),

      padding:
          const EdgeInsets.all(16),

      decoration:
          BoxDecoration(

        color:
            const Color(
          0xFF4C82B4,
        ),

        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),

      child: Row(
        children: [

          isSvg

              ? SvgPicture.asset(
                  iconPath,
                  width: 30,
                )

              : Image.asset(
                  iconPath,
                  width: 30,
                ),

          const SizedBox(
            width: 12,
          ),

          Text(

            title,

            style:
                const TextStyle(
              color:
                  Colors.white,

              fontSize: 16,
            ),
          ),

          const Spacer(),

          Text(

            value,

            style:
                const TextStyle(
              color:
                  Colors.white,

              fontSize: 16,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// ⚪ BUTTON
  Widget buildGrayButton(

    String text,
    VoidCallback onTap,

  ) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        margin:
            const EdgeInsets.symmetric(
          horizontal: 16,
        ),

        padding:
            const EdgeInsets.all(16),

        width: double.infinity,

        decoration:
            BoxDecoration(

          color:
              Colors.grey[300],

          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),

        child: Center(

          child: Text(

            text,

            style:
                const TextStyle(

              fontWeight:
                  FontWeight.bold,

              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}