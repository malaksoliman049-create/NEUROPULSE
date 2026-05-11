import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class ProfileInfoSignup extends StatefulWidget {
  const ProfileInfoSignup({super.key});

  @override
  State<ProfileInfoSignup> createState() =>
      _ProfileInfoSignupState();
}

class _ProfileInfoSignupState
    extends State<ProfileInfoSignup> {

  final TextEditingController
      searchController =
          TextEditingController();

  final List<Map<String, String>>
      doctors = [

    {
      'name': 'Dr Magdi Yacoub',
      'specialty': 'Cardiologist',
      'field': 'Heart Specialist',
      'image':
          'assets/images/doctor1.png',
    },

    {
      'name': 'Dr Sara Ali',
      'specialty': 'Neurologist',
      'field': 'Brain & Nerves',
      'image':
          'assets/images/doctor2.png',
    },

    {
      'name':
          'Dr Mohamed Refaat',

      'specialty':
          'Internal Physician',

      'field':
          'General Physician',

      'image':
          'assets/images/doctor3.png',
    },
  ];

  final Map<String, Map<String, String>>
      localized = {

    'en': {

      'title':
          'Choose Your Doctor',

      'search':
          'Search Doctor...',

      'signup': 'Sign Up',
    },

    'ar': {

      'title':
          'اختر طبيبك',

      'search':
          'ابحث عن دكتور...',

      'signup': 'تسجيل',
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
                        height: 25,
                      ),

                      /// 📝 TITLE
                      Text(

                        t(
                          'title',
                          isArabic,
                        ),

                        style:
                            const TextStyle(
                          color:
                              primaryColor,

                          fontSize:
                              28,

                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// 🔍 SEARCH
                      Container(

                        decoration:
                            BoxDecoration(

                          color: Colors
                              .grey
                              .shade200,

                          borderRadius:
                              BorderRadius
                                  .circular(
                            12,
                          ),
                        ),

                        child: TextField(

                          controller:
                              searchController,

                          decoration:
                              InputDecoration(

                            hintText: t(
                              'search',
                              isArabic,
                            ),

                            prefixIcon:
                                const Icon(
                              Icons.search,
                            ),

                            border:
                                InputBorder
                                    .none,

                            contentPadding:
                                const EdgeInsets
                                    .symmetric(
                              vertical: 15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// 👨‍⚕️ DOCTORS LIST
                      Expanded(

                        child:
                            ListView.builder(

                          itemCount:
                              doctors.length,

                          itemBuilder:
                              (
                                context,
                                index,
                              ) {

                            final doctor =
                                doctors[index];

                            return Container(

                              margin:
                                  const EdgeInsets
                                      .only(
                                bottom: 20,
                              ),

                              padding:
                                  const EdgeInsets
                                      .all(
                                12,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors
                                        .grey
                                        .shade200,

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  16,
                                ),
                              ),

                              child: Row(
                                children: [

                                  /// 🖼 DOCTOR IMAGE
                                  CircleAvatar(

                                    radius: 30,

                                    backgroundColor:
                                        Colors
                                            .white,

                                    backgroundImage:
                                        AssetImage(
                                      doctor[
                                          'image']!,
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 15,
                                  ),

                                  /// 📄 DOCTOR INFO
                                  Expanded(

                                    child:
                                        Column(

                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [

                                        Text(

                                          doctor[
                                              'name']!,

                                          style:
                                              const TextStyle(
                                            fontWeight:
                                                FontWeight
                                                    .bold,

                                            fontSize:
                                                16,
                                          ),
                                        ),

                                        const SizedBox(
                                          height:
                                              5,
                                        ),

                                        Text(

                                          doctor[
                                              'specialty']!,

                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.grey,
                                          ),
                                        ),

                                        const SizedBox(
                                          height:
                                              3,
                                        ),

                                        Text(

                                          doctor[
                                              'field']!,

                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      /// 🔥 SIGN UP BUTTON
                      SizedBox(

                        width:
                            double.infinity,

                        height: 55,

                        child:
                            ElevatedButton(

                          onPressed: () {

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

                            elevation: 4,
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
                        height: 20,
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