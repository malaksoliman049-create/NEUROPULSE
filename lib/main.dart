import 'package:flutter/material.dart';
import 'screens/Alert_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/Settings_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NeuroPulse',

 
      initialRoute:'/',

      routes: {
        '/': (context) => SplashScreen(), // يمكنك تغيير isArabic إلى true لعرض الشاشة باللغة العربية
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) =>  SettingsScreen(),
        '/alert': (context) => AlertScreen(isArabic: false), 
      },
        );
      }
    }