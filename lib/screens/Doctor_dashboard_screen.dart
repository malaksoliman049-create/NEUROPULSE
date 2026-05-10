import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../screens/header_clipper.dart';

import 'patient_list_screen.dart';
import 'alerts_screen.dart';
import 'ProfileDoctor_screen.dart';
import 'chat_w_patient_screen.dart';

// ================= DOCTOR DASHBOARD =================

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({super.key});

  @override
  State<DoctorDashboardScreen> createState() =>
      _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState
    extends State<DoctorDashboardScreen> {

  int currentIndex = 0;

  void _navigateToPage(Widget page, int index) {

    setState(() {
      currentIndex = index;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    ).then((_) {

      setState(() {
        currentIndex = 0;
      });

    });
  }

  @override
  Widget build(BuildContext context) {

    final isArabic =
        Provider.of<LanguageProvider>(context).isArabic;

    return Directionality(

      textDirection:
          isArabic ? TextDirection.rtl : TextDirection.ltr,

      child: Scaffold(

        backgroundColor: Colors.white,

        body: DoctorHomeContent(
          isArabic: isArabic,
        ),

        bottomNavigationBar: BottomNavigationBar(

          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,

          backgroundColor: Colors.white,

          selectedItemColor:
              const Color(0xFF4C82B4),

          unselectedItemColor: Colors.grey,

          selectedFontSize: 10,
          unselectedFontSize: 10,

          iconSize: 20,

          onTap: (index) {

            if (index == 0) {

              setState(() => currentIndex = 0);

            } else if (index == 1) {

              _navigateToPage(
                const PatientListScreen(),
                1,
              );

            } else if (index == 2) {

              _navigateToPage(
                const AlertsScreen(),
                2,
              );

            } else if (index == 3) {

              _navigateToPage(
                const ChatWPatientScreen(),
                3,
              );

            } else if (index == 4) {

              _navigateToPage(
                const ProfileDoctorScreen(),
                4,
              );
            }
          },

          items: [

            _buildItem(
              "assets/images/home.svg",
              isArabic ? "الرئيسية" : "Home",
              0,
            ),

            _buildItem(
              "assets/images/patient.svg",
              isArabic ? "المرضى" : "Patients",
              1,
            ),

            _buildItem(
              "assets/images/alert.svg",
              isArabic ? "تنبيه" : "Alert",
              2,
            ),

            _buildItem(
              "assets/images/chat.svg",
              isArabic ? "المحادثات" : "Chats",
              3,
            ),

            _buildItem(
              "assets/images/profile.svg",
              isArabic ? "الحساب" : "Profile",
              4,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildItem(
    String icon,
    String label,
    int index,
  ) {

    return BottomNavigationBarItem(

      icon: SvgPicture.asset(

        icon,

        width: 24,

        colorFilter: ColorFilter.mode(

          currentIndex == index
              ? const Color(0xFF4C82B4)
              : Colors.grey,

          BlendMode.srcIn,
        ),
      ),

      label: label,
    );
  }
}

// ================= HOME CONTENT =================

class DoctorHomeContent extends StatelessWidget {

  final bool isArabic;

  const DoctorHomeContent({
    super.key,
    required this.isArabic,
  });

  String t(String en, String ar) =>
      isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child: SingleChildScrollView(

        child: Column(

          children: [

            // ================= HEADER =================

            ClipPath(

              clipper: HeaderClipper(),

              child: Container(

                height: 170,
                width: double.infinity,

                color: const Color(0xFF4C82B4),

                child: Padding(

                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.center,

                    children: [

                      // ================= NOTIFICATION =================

                      Align(

                        alignment: Alignment.topRight,

                        child: Stack(

                          children: [

                            const Icon(
                              Icons.notifications,
                              color: Colors.amber,
                              size: 28,
                            ),

                            Positioned(

                              right: 0,
                              top: 0,

                              child: Container(

                                padding:
                                    const EdgeInsets.all(3),

                                decoration:
                                    const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),

                                child: const Text(

                                  "1",

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      Center(

                        child: Text(

                          t(
                            "Dashboard",
                            "لوحة التحكم",
                          ),

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ================= BODY =================

            Padding(

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 18,
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.center,

                children: [

                  const SizedBox(height: 15),

                  // ================= WELCOME =================

                  Center(

                    child: Text(

                      t(
                        "Welcome, Dr. Magdi Yacaub",
                        "مرحباً دكتور",
                      ),

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5A6B7B),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ================= STATISTICS =================

                  Row(

                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      _buildSmallCard(
                        title: t(
                          "Total Patients",
                          "إجمالي المرضى",
                        ),

                        value: "120",

                        color:
                            const Color(0xFF4C82B4),
                      ),

                      _buildSmallCard(
                        title:
                            t("High Risk", "حالات حرجة"),

                        value: "20",

                        color: Colors.orange,
                      ),

                      _buildSmallCard(
                        title: t(
                          "Active Alerts",
                          "تنبيهات",
                        ),

                        value: "10",

                        color: Colors.red,
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // ================= ALERTS =================

                  Align(

                    alignment: Alignment.centerLeft,

                    child: Text(

                      t(
                        "Recent Alerts",
                        "التنبيهات الأخيرة",
                      ),

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  _buildAlertTile(
                    initials: "MA",
                    name: "Mohamed Ali",
                    alert:
                        "High Heart Rate Detected",
                    time: "12:30 AM",
                    color:
                        const Color(0xFFFFD6D6),
                  ),

                  const Divider(),

                  _buildAlertTile(
                    initials: "SA",
                    name: "Sara Mohamed",
                    alert:
                        "Irregular Rhythm Detected",
                    time: "09:15 AM",
                    color:
                        const Color(0xFFFFEDB5),
                  ),

                  const Divider(),

                  _buildAlertTile(
                    initials: "HA",
                    name: "Hesham Ahmed",
                    alert: "High Blood Pressure",
                    time: "Yesterday",
                    color:
                        const Color(0xFFFFEDB5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= SMALL CARD =================

  Widget _buildSmallCard({

    required String title,
    required String value,
    required Color color,

  }) {

    return Container(

      width: 95,

      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),

      decoration: BoxDecoration(

        color: color,

        borderRadius:
            BorderRadius.circular(12),
      ),

      child: Column(

        children: [

          Text(

            title,

            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 6),

          Text(

            value,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ================= ALERT TILE =================

  Widget _buildAlertTile({

    required String initials,
    required String name,
    required String alert,
    required String time,
    required Color color,

  }) {

    return Container(

      margin:
          const EdgeInsets.only(bottom: 18),

      child: Row(

        children: [

          CircleAvatar(

            radius: 22,
            backgroundColor: color,

            child: Text(

              initials,

              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  name,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 3),

                Text(

                  alert,

                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Text(

            time,

            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}