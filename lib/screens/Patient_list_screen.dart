import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PatientsScreen extends StatefulWidget {
  final bool isArabic;

  const PatientsScreen({super.key, required this.isArabic});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  // --- 💾 قائمة المرضى (البيانات اللي هتتغير) ---
  final List<Map<String, String>> patientsData = [
    {"name": "Ali Ahmed", "risk": "High", "status": "Critical"},
    {"name": "Sara Hassan", "risk": "Medium", "status": "Under Observation"},
    {"name": "Ziad Khalil", "risk": "Low", "status": "Stable"},
  ];

  // قاموس الترجمة
  Map<String, Map<String, String>> localized = {
    'en': {
      'title': 'Patients',
      'search_hint': 'Search patient...',
      'name_col': 'Patient Name',
      'risk_col': 'Risk Level',
      'status_col': 'Status',
      'view_details': 'View Patients Details',
      'High': 'High',
      'Medium': 'Medium',
      'Low': 'Low',
      'Critical': 'Critical',
      'Under Observation': 'Under Observation',
      'Stable': 'Stable',
      'home': 'Home',
      'patients': 'Patients',
      'messages': 'Messages',
    },
    'ar': {
      'title': 'المرضى',
      'search_hint': 'ابحث عن مريض...',
      'name_col': 'اسم المريض',
      'risk_col': 'مستوى الخطر',
      'status_col': 'الحالة',
      'view_details': 'عرض تفاصيل المرضى',
      'High': 'مرتفع',
      'Medium': 'متوسط',
      'Low': 'منخفض',
      'Critical': 'حرج',
      'Under Observation': 'تحت الملاحظة',
      'Stable': 'مستقر',
      'home': 'الرئيسية',
      'patients': 'المرضى',
      'messages': 'الرسائل',
    }
  };

  String t(String key) => localized[widget.isArabic ? 'ar' : 'en']![key] ?? key;

  // تحديد لون النص بناءً على مستوى الخطر
  Color getRiskColor(String risk) {
    if (risk == "High") return Colors.red[900]!;
    if (risk == "Medium") return const Color(0xFF3B67A1);
    return Colors.green[700]!;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Directionality(
        textDirection: widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              // 🔵 Header المنحني
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B67A1),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(MediaQuery.of(context).size.width, 80),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: widget.isArabic ? null : 15,
                    right: widget.isArabic ? 15 : null,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    child: Text(
                      t('title'),
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Serif'),
                    ),
                  ),
                ],
              ),

              // 🔍 Search Bar
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: t('search_hint'),
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ),
              ),

              // 📋 Table Container
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        // Headers
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _tableHeader(t('name_col')),
                              _tableHeader(t('risk_col')),
                              _tableHeader(t('status_col')),
                            ],
                          ),
                        ),
                        const Divider(color: Colors.white, thickness: 1),
                        // List of Patients
                        Expanded(
                          child: ListView.separated(
                            itemCount: patientsData.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 20),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            itemBuilder: (context, index) {
                              var p = patientsData[index];
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _tableCell(p['name']!, const Color(0xFF3B67A1)),
                                  _tableCell(t(p['risk']!), getRiskColor(p['risk']!)),
                                  _tableCell(t(p['status']!), getRiskColor(p['risk']!)),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔘 View Details Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A859A),
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Text(t('view_details'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 20),

              // 🔻 Bottom Navigation
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: Colors.grey[50], border: const Border(top: BorderSide(color: Colors.black12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(Icons.home_outlined, t('home'), false),
                    _buildNavItem(Icons.person_add_alt, t('patients'), true),
                    _buildNavItem(Icons.chat_bubble_outline, t('messages'), false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableHeader(String text) {
    return Expanded(child: Text(text, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF3B67A1), fontWeight: FontWeight.bold, fontSize: 14)));
  }

  Widget _tableCell(String text, Color color) {
    return Expanded(child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)));
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF3B67A1) : Colors.grey, size: 28),
        Text(label, style: TextStyle(color: isActive ? const Color(0xFF3B67A1) : Colors.grey, fontSize: 12)),
      ],
    );
  }
}