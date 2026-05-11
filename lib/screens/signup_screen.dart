import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import 'profile_info_screen.dart';
import 'doctor_info_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  String? selectedRole;

  Map<String, Map<String, String>>
      localized = {

    'en': {

      'title': 'Sign-Up',
      'step1':
          'Are you a Patient or a Dr?',
      'role': 'Select Your Role',
      'doctor': 'Doctor',
      'patient': 'Patient',
      'name': 'Name',
      'email': 'Email',
      'password': 'Password',
      'confirm':
          'Confirm Password',
      'next': 'Next',
    },

    'ar': {

      'title': 'إنشاء حساب',
      'step1':
          'هل أنت مريض أم طبيب؟',
      'role': 'اختر النوع',
      'doctor': 'طبيب',
      'patient': 'مريض',
      'name': 'الاسم',
      'email':
          'البريد الإلكتروني',
      'password':
          'كلمة المرور',
      'confirm':
          'تأكيد كلمة المرور',
      'next':
          'التالي',
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

          body: SingleChildScrollView(

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

                const SizedBox(
                  height: 35,
                ),

                /// 📝 TITLE
                Text(

                  t(
                    'title',
                    isArabic,
                  ),

                  style:
                      const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        primaryColor,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                Padding(

                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 20,
                  ),

                  child: Column(
                    children: [

                      /// 👤 NAME
                      _buildTextField(
                        t(
                          'name',
                          isArabic,
                        ),
                      ),

                      /// 📧 EMAIL
                      _buildTextField(
                        t(
                          'email',
                          isArabic,
                        ),
                      ),

                      /// 🔒 PASSWORD
                      _buildTextField(

                        t(
                          'password',
                          isArabic,
                        ),

                        isPassword:
                            true,
                      ),

                      /// 🔒 CONFIRM
                      _buildTextField(

                        t(
                          'confirm',
                          isArabic,
                        ),

                        isConfirm:
                            true,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      /// 🩺 ROLE TEXT
                      Text(

                        t(
                          'step1',
                          isArabic,
                        ),

                        style:
                            const TextStyle(
                          fontSize: 13,
                          color:
                              Colors.grey,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      /// 🩺 DROPDOWN
                      _buildRoleDropdown(
                        isArabic,
                        primaryColor,
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      /// 🔥 NEXT BUTTON
                      SizedBox(

                        width:
                            double.infinity,

                        child:
                            ElevatedButton(

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

                            padding:
                                const EdgeInsets
                                    .symmetric(
                              vertical:
                                  14,
                            ),
                          ),

                          onPressed:
                              () {

                            if (selectedRole ==
                                "doctor") {

                              Navigator
                                  .push(

                                context,

                                MaterialPageRoute(
                                  builder:
                                      (
                                        context,
                                      ) =>
                                          const DoctorInfoScreen(),
                                ),
                              );

                            } else if (selectedRole ==
                                "patient") {

                              Navigator
                                  .push(

                                context,

                                MaterialPageRoute(
                                  builder:
                                      (
                                        context,
                                      ) =>
                                          const ProfileInfoScreen(),
                                ),
                              );

                            } else {

                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(

                                SnackBar(

                                  content:
                                      Text(

                                    isArabic
                                        ? "من فضلك اختر (طبيب أو مريض) أولاً"
                                        : "Please select your role first",
                                  ),
                                ),
                              );
                            }
                          },

                          child: Text(

                            t(
                              'next',
                              isArabic,
                            ),

                            style:
                                const TextStyle(
                              color:
                                  Colors
                                      .white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🩺 DROPDOWN
  Widget _buildRoleDropdown(

    bool isArabic,
    Color primaryColor,

  ) {

    return Container(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          12,
        ),
      ),

      child:
          DropdownButtonHideUnderline(

        child: DropdownButton<String>(

          value: selectedRole,

          isExpanded: true,

          hint: Text(

            t(
              'role',
              isArabic,
            ),

            style:
                const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          items: [

            DropdownMenuItem(

              value: "doctor",

              child: Text(
                t(
                  'doctor',
                  isArabic,
                ),
              ),
            ),

            DropdownMenuItem(

              value: "patient",

              child: Text(
                t(
                  'patient',
                  isArabic,
                ),
              ),
            ),
          ],

          onChanged: (val) {

            setState(() {
              selectedRole = val;
            });
          },
        ),
      ),
    );
  }

  /// 🛠 TEXT FIELD
  Widget _buildTextField(

    String hint, {

    bool isPassword = false,
    bool isConfirm = false,

  }) {

    return Padding(

      padding:
          const EdgeInsets.symmetric(
        vertical: 10,
      ),

      child: TextField(

        obscureText:
            isPassword ||
                isConfirm,

        decoration:
            InputDecoration(

          hintText: hint,

          filled: true,

          fillColor:
              Colors.white,

          border:
              OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(
              12,
            ),

            borderSide:
                BorderSide.none,
          ),
        ),
      ),
    );
  }
}