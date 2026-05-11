import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({super.key});

  @override
  State<DoctorInfoScreen> createState() =>
      _DoctorInfoScreenState();
}

class _DoctorInfoScreenState
    extends State<DoctorInfoScreen> {

  final _experienceController =
      TextEditingController();

  final _phoneController =
      TextEditingController();

  final _clinicController =
      TextEditingController();

  String? _selectedSpecialization;

  /// 🩺 SPECIALIZATIONS
  final List<String> _specializations = [

    'Cardiology',

    'Neurology',

    'General',
  ];

  /// 🌍 TRANSLATIONS
  final Map<String, Map<String, String>>
      localized = {

    'en': {

      'title': 'Doctor Profile',

      'specialization':
          'Specialization',

      'experience':
          'Years of Experience',

      'phone':
          'Phone Number',

      'clinic':
          'Clinic / Hospital',

      'signup': 'NEXT',

      'error_spec':
          'Please select your specialty',
    },

    'ar': {

      'title':
          'بيانات الطبيب',

      'specialization':
          'التخصص',

      'experience':
          'سنوات الخبرة',

      'phone':
          'رقم الهاتف',

      'clinic':
          'العيادة / المستشفى',

      'signup': 'التالي',

      'error_spec':
          'اختر تخصصك الطبي أولاً',
    }
  };

  String t(
    String key,
    bool isArabic,
  ) {

    return localized[
        isArabic ? 'ar' : 'en']![key]!;
  }

  @override
  void dispose() {

    _experienceController.dispose();

    _phoneController.dispose();

    _clinicController.dispose();

    super.dispose();
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

                child:
                    SingleChildScrollView(

                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 25,
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

                      /// 🔽 SPECIALIZATION
                      _buildSpecializationDropdown(
                        isArabic,
                        primaryColor,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// ⌨️ EXPERIENCE
                      _buildTextField(

                        t(
                          'experience',
                          isArabic,
                        ),

                        _experienceController,

                        keyboardType:
                            TextInputType
                                .number,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// ⌨️ PHONE
                      _buildTextField(

                        t(
                          'phone',
                          isArabic,
                        ),

                        _phoneController,

                        keyboardType:
                            TextInputType
                                .phone,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// ⌨️ CLINIC
                      _buildTextField(

                        t(
                          'clinic',
                          isArabic,
                        ),

                        _clinicController,
                      ),

                      const SizedBox(
                        height: 50,
                      ),

                      /// 🔥 NEXT BUTTON
                      SizedBox(

                        width:
                            double.infinity,

                        height: 55,

                        child:
                            ElevatedButton(

                          onPressed: () {

                            if (_selectedSpecialization ==
                                null) {

                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(

                                SnackBar(

                                  content:
                                      Text(

                                    t(
                                      'error_spec',
                                      isArabic,
                                    ),
                                  ),
                                ),
                              );

                              return;
                            }

                            Navigator
                                .pushNamed(

                              context,

                              '/doctors_appointments',
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

  /// 🛠 DROPDOWN
  Widget _buildSpecializationDropdown(

    bool isArabic,
    Color primaryColor,

  ) {

    return Column(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(

          t(
            'specialization',
            isArabic,
          ),

          style:
              const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(
          height: 8,
        ),

        Container(

          padding:
              const EdgeInsets
                  .symmetric(
            horizontal: 15,
          ),

          decoration:
              BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(
              12,
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

          child:
              DropdownButtonHideUnderline(

            child:
                DropdownButton<String>(

              value:
                  _selectedSpecialization,

              isExpanded: true,

              hint: Text(

                isArabic
                    ? "اختر التخصص"
                    : "Select",
              ),

              icon: Icon(

                Icons.arrow_drop_down,

                color:
                    primaryColor,
              ),

              items:
                  _specializations.map<
                      DropdownMenuItem<String>>(
                (
                  String value,
                ) {

                  return DropdownMenuItem<
                      String>(

                    value: value,

                    child: Text(
                      value,
                    ),
                  );
                },
              ).toList(),

              onChanged:
                  (newValue) {

                setState(() {

                  _selectedSpecialization =
                      newValue;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  /// 🛠 TEXT FIELD
  Widget _buildTextField(

    String label,
    TextEditingController controller, {

    TextInputType keyboardType =
        TextInputType.text,

  }) {

    return Column(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(

          label,

          style:
              const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(
          height: 8,
        ),

        Container(

          decoration:
              BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(
              12,
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

          child: TextField(

            controller:
                controller,

            keyboardType:
                keyboardType,

            decoration:
                const InputDecoration(

              border:
                  InputBorder.none,

              contentPadding:
                  EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}