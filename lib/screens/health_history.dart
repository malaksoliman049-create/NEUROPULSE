import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class HealthHistoryScreen
    extends StatelessWidget {

  const HealthHistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final isArabic =
        Provider.of<LanguageProvider>(
          context,
        ).isArabic;

    const primaryColor =
        Color(0xFF3B67A1);

    Map<String, Map<String, String>>
        tMap = {

      'en': {

        'title':
            'Health History',

        'timeline':
            'Timeline',

        'alerts':
            'Alerts History',

        'view':
            'View ALL >',
      },

      'ar': {

        'title':
            'تاريخ الحالة الصحية',

        'timeline':
            'الجدول الزمني',

        'alerts':
            'سجل التنبيهات',

        'view':
            'عرض الكل >',
      }
    };

    String t(String key) {

      return tMap[
          isArabic
              ? 'ar'
              : 'en']![key]!;
    }

    List<Map<String, dynamic>>
        history = [

      {
        "time": "9:00 AM",
        "status": "Normal",
        "warn": false,
      },

      {
        "time": "11:30 AM",
        "status":
            "High Heart Rate",

        "warn": true,
      },

      {
        "time": "2:00 PM",
        "status":
            "Low SpO₂",

        "warn": true,
      },
    ];

    List<Map<String, String>>
        alerts = [

      {
        "title":
            "High Heart Rate",

        "value":
            "110 bpm",
      },

      {
        "title":
            "Low SpO₂",

        "value":
            "88%",
      },
    ];

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

          body: SafeArea(

            child: Column(
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

                        icon: const Icon(

                          Icons
                              .arrow_back_ios_new,

                          color:
                              Colors.white,

                          size: 24,
                        ),

                        onPressed:
                            () =>
                                Navigator.pop(
                          context,
                        ),
                      ),
                    ),

                    /// 📝 TITLE
                    Positioned(

                      top: 95,

                      left: 0,
                      right: 0,

                      child: Center(

                        child: Text(

                          t('title'),

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

                const SizedBox(
                  height: 25,
                ),

                /// 📈 TIMELINE
                containerBox(

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Text(

                        t('timeline'),

                        style:
                            const TextStyle(

                          fontWeight:
                              FontWeight.bold,

                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      ...history.map(

                        (e) => timelineItem(

                          e["time"],

                          e["status"],

                          e["warn"],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),

                /// 🔔 ALERTS
                containerBox(

                  child: Column(
                    children: [

                      Row(
                        children: [

                          Text(

                            t('alerts'),

                            style:
                                const TextStyle(

                              fontWeight:
                                  FontWeight.bold,

                              fontSize: 16,
                            ),
                          ),

                          const Spacer(),

                          Text(

                            t('view'),

                            style:
                                const TextStyle(

                              color:
                                  Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      ...alerts.map(

                        (e) => alertItem(

                          e["title"]!,

                          e["value"]!,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 📦 BOX
  Widget containerBox({

    required Widget child,

  }) {

    return Padding(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      child: Container(

        width: double.infinity,

        padding:
            const EdgeInsets.all(
          15,
        ),

        decoration:
            BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
            16,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  Colors.black
                      .withValues(
                alpha: 0.05,
              ),

              blurRadius: 5,

              offset:
                  const Offset(
                0,
                2,
              ),
            ),
          ],
        ),

        child: child,
      ),
    );
  }

  /// 📈 TIMELINE ITEM
  Widget timelineItem(

    String time,
    String text,
    bool warning,

  ) {

    return Padding(

      padding:
          const EdgeInsets.symmetric(
        vertical: 6,
      ),

      child: Row(
        children: [

          Icon(

            Icons.circle,

            size: 10,

            color:
                warning
                    ? Colors.red
                    : Colors.green,
          ),

          const SizedBox(
            width: 10,
          ),

          Text(

            time,

            style:
                const TextStyle(
              fontSize: 13,
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          Expanded(

            child: Text(

              text,

              style:
                  const TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🚨 ALERT ITEM
  Widget alertItem(

    String title,
    String sub,

  ) {

    return Padding(

      padding:
          const EdgeInsets.symmetric(
        vertical: 6,
      ),

      child: Row(
        children: [

          const Icon(

            Icons.warning,

            color: Colors.red,

            size: 22,
          ),

          const SizedBox(
            width: 10,
          ),

          Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              Text(

                title,

                style:
                    const TextStyle(
                  fontSize: 14,
                ),
              ),

              Text(

                sub,

                style:
                    const TextStyle(

                  fontSize: 11,

                  color:
                      Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}