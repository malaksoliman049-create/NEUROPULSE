import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() =>
      _ProfileInfoScreenState();
}

class _ProfileInfoScreenState
    extends State<ProfileInfoScreen> {

  String? selectedGender;
  String? selectedSmoker;
  String? selectedHeartDisease;

  final Map<String, Map<String, String>>
      localized = {

    'en': {

      'title': 'Profile Info',
      'age': 'Age',
      'gender': 'Gender',
      'height': 'Height (cm)',
      'weight': 'Weight (kg)',
      'smoker': 'Smoker?',
      'heart': 'Heart disease',
      'signup': 'NEXT',
      'yes': 'Yes',
      'no': 'No',
      'male': 'Male',
      'female': 'Female',
      'select': 'Select',
    },

    'ar': {

      'title':
          'معلومات الملف الشخصي',

      'age': 'العمر',

      'gender': 'النوع',

      'height': 'الطول (سم)',

      'weight': 'الوزن (كجم)',

      'smoker': 'مدخن؟',

      'heart': 'أمراض القلب',

      'signup': 'التالي',

      'yes': 'نعم',

      'no': 'لا',

      'male': 'ذكر',

      'female': 'أنثى',

      'select': 'اختر',
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
  Widget build(BuildContext context) {

    final isArabic =
        Provider.of<LanguageProvider>(
          context,
        ).isArabic;

    const primaryColor =
        Color(0xFF4B82B4);

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
                        height: 35,
                      ),

                      /// 👤 AGE + GENDER
                      Row(
                        children: [

                          Expanded(

                            child:
                                _buildTextField(

                              t(
                                'age',
                                isArabic,
                              ),

                              keyboardType:
                                  TextInputType
                                      .number,
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          Expanded(

                            child:
                                _buildDropdownField(

                              t(
                                'gender',
                                isArabic,
                              ),

                              [

                                t(
                                  'male',
                                  isArabic,
                                ),

                                t(
                                  'female',
                                  isArabic,
                                ),
                              ],

                              selectedGender,

                              (val) {

                                setState(() {
                                  selectedGender =
                                      val;
                                });
                              },

                              t(
                                'select',
                                isArabic,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// 📏 HEIGHT + WEIGHT
                      Row(
                        children: [

                          Expanded(

                            child:
                                _buildTextField(

                              t(
                                'height',
                                isArabic,
                              ),

                              keyboardType:
                                  TextInputType
                                      .number,
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          Expanded(

                            child:
                                _buildTextField(

                              t(
                                'weight',
                                isArabic,
                              ),

                              keyboardType:
                                  TextInputType
                                      .number,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      /// 🚬 SMOKER + ❤️ HEART
                      Row(
                        children: [

                          Expanded(

                            child:
                                _buildDropdownField(

                              t(
                                'smoker',
                                isArabic,
                              ),

                              [

                                t(
                                  'yes',
                                  isArabic,
                                ),

                                t(
                                  'no',
                                  isArabic,
                                ),
                              ],

                              selectedSmoker,

                              (val) {

                                setState(() {
                                  selectedSmoker =
                                      val;
                                });
                              },

                              t(
                                'select',
                                isArabic,
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          Expanded(

                            child:
                                _buildDropdownField(

                              t(
                                'heart',
                                isArabic,
                              ),

                              [

                                t(
                                  'yes',
                                  isArabic,
                                ),

                                t(
                                  'no',
                                  isArabic,
                                ),
                              ],

                              selectedHeartDisease,

                              (val) {

                                setState(() {
                                  selectedHeartDisease =
                                      val;
                                });
                              },

                              t(
                                'select',
                                isArabic,
                              ),
                            ),
                          ),
                        ],
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

                            Navigator
                                .pushNamed(
                              context,
                              '/profile_info_signup',
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
  Widget _buildDropdownField(

    String label,
    List<String> items,
    String? value,
    Function(String?) onChanged,
    String hint,

  ) {

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

          padding:
              const EdgeInsets
                  .symmetric(
            horizontal: 12,
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

              value: value,

              isExpanded: true,

              hint: Text(

                hint,

                style:
                    const TextStyle(
                  fontSize: 14,
                  color:
                      Colors.grey,
                ),
              ),

              items:
                  items.map(
                (String item) {

                  return DropdownMenuItem<
                      String>(

                    value: item,

                    child: Text(

                      item,

                      style:
                          const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  );
                },
              ).toList(),

              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  /// 🛠 TEXT FIELD
  Widget _buildTextField(

    String label, {

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

            keyboardType:
                keyboardType,

            decoration:
                const InputDecoration(

              border:
                  InputBorder.none,

              contentPadding:
                  EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}