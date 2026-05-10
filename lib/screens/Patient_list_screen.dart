import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import 'patient_details_screen.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() =>
      _PatientListScreenState();
}

class _PatientListScreenState
    extends State<PatientListScreen> {

  final List<Map<String, String>> patientsData = [

    {
      "name": "Ali Ahmed",
      "age": "57 y",
      "risk": "High Risk",
      "image": "assets/images/patient1.png",
    },

    {
      "name": "Mohamed Ahmed",
      "age": "60 y",
      "risk": "Medium Risk",
      "image": "assets/images/patient2.png",
    },

    {
      "name": "Sara Ahmed",
      "age": "40 y",
      "risk": "High Risk",
      "image": "assets/images/patient3.png",
    },

    {
      "name": "Naira Ahmed",
      "age": "55y",
      "risk": "Low Risk",
      "image": "assets/images/patient4.png",
    },
  ];

  @override
  Widget build(BuildContext context) {

    final isArabic =
        Provider.of<LanguageProvider>(context)
            .isArabic;

    String t(String en, String ar) =>
        isArabic ? ar : en;

    final primaryColor =
        const Color(0xFF4C82B4);

    return Directionality(

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

                  height: 160,

                  decoration:
                      const BoxDecoration(

                    color: Color(0xFF4C82B4),

                    borderRadius:
                        BorderRadius.vertical(
                      bottom:
                          Radius.elliptical(
                        250,
                        50,
                      ),
                    ),
                  ),
                ),

                Positioned(

                  top: 50,

                  left:
                      isArabic ? null : 10,

                  right:
                      isArabic ? 10 : null,

                  child: IconButton(

                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),

                const Positioned(

                  top: 65,
                  left: 0,
                  right: 0,

                  child: Center(
                    child: Text(
                      "Patients",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// 🔍 Search
            Padding(

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 18,
              ),

              child: TextField(

                decoration: InputDecoration(

                  hintText: t(
                    "Search patient...",
                    "ابحث عن مريض...",
                  ),

                  prefixIcon:
                      const Icon(Icons.search),

                  filled: true,

                  fillColor:
                      Colors.grey.shade100,

                  border: OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                      15,
                    ),

                    borderSide:
                        BorderSide.none,
                  ),
                ),
              ),
            ),

            /// 👨‍⚕️ Patients List
            Expanded(

              child: ListView.builder(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                ),

                itemCount:
                    patientsData.length,

                itemBuilder:
                    (context, index) {

                  final patient =
                      patientsData[index];

                  return InkWell(

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  const PatientDetails(),
                        ),
                      );
                    },

                    child: Container(

                      margin:
                          const EdgeInsets.only(
                        bottom: 18,
                      ),

                      padding:
                          const EdgeInsets.all(
                        12,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.grey.shade200,

                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),

                      child: Row(
                        children: [

                          /// 🖼 صورة المريض
                          CircleAvatar(

                            radius: 28,

                            backgroundColor:
                                Colors.white,

                            backgroundImage:
                                AssetImage(
                              patient['image']!,
                            ),
                          ),

                          const SizedBox(width: 15),

                          /// 📄 البيانات
                          Expanded(

                            child: Column(

                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                Text(
                                  patient['name']!,

                                  style:
                                      TextStyle(
                                    color:
                                        primaryColor,

                                    fontWeight:
                                        FontWeight
                                            .bold,

                                    fontSize: 18,
                                  ),
                                ),

                                const SizedBox(
                                  height: 6,
                                ),

                                Row(
                                  children: [

                                    Text(
                                      patient['age']!,

                                      style:
                                          const TextStyle(
                                        fontSize:
                                            16,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 20,
                                    ),

                                    Text(
                                      patient[
                                          'risk']!,

                                      style:
                                          TextStyle(
                                        fontSize:
                                            16,

                                        color:
                                            patient['risk'] ==
                                                    "High Risk"
                                                ? Colors.red
                                                : patient['risk'] ==
                                                        "Medium Risk"
                                                    ? primaryColor
                                                    : Colors.green,

                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}