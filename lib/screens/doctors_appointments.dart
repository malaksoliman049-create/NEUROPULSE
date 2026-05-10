import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class DoctorsAppointments extends StatefulWidget {
  const DoctorsAppointments({super.key});

  @override
  State<DoctorsAppointments> createState() =>
      _DoctorsAppointmentsState();
}

class _DoctorsAppointmentsState
    extends State<DoctorsAppointments> {

  final List<Map<String, String>> schedule = [

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

  final Map<String, Map<String, String>> localized = {

    'en': {
      'title': 'Set your available times',
      'signup': 'Sign Up',
    },

    'ar': {
      'title': 'حدد مواعيدك المتاحة',
      'signup': 'تسجيل',
    },
  };

  String t(String key, bool isArabic) =>
      localized[
          isArabic ? 'ar' : 'en']![key]!;

  @override
  Widget build(BuildContext context) {

    final langProvider =
        Provider.of<LanguageProvider>(context);

    final isArabic =
        langProvider.isArabic;

    final primaryColor =
        const Color(0xFF3B67A1);

    return Directionality(

      textDirection:
          isArabic
              ? TextDirection.rtl
              : TextDirection.ltr,

      child: Scaffold(

        backgroundColor: Colors.white,

        body: Column(
          children: [

            /// 🔵 Header
            Container(

              height: 160,
              width: double.infinity,

              decoration: BoxDecoration(
                color: primaryColor,

                borderRadius:
                    const BorderRadius.vertical(
                  bottom:
                      Radius.elliptical(250, 50),
                ),
              ),

              child: const Center(
                child: Text(
                  "NeuroPulse",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Serif',
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                child: Column(
                  children: [

                    const SizedBox(height: 30),

                    /// 📝 Title
                    Text(
                      t('title', isArabic),

                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 26,
                        fontWeight:
                            FontWeight.bold,
                        fontFamily: 'Serif',
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// 📅 المواعيد
                    Expanded(
                      child: ListView.builder(

                        itemCount:
                            schedule.length,

                        itemBuilder:
                            (context, index) {

                          final item =
                              schedule[index];

                          return Padding(

                            padding:
                                const EdgeInsets.only(
                              bottom: 18,
                            ),

                            child: Row(

                              children: [

                                /// 📆 اليوم
                                SizedBox(
                                  width: 90,

                                  child: Text(
                                    item['day']!,

                                    style:
                                        const TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),

                                /// ⏰ الوقت
                                Expanded(
                                  child: Container(

                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
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
                                          color: Colors.black
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

                                    child: Row(

                                      mainAxisAlignment:
                                          MainAxisAlignment.center,

                                      children: [

                                        Text(
                                          item['from']!,
                                        ),

                                        const SizedBox(
                                          width: 8,
                                        ),

                                        const Text("-"),

                                        const SizedBox(
                                          width: 8,
                                        ),

                                        Text(
                                          item['to']!,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                /// ➕ icon
                                Icon(
                                  Icons.add,
                                  color: primaryColor,
                                  size: 28,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔥 زر Sign Up
                    SizedBox(

                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(

                        onPressed: () {

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        },

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              primaryColor,

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                          ),

                          elevation: 4,
                        ),

                        child: Text(
                          t('signup', isArabic),

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}