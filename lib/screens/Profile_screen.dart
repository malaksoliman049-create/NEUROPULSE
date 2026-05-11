import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final isArabic =
        Provider.of<LanguageProvider>(
          context,
        ).isArabic;

    String t(String en, String ar) =>
        isArabic ? ar : en;

    const Color primaryColor =
        Color(0xFF4C82B4);

    const Color iconColor =
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
              Colors.white,

          body: Column(
            children: [

              /// 🔵 HEADER
              Stack(
                children: [

                  Container(

                    height: 170,
                    width:
                        double.infinity,

                    decoration:
                        BoxDecoration(

                      color:
                          primaryColor,

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

                    child:
                        IconButton(

                      onPressed:
                          () =>
                              Navigator.pop(
                        context,
                      ),

                      icon:
                          const Icon(

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

                          fontSize:
                              22,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// 👤 IMAGE + INFO
              Padding(

                padding:
                    const EdgeInsets.only(

                  top: 35,
                  left: 18,
                  right: 18,
                ),

                child: Row(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .center,

                  children: [

                    CircleAvatar(

                      radius: 35,

                      backgroundColor:
                          Colors.blue
                              .shade100,

                      backgroundImage:
                          const AssetImage(

                        "assets/images/man.png",
                      ),
                    ),

                    const SizedBox(
                      width: 25,
                    ),

                    const Text(

                      "Ethan Williams",

                      style:
                          TextStyle(

                        fontSize:
                            18,

                        fontWeight:
                            FontWeight.bold,

                        color:
                            primaryColor,
                      ),
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

                  width:
                      double.infinity,

                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 22,
                  ),

                  child: ListView(

                    children: [

                      _buildInfoRow(

                        icon:
                            Icons.cake,

                        title: t(
                          "Age",
                          "العمر",
                        ),

                        value: "47",

                        iconColor:
                            iconColor,
                      ),

                      _buildInfoRow(

                        icon:
                            Icons.smoking_rooms,

                        title: t(
                          "Smoking",
                          "التدخين",
                        ),

                        value: t(
                          "No",
                          "لا",
                        ),

                        iconColor:
                            iconColor,
                      ),

                      _buildInfoRow(

                        icon:
                            Icons.height,

                        title: t(
                          "Height",
                          "الطول",
                        ),

                        value: t(
                          "165 cm",
                          "165 سم",
                        ),

                        iconColor:
                            iconColor,
                      ),

                      _buildInfoRow(

                        icon:
                            Icons.monitor_weight,

                        title: t(
                          "Weight",
                          "الوزن",
                        ),

                        value: t(
                          "65 KG",
                          "65 كجم",
                        ),

                        iconColor:
                            iconColor,
                      ),

                      _buildInfoRow(

                        icon:
                            Icons.favorite,

                        title: t(
                          "Heart disease",
                          "أمراض القلب",
                        ),

                        value: "60",

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

            color:
                iconColor,

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

            style: const TextStyle(

              color:
                  Colors.grey,

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