import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  // متغيرات لتخزين القيم المختارة من القوائم المنسدلة
  String? selectedGender;
  String? selectedSmoker;
  String? selectedHeartDisease;

  // قاموس الترجمة للغتين العربية والإنجليزية
  final Map<String, Map<String, String>> localized = {
    'en': {
      'title': 'Profile Info',
      'age': 'Age',
      'gender': 'Gender',
      'height': 'Height (cm)',
      'weight': 'Weight (kg)',
      'smoker': 'Smoker?',
      'heart': 'Heart disease',
      'signup': 'Sign Up',
      'yes': 'Yes',
      'no': 'No',
      'male': 'Male',
      'female': 'Female',
      'select': 'Select'
    },
    'ar': {
      'title': 'معلومات الملف الشخصي',
      'age': 'العمر',
      'gender': 'النوع',
      'height': 'الطول (سم)',
      'weight': 'الوزن (كجم)',
      'smoker': 'مدخن؟',
      'heart': 'أمراض القلب',
      'signup': 'تسجيل',
      'yes': 'نعم',
      'no': 'لا',
      'male': 'ذكر',
      'female': 'أنثى',
      'select': 'اختر'
    }
  };

  String t(String key, bool isArabic) => localized[isArabic ? 'ar' : 'en']![key]!;

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
            /// 🔵 الجزء العلوي (Header)
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
                    
                    /// 📝 عنوان الصفحة
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

                    /// 🏁 مؤشر الخطوات (Stepper)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStepCircle(Icons.check, true, primaryColor),
                        Container(height: 2, width: 40, color: primaryColor),
                        _buildStepCircle(null, false, primaryColor, text: "2"),
                      ],
                    ),
                    const SizedBox(height: 30),

                    /// 📥 الحقول: العمر والنوع (Dropdown)
                    Row(
                      children: [
                        Expanded(child: _buildTextField(t('age', isArabic), keyboardType: TextInputType.number)),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildDropdownField(
                            t('gender', isArabic),
                            [t('male', isArabic), t('female', isArabic)],
                            selectedGender,
                            (val) => setState(() => selectedGender = val),
                            t('select', isArabic),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// 📥 الحقول: الطول والوزن (بإضافة الوحدات)
                    Row(
                      children: [
                        Expanded(child: _buildTextField(t('height', isArabic), keyboardType: TextInputType.number)),
                        const SizedBox(width: 15),
                        Expanded(child: _buildTextField(t('weight', isArabic), keyboardType: TextInputType.number)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// 📥 الحقول: مدخن وأمراض القلب (Dropdown)
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownField(
                            t('smoker', isArabic),
                            [t('yes', isArabic), t('no', isArabic)],
                            selectedSmoker,
                            (val) => setState(() => selectedSmoker = val),
                            t('select', isArabic),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildDropdownField(
                            t('heart', isArabic),
                            [t('yes', isArabic), t('no', isArabic)],
                            selectedHeartDisease,
                            (val) => setState(() => selectedHeartDisease = val),
                            t('select', isArabic),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 50),

                    /// 🔥 زر التسجيل (Sign Up)
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
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
                            fontWeight: FontWeight.bold
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

  /// 🛠 ميثود بناء حقل الـ Dropdown (محدث بـ withValues)
  Widget _buildDropdownField(String label, List<String> items, String? value, Function(String?) onChanged, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05), 
                blurRadius: 5, 
                offset: const Offset(0, 2)
              )
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(hint, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: const TextStyle(fontSize: 15)),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  /// 🛠 ميثود بناء حقل النص (محدث بـ withValues)
  Widget _buildTextField(String label, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05), 
                blurRadius: 5, 
                offset: const Offset(0, 2)
              )
            ],
          ),
          child: TextField(
            keyboardType: keyboardType,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  /// 🛠 ميثود بناء دوائر الخطوات
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