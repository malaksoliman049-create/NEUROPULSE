import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class DoctorsAppointments
    extends StatefulWidget {

  const DoctorsAppointments({
    super.key,
  });

  @override
  State<DoctorsAppointments>
      createState() =>
          _DoctorsAppointmentsState();
}

class _DoctorsAppointmentsState
    extends State<
        DoctorsAppointments> {

  final List<Map<String, String>>
      schedule = [

    {
      'day': 'Saturday',
      'from': '09:00 AM',
      'to': '01:00 PM',
    },

    {
      'day': 'Sunday',
      'from': '09:00 AM',
      'to': '01:00 PM',
    },

    {
      'day': 'Monday',
      'from': '05:00 PM',
      'to': '09:00 PM',
    },

    {
      'day': 'Tuesday',
      'from': '05:00 PM',
      'to': '09:00 PM',
    },

    {
      'day': 'Wednesday',
      'from': '09:00 AM',
      'to': '01:00 PM',
    },
  ];

  final Map<String, Map<String, String>>
      localized = {

    'en': {

      'title':
          'Set your available times',

      'signup':
          'Sign Up',
    },

    'ar': {

      'title':
          'حدد مواعيدك المتاحة',

      'signup':
          'تسجيل',
    },
  };

  String t(
    String key,
    bool isArabic,
  ) {

    return localized[
        isArabic ? 'ar' : 'en']![key]!;
  }

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

                  /// 🧠 APP NAME
                  const Positioned(

                    top: 100,

                    left: 0,
                    right: 0,

                    child: Center(

                      child: Text(

                        "NeuroPulse",

                        style:
                            TextStyle(

                          color:
                              Colors
                                  .white,

                          fontSize:
                              24,

                          fontWeight:
                              FontWeight
                                  .bold,
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
                    horizontal: 20,
                  ),

                  child: Column(
                    children: [

                      const SizedBox(
                        height: 30,
                      ),

                      /// 📝 TITLE
                      Text(

                        t(
                          'title',
                          isArabic,
                        ),

                        textAlign:
                            TextAlign
                                .center,

                        style:
                            const TextStyle(

                          color:
                              primaryColor,

                          fontSize:
                              26,

                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),

                      /// 📅 SCHEDULE
                      Expanded(

                        child:
                            ListView.builder(

                          itemCount:
                              schedule
                                  .length,

                          itemBuilder:
                              (
                                context,
                                index,
                              ) {

                            final item =
                                schedule[
                                    index];

                            return Padding(

                              padding:
                                  const EdgeInsets
                                      .only(
                                bottom:
                                    18,
                              ),

                              child: Row(
                                children: [

                                  /// 📆 DAY
                                  SizedBox(

                                    width:
                                        90,

                                    child:
                                        Text(

                                      item[
                                          'day']!,

                                      style:
                                          const TextStyle(

                                        fontSize:
                                            18,

                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  /// ⏰ TIME
                                  Expanded(

                                    child:
                                        Container(

                                      padding:
                                          const EdgeInsets
                                              .symmetric(

                                        horizontal:
                                            12,

                                        vertical:
                                            14,
                                      ),

                                      decoration:
                                          BoxDecoration(

                                        color:
                                            Colors.white,

                                        borderRadius:
                                            BorderRadius.circular(
                                          10,
                                        ),

                                        boxShadow: [

                                          BoxShadow(

                                            color:
                                                Colors.black.withValues(
                                              alpha:
                                                  0.05,
                                            ),

                                            blurRadius:
                                                5,

                                            offset:
                                                const Offset(
                                              0,
                                              2,
                                            ),
                                          ),
                                        ],
                                      ),

                                      child:
                                          Row(

                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        children: [

                                          Text(
                                            item[
                                                'from']!,
                                          ),

                                          const SizedBox(
                                            width:
                                                8,
                                          ),

                                          const Text(
                                            "-",
                                          ),

                                          const SizedBox(
                                            width:
                                                8,
                                          ),

                                          Text(
                                            item[
                                                'to']!,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    width:
                                        10,
                                  ),

                                  /// ➕ ICON
                                  Icon(

                                    Icons.add,

                                    color:
                                        primaryColor,

                                    size:
                                        28,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// 🔥 SIGN UP BUTTON
                      SizedBox(

                        width:
                            double.infinity,

                        height: 55,

                        child:
                            ElevatedButton(

                          onPressed:
                              () {

                            Navigator
                                .pushNamedAndRemoveUntil(

                              context,

                              '/login',

                              (
                                route,
                              ) =>
                                  false,
                            );
                          },

                          style:
                              ElevatedButton
                                  .styleFrom(

                            backgroundColor:
                                primaryColor,

                            shape:
                                RoundedRectangleBorder(

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                            ),

                            elevation:
                                4,
                          ),

                          child: Text(

                            t(
                              'signup',
                              isArabic,
                            ),

                            style:
                                const TextStyle(

                              color:
                                  Colors
                                      .white,

                              fontSize:
                                  20,

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),
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