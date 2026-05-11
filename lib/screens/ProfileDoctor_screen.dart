import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class ProfileDoctorScreen extends StatelessWidget {
  const ProfileDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final langProvider =
        Provider.of<LanguageProvider>(context);

    final isArabic = langProvider.isArabic;

    String t(String en, String ar) =>
        isArabic ? ar : en;

    const Color primaryColor =
        Color(0xFF4C82B4);

    // ✅ نفس لون الـ HEADER
    const Color iconColor =
        Color(0xFF4C82B4);

    return AnnotatedRegion<SystemUiOverlayStyle>(

      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Brightness.light,
      ),

      child: Directionality(

        textDirection:
            isArabic
                ? TextDirection.rtl
                : TextDirection.ltr,

        child: Scaffold(

          backgroundColor: Colors.white,

          body: Column(
            children: [

              /// 🔵 HEADER
              Stack(
                children: [

                  Container(

                    height: 170,
                    width: double.infinity,

                    decoration: BoxDecoration(

                      color:
                          const Color(
                        0xFF4C82B4,
                      ),

                      borderRadius:
                          BorderRadius.vertical(
                        bottom:
                            Radius.elliptical(
                          MediaQuery.of(context)
                              .size
                              .width,
                          60,
                        ),
                      ),
                    ),
                  ),

                  /// 🔙 BACK BUTTON
                  Positioned(

                    top: 80,

                    left:
                        isArabic
                            ? null
                            : 10,

                    right:
                        isArabic
                            ? 10
                            : null,

                    child: IconButton(

                      onPressed: () =>
                          Navigator.pop(
                        context,
                      ),

                      icon: const Icon(
                        Icons
                            .arrow_back_ios_new,
                        color:
                            Colors.white,
                        size: 22,
                      ),
                    ),
                  ),

                  /// 🩺 TITLE
                  Positioned(

                    top: 90,
                    left: 0,
                    right: 0,

                    child: Center(
                      child: Text(

                        t(
                          "Profile",
                          "الملف الشخصي",
                        ),

                        style:
                            const TextStyle(
                          color:
                              Colors.white,
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// 👨‍⚕️ IMAGE + INFO
              Padding(

                padding:
                    const EdgeInsets.only(
                  top: 35,
                  left: 18,
                  right: 18,
                ),

                child: Row(

                  crossAxisAlignment:
                      CrossAxisAlignment.center,

                  children: [

                    CircleAvatar(

                      radius: 35,

                      backgroundColor:
                          Colors.blue.shade100,

                      child: const Icon(
                        Icons.person,
                        size: 45,
                        color: primaryColor,
                      ),
                    ),

                    const SizedBox(
                      width: 25,
                    ),

                    Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        const Text(

                          "Dr. Mohamed Refaat",

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                primaryColor,
                          ),
                        ),

                        const SizedBox(
                          height: 6,
                        ),

                        Text(

                          t(
                            "Internal Physician",
                            "طبيب باطنة",
                          ),

                          style: TextStyle(
                            color:
                                Colors.grey
                                    .shade700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 35,
              ),

              /// 📄 INFO
              Expanded(

                child: Container(

                  width: double.infinity,

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 22,
                  ),

                  child: ListView(

                    children: [

                      _buildInfoRow(

                        icon: Icons.person,

                        title: t(
                          "Full Name",
                          "الاسم الكامل",
                        ),

                        value:
                            "Dr. Mohamed Refaat",

                        iconColor:
                            iconColor,
                      ),

                      _buildInfoRow(

                        icon:
                            Icons.medical_services,

                        title: t(
                          "Specialization",
                          "التخصص",
                        ),

                        value: t(
                          "General Physician",
                          "طبيب عام",
                        ),

                        iconColor:
                            iconColor,
                      ),

                      _buildInfoRow(

                        icon: Icons.email,

                        title: t(
                          "Email",
                          "البريد",
                        ),

                        value:
                            "Mohamed@gmail.com",

                        iconColor:
                            iconColor,
                      ),

                      _buildInfoRow(

                        icon: Icons.phone,

                        title: t(
                          "Phone Number",
                          "رقم الهاتف",
                        ),

                        value:
                            "+20 1010734368",

                        iconColor:
                            iconColor,
                      ),

                      _buildInfoRow(

                        icon:
                            Icons.work_history,

                        title: t(
                          "Years of experience",
                          "سنوات الخبرة",
                        ),

                        value: t(
                          "10 years",
                          "10 سنوات",
                        ),

                        iconColor:
                            iconColor,
                      ),

                      _buildInfoRow(

                        icon:
                            Icons.local_hospital,

                        title: t(
                          "Clinic / Hospital",
                          "العيادة / المستشفى",
                        ),

                        value:
                            "Al safa Medical Center",

                        iconColor:
                            iconColor,
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

  Widget _buildInfoRow({

    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,

  }) {

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 28,
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),

          const SizedBox(
            width: 12,
          ),

          Expanded(

            child: Text(

              title,

              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.bold,
                color:
                    Color(0xFF5A6B7B),
                fontSize: 15,
              ),
            ),
          ),

          Text(

            value,

            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight:
                  FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}