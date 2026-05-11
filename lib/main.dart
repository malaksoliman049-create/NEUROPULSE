import 'package:flutter/material.dart';
import 'package:neuropulse/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/language_provider.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/Profile_info_screen.dart';
import 'screens/profile_info_signup.dart';
import 'screens/doctors_appointments.dart';
import 'screens/home_screen.dart';
import 'screens/health_history.dart';
import 'screens/Doctor_dashboard_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: const RootApp(),
    );
  }
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: langProvider.locale,

      builder: (context, child) {
        return Directionality(
          textDirection: langProvider.isArabic
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child!,
        );
      },
      home: const   HomeScreen(),

      // 📍 Routes (بدون chatbot)
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignupScreen(),
        '/profile_info': (_) => const ProfileInfoScreen(),
        '/profile_info_signup': (_) => const ProfileInfoSignup(),
        '/doctors_appointments': (_) => const DoctorsAppointments(),
        '/home': (_) => const HomeScreen(),
        '/health_history': (_) => const HealthHistoryScreen(),
        '/doctor_dashboard': (_) => const DoctorDashboardScreen(),
      },
    );
  }
}
