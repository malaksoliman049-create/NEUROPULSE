import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController
      _emailController =
          TextEditingController();

  final TextEditingController
      _passwordController =
          TextEditingController();

  bool _isPasswordHidden = true;

  Map<String, Map<String, String>>
      localized = {

    'en': {

      'welcome':
          'Welcome Back',

      'email':
          'Email',

      'password':
          'Password',

      'login':
          'Login',

      'forgot':
          'Forgot Password?',

      'no_account':
          "Don't have an account? Sign up",

      'or':
          'OR',

      'invalid':
          'Invalid email or password',

      'empty':
          'Please fill in all fields',
    },

    'ar': {

      'welcome':
          'مرحبًا بعودتك',

      'email':
          'البريد الإلكتروني',

      'password':
          'كلمة المرور',

      'login':
          'تسجيل الدخول',

      'forgot':
          'هل نسيت كلمة المرور؟',

      'no_account':
          'ليس لديك حساب؟ إنشاء حساب',

      'or':
          'أو',

      'invalid':
          'البريد أو كلمة المرور غير صحيحة',

      'empty':
          'من فضلك املأ جميع الحقول',
    }
  };

  String t(
    BuildContext context,
    String key,
  ) {

    final isArabic =
        Provider.of<LanguageProvider>(
          context,
        ).isArabic;

    return localized[
        isArabic ? 'ar' : 'en']![key]!;
  }

  void _login(
    BuildContext context,
  ) {

    final email =
        _emailController.text.trim();

    final password =
        _passwordController.text.trim();

    if (email.isEmpty ||
        password.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            t(context, 'empty'),
          ),
        ),
      );

      return;
    }

    if (email ==
            'user@example.com' &&
        password == 'password') {

      Navigator.pushReplacementNamed(
        context,
        '/home',
      );

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            t(context, 'invalid'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final isArabic =
        Provider.of<LanguageProvider>(
          context,
        ).isArabic;

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
              const Color(
            0xFFF5F5F5,
          ),

          body: SingleChildScrollView(

            child: Column(
              children: [

                // 🔵 HEADER
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

                    // 🌍 LANGUAGE BUTTON
                    Positioned(

                      top: 70,

                      right:
                          isArabic
                              ? null
                              : 15,

                      left:
                          isArabic
                              ? 15
                              : null,

                      child:
                          TextButton(

                        onPressed: () {

                          Provider.of<
                                  LanguageProvider>(
                              context,
                              listen:
                                  false)
                              .setLanguage(
                            !isArabic,
                          );
                        },

                        child: Text(

                          isArabic
                              ? "EN"
                              : "AR",

                          style:
                              const TextStyle(
                            color:
                                Colors
                                    .white,

                            fontSize:
                                16,

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ),
                    ),

                    // 🧠 APP NAME
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

                Text(

                  t(
                    context,
                    'welcome',
                  ),

                  style:
                      const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Color(
                      0xFF4C82B4,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 35,
                ),

                Padding(

                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 20,
                  ),

                  child: Column(
                    children: [

                      // 📧 EMAIL
                      TextField(

                        controller:
                            _emailController,

                        decoration:
                            InputDecoration(

                          hintText: t(
                            context,
                            'email',
                          ),

                          filled: true,

                          fillColor:
                              Colors
                                  .white,

                          border:
                              OutlineInputBorder(

                            borderRadius:
                                BorderRadius
                                    .circular(
                              12,
                            ),

                            borderSide:
                                BorderSide
                                    .none,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // 🔒 PASSWORD
                      TextField(

                        controller:
                            _passwordController,

                        obscureText:
                            _isPasswordHidden,

                        decoration:
                            InputDecoration(

                          hintText: t(
                            context,
                            'password',
                          ),

                          filled: true,

                          fillColor:
                              Colors
                                  .white,

                          border:
                              OutlineInputBorder(

                            borderRadius:
                                BorderRadius
                                    .circular(
                              12,
                            ),

                            borderSide:
                                BorderSide
                                    .none,
                          ),

                          suffixIcon:
                              IconButton(

                            icon: Icon(

                              _isPasswordHidden
                                  ? Icons
                                      .visibility_off
                                  : Icons
                                      .visibility,
                            ),

                            onPressed: () {

                              setState(() {

                                _isPasswordHidden =
                                    !_isPasswordHidden;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // ❓ FORGOT PASSWORD
                      Align(

                        alignment:
                            Alignment
                                .centerRight,

                        child:
                            TextButton(

                          onPressed:
                              () {},

                          child: Text(
                            t(
                              context,
                              'forgot',
                            ),
                          ),
                        ),
                      ),

                      // 🔘 LOGIN BUTTON
                      ElevatedButton(

                        style:
                            ElevatedButton
                                .styleFrom(

                          backgroundColor:
                              const Color(
                            0xFF4C82B4,
                          ),

                          minimumSize:
                              const Size(
                            double.infinity,
                            50,
                          ),
                        ),

                        onPressed:
                            () => _login(
                          context,
                        ),

                        child: Text(
                          t(
                            context,
                            'login',
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // 📝 SIGN UP
                      TextButton(

                        onPressed: () {

                          Navigator
                              .pushNamed(
                            context,
                            '/signup',
                          );
                        },

                        child: Text(

                          t(
                            context,
                            'no_account',
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // ─── OR ───
                      Row(
                        children: [

                          const Expanded(
                            child: Divider(),
                          ),

                          Padding(

                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal:
                                  8,
                            ),

                            child: Text(
                              t(
                                context,
                                'or',
                              ),
                            ),
                          ),

                          const Expanded(
                            child: Divider(),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // 🌍 SOCIAL
                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [

                          SvgPicture.asset(
                            "assets/images/google.svg",
                            width: 35,
                          ),

                          const SizedBox(
                            width: 25,
                          ),

                          SvgPicture.asset(
                            "assets/images/facebook.svg",
                            width: 35,
                          ),
                        ],
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
}