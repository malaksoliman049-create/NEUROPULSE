import 'package:flutter/material.dart';
import 'screens/Alert_screen.dart';
import 'screens/Doctor_dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/Settings_screen.dart'; 
import 'screens/Patient_list_screen.dart'; 
import 'screens/Patient_details_screen.dart'; 
import 'screens/Chat_w_patient_screen.dart'; 
import 'screens/Profile_info_screen.dart'; 

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

        '/': (context) => const ProfileInfoScreen(), 

        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => SettingsScreen(),
        '/alert': (context) => AlertScreen(isArabic: false),
        '/ChatwpatientScreen': (context) => const ChatWithPatient(isArabic: false),
        '/PatientDetailsScreen': (context) => const PatientDetails(isArabic: false),
        '/PatientslistScreen': (context) => const PatientsScreen(isArabic: false),
        '/doctordashboard': (context) => const DoctorDashboard(isArabic: false),
        // '/Profileinfo': (context) => const ProfileInfoScreen(),

      },
        );
      }
    }