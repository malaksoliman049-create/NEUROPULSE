import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  String pName = "Ali Ahmed";
  int pAge = 57;

  Map<String, Map<String, String>> localized = {
    'en': {
      'title': 'Patient Details',
    },
    'ar': {
      'title': 'تفاصيل المريض',
    }
  };

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Provider.of<LanguageProvider>(context).isArabic;

    String t(String key) =>
        localized[isArabic ? 'ar' : 'en']![key] ?? key;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Directionality(
        textDirection:
            isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),

          body: Column(
            children: [

              // HEADER
              Stack(
                children: [

                  Container(
                    height: 170,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4C82B4),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width,
                          60,
                        ),
                      ),
                    ),
                  ),

                  // BACK BUTTON
                  Positioned(
                    top: 80,
                    left: isArabic ? null : 10,
                    right: isArabic ? 10 : null,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // TITLE
                  Positioned(
                    top: 90,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        t('title'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [

                      const SizedBox(height: 20),

                      // PROFILE
                      Row(
                        children: [

                          CircleAvatar(
                            radius: 35,
                            backgroundColor:
                                Colors.grey.shade300,

                            // backgroundImage:
                            // const AssetImage(
                            //   "assets/images/patient.png",
                            // ),
                          ),

                          const SizedBox(width: 15),

                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              Text(
                                pName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3B67A1),
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "$pAge Years",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // DIAGNOSIS
                      _buildCard(
                        Icons.assignment_outlined,
                        "Diagnosis",
                        "Hypertension , Arrhythmia",
                      ),

                      const SizedBox(height: 15),

                      // VITALS
                      _buildCard(
                        Icons.favorite_border,
                        "Latest Vitals",
                        "• Heart Rate        145 Bpm\n"
                        "• Spo2                  82%\n"
                        "• Heart disease    Yes",
                      ),

                      const SizedBox(height: 15),

                      // ALERTS
                      _buildCard(
                        Icons.warning_amber_rounded,
                        "Recent Alerts",
                        "• High Heart Rate detected\n"
                        "• High Spo2",
                        iconColor: Colors.red,
                      ),

                      const SizedBox(height: 15),

                      // NOTES
                      _buildCard(
                        Icons.notes,
                        "Notes",
                        "Patient needs continuous monitoring and follow up",
                      ),

                      const SizedBox(height: 25),
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

  Widget _buildCard(
    IconData icon,
    String title,
    String content, {
    Color iconColor = const Color(0xFF3B67A1),
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Icon(
            icon,
            color: iconColor,
            size: 32,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  content,
                  style: const TextStyle(
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}