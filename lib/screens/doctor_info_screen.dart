import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({super.key});

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  final _experienceController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedSpecialization;

  // قائمة التخصصات
  final List<String> _specializations = [
    'Cardiology',
    'Neurology',
    'General',
  ];

  // نصوص الترجمة المحلية
  final Map<String, Map<String, String>> localized = {
    'en': {
      'title': 'Doctor Profile Info',
      'specialization': 'Specialization',
      'experience': 'Years of Experience',
      'phone': 'Phone Number',
      'signup': 'Sign Up',
      'error_spec': 'Please select your specialty',
    },
    'ar': {
      'title': 'بيانات الطبيب',
      'specialization': 'التخصص',
      'experience': 'سنوات الخبرة',
      'phone': 'رقم الهاتف',
      'signup': 'تسجيل الحساب',
      'error_spec': 'اختر تخصصك الطبي أولاً',
    }
  };

  String t(String key, bool isArabic) => localized[isArabic ? 'ar' : 'en']![key]!;

  @override
  void dispose() {
    _experienceController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final isArabic = langProvider.isArabic;
    final primaryColor = const Color(0xFF3B67A1);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            /// 🔵 Header (NeuroPulse) - مطابق لتصميم Figma
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(250, 50),
                ),
              ),
              child: const Center(
                child: Text(
                  "NeuroPulse",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Serif',
                  ),
                ),
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      t('title', isArabic),
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif',
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    /// 🟢 Progress Steps
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStepCircle(Icons.check, true, primaryColor),
                        Container(height: 2, width: 40, color: primaryColor),
                        _buildStepCircle(null, false, primaryColor, text: "2"),
                      ],
                    ),
                    const SizedBox(height: 40),

                    /// 🔽 Dropdown التخصص
                    _buildSpecializationDropdown(isArabic, primaryColor),
                    
                    const SizedBox(height: 20),
                    
                    /// ⌨️ حقل سنوات الخبرة
                    _buildTextField(
                      t('experience', isArabic),
                      _experienceController,
                      keyboardType: TextInputType.number,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    /// ⌨️ حقل رقم الهاتف
                    _buildTextField(
                      t('phone', isArabic),
                      _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    
                    const SizedBox(height: 50),
                    
                    /// 🔘 زر تسجيل الحساب
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_selectedSpecialization == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(t('error_spec', isArabic))),
                            );
                            return;
                          }
                          // يتم توجيهه لصفحة تسجيل الدخول أو الداشبورد
                          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        child: Text(
                          t('signup', isArabic),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🛠️ بناء قائمة التخصصات مع حل مشكلة الـ Web
  Widget _buildSpecializationDropdown(bool isArabic, Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t('specialization', isArabic),
          style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05), // التحديث الجديد 2026
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSpecialization,
              isExpanded: true,
              hint: Text(isArabic ? "اختر التخصص" : "Select"),
              icon: Icon(Icons.arrow_drop_down, color: primaryColor),
              // حل مشكلة Symbol(dartx.map) بالتأكد من أن القائمة ليست null
              items: _specializations.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedSpecialization = newValue;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  /// 🛠️ بناء حقول الإدخال
  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          ),
        ),
      ],
    );
  }

  /// 🛠️ بناء دوائر مراحل التسجيل
  Widget _buildStepCircle(IconData? icon, bool isActive, Color color, {String? text}) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? color : Colors.white,
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: icon != null
            ? Icon(icon, color: Colors.white, size: 18)
            : Text(text ?? "", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ),
    );
  }
}