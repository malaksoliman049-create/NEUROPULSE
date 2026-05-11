import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class AlertScreen
    extends StatelessWidget {

  const AlertScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {

    final isArabic =
        Provider.of<
            LanguageProvider>(
      context,
    ).isArabic;

    const primaryColor =
        Color(0xFF4C82B4);

    final String riskTitle =

        isArabic
            ? "خطر السكتة الدماغية: مرتفع"
            : "Stroke Risk: High";

    final String heartRate =

        isArabic
            ? "معدل ضربات القلب: 145 نبضة"
            : "Heart Rate : 145 bpm";

    final String spo2 =

        isArabic
            ? "نسبة الأكسجين: 82%"
            : "SpO₂ : 82%";

    final String notifyDoc =

        isArabic
            ? "إبلاغ الطبيب!"
            : "Notify Doctor!";

    final String callEmergency =

        isArabic
            ? "اتصال بالطوارئ!"
            : "Call Emergency!";

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

                        size: 24,
                      ),
                    ),
                  ),

                  /// 📝 TITLE
                  Positioned(

                    top: 90,

                    left: 0,
                    right: 0,

                    child: Center(

                      child: Text(

                        isArabic
                            ? "تنبيه"
                            : "Alert",

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

              Expanded(

                child: Padding(

                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 28,
                    vertical: 25,
                  ),

                  child: Column(
                    children: [

                      /// 🚨 ALERT CARD
                      Container(

                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets
                                .symmetric(

                          horizontal: 20,
                          vertical: 55,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              const Color(
                            0xFFD32F2F,
                          ),

                          borderRadius:
                              BorderRadius
                                  .circular(
                            24,
                          ),

                          boxShadow: [

                            BoxShadow(

                              color:
                                  Colors.red
                                      .withValues(
                                alpha:
                                    0.18,
                              ),

                              blurRadius:
                                  12,

                              offset:
                                  const Offset(
                                0,
                                5,
                              ),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [

                            const Icon(

                              Icons.warning_amber_rounded,

                              color:
                                  Colors.white,

                              size: 70,
                            ),

                            const SizedBox(
                              height: 30,
                            ),

                            Text(

                              riskTitle,

                              textAlign:
                                  TextAlign
                                      .center,

                              style:
                                  const TextStyle(

                                color:
                                    Colors.white,

                                fontSize:
                                    23,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 35,
                            ),

                            Text(

                              heartRate,

                              textAlign:
                                  TextAlign
                                      .center,

                              style:
                                  const TextStyle(

                                color:
                                    Colors.white,

                                fontSize:
                                    18,

                                fontWeight:
                                    FontWeight.w500,
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            Text(

                              spo2,

                              textAlign:
                                  TextAlign
                                      .center,

                              style:
                                  const TextStyle(

                                color:
                                    Colors.white,

                                fontSize:
                                    18,

                                fontWeight:
                                    FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      /// 🔘 BUTTONS
                      Row(
                        children: [

                          Expanded(

                            child:
                                ElevatedButton(

                              onPressed:
                                  () {},

                              style:
                                  ElevatedButton
                                      .styleFrom(

                                backgroundColor:
                                    const Color(
                                  0xFF78909C,
                                ),

                                foregroundColor:
                                    Colors.white,

                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  vertical:
                                      15,
                                ),

                                shape:
                                    RoundedRectangleBorder(

                                  borderRadius:
                                      BorderRadius.circular(
                                    18,
                                  ),
                                ),

                                elevation:
                                    0,
                              ),

                              child: Text(

                                notifyDoc,

                                textAlign:
                                    TextAlign
                                        .center,

                                style:
                                    const TextStyle(

                                  fontSize:
                                      13,

                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          Expanded(

                            child:
                                ElevatedButton(

                              onPressed:
                                  () {},

                              style:
                                  ElevatedButton
                                      .styleFrom(

                                backgroundColor:
                                    const Color(
                                  0xFFD32F2F,
                                ),

                                foregroundColor:
                                    Colors.white,

                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  vertical:
                                      15,
                                ),

                                shape:
                                    RoundedRectangleBorder(

                                  borderRadius:
                                      BorderRadius.circular(
                                    18,
                                  ),
                                ),

                                elevation:
                                    0,
                              ),

                              child: Text(

                                callEmergency,

                                textAlign:
                                    TextAlign
                                        .center,

                                style:
                                    const TextStyle(

                                  fontSize:
                                      13,

                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 30,
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
}