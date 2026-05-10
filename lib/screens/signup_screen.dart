import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import 'profile_info_screen.dart';
import 'doctor_info_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  String? selectedRole;

  Map<String, Map<String, String>> localized = {

    'en': {
      'title': 'Sign-Up',
      'step1': 'Are you a Patient or a Dr?',
      'role': 'Select Your Role',
      'doctor': 'Doctor',
      'patient': 'Patient',
      'name': 'Name',
      'email': 'Email',
      'password': 'Password',
      'confirm': 'Confirm Password',
      'next': 'Next',
    },

    'ar': {
      'title': 'إنشاء حساب',
      'step1': 'هل أنت مريض أم طبيب؟',
      'role': 'اختر النوع',
      'doctor': 'طبيب',
      'patient': 'مريض',
      'name': 'الاسم',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirm': 'تأكيد كلمة المرور',
      'next': 'التالي',
    }
  };

  String t(String key, bool isArabic) {
    return localized[
        isArabic ? 'ar' : 'en']![key]!;
  }

  @override
  Widget build(BuildContext context) {

    final langProvider =
        Provider.of<LanguageProvider>(context);

    final isArabic =
        langProvider.isArabic;

    final primaryColor =
        const Color(0xFF4C82B4);

    return Directionality(

      textDirection:
          isArabic
              ? TextDirection.rtl
              : TextDirection.ltr,

      child: Scaffold(

        body: Stack(
          children: [

            /// 🔵 الخلفية
            Container(
              color: Colors.white,
            ),

            /// 📄 المحتوى
            Positioned(

              top: 120,
              left: 0,
              right: 0,
              bottom: 0,

              child: Container(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                decoration:
                    const BoxDecoration(

                  color: Color(0xFFF5F5F5),

                  borderRadius:
                      BorderRadius.only(
                    topLeft:
                        Radius.circular(40),
                    topRight:
                        Radius.circular(40),
                  ),
                ),

                child: SingleChildScrollView(

                  child: Column(
                    children: [

                      const SizedBox(height: 60),

                      /// 📝 Title
                      Text(
                        t('title', isArabic),

                        style: TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// 👤 Name
                      _buildTextField(
                        t('name', isArabic),
                      ),

                      /// 📧 Email
                      _buildTextField(
                        t('email', isArabic),
                      ),

                      /// 🔒 Password
                      _buildTextField(
                        t('password', isArabic),
                        isPassword: true,
                      ),

                      /// 🔒 Confirm Password
                      _buildTextField(
                        t('confirm', isArabic),
                        isConfirm: true,
                      ),

                      const SizedBox(height: 10),

                      /// 🩺 اختيار النوع
                      Text(
                        t('step1', isArabic),

                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 5),

                      _buildRoleDropdown(
                        isArabic,
                        primaryColor,
                      ),

                      const SizedBox(height: 25),

                      /// 🔥 زر Next
                      SizedBox(

                        width: double.infinity,

                        child: ElevatedButton(

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

                            padding:
                                const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),

                          onPressed: () {

                            if (selectedRole ==
                                "doctor") {

                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          const DoctorInfoScreen(),
                                ),
                              );

                            } else if (selectedRole ==
                                "patient") {

                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          const ProfileInfoScreen(),
                                ),
                              );

                            } else {

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(

                                SnackBar(
                                  content: Text(

                                    isArabic
                                        ? "من فضلك اختر (طبيب أو مريض) أولاً"
                                        : "Please select your role first",
                                  ),
                                ),
                              );
                            }
                          },

                          child: Text(
                            t('next', isArabic),

                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔵 Header
            Container(

              height: 160,
              width: double.infinity,

              decoration: const BoxDecoration(

                color: Color(0xFF4C82B4),

                borderRadius:
                    BorderRadius.only(
                  bottomLeft:
                      Radius.circular(80),

                  bottomRight:
                      Radius.circular(80),
                ),
              ),

              child: const Center(
                child: Text(
                  "NeuroPulse",

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
      ),
    );
  }

  /// 🩺 Dropdown اختيار النوع
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
            BorderRadius.circular(12),
      ),

      child: DropdownButtonHideUnderline(

        child: DropdownButton<String>(

          value: selectedRole,

          isExpanded: true,

          hint: Text(

            t('role', isArabic),

            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          items: [

            DropdownMenuItem(
              value: "doctor",
              child: Text(
                t('doctor', isArabic),
              ),
            ),

            DropdownMenuItem(
              value: "patient",
              child: Text(
                t('patient', isArabic),
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

  /// 🛠 TextField
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
            isPassword || isConfirm,

        decoration: InputDecoration(

          hintText: hint,

          filled: true,

          fillColor: Colors.white,

          border: OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(12),

            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}