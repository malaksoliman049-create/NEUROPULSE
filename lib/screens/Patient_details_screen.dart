import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PatientDetails extends StatefulWidget {
  final bool isArabic;

  const PatientDetails({super.key, required this.isArabic});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  // --- 💾 بيانات المريض المتغيرة (Variable Data) ---
  String pName = "Ali Ahmed";
  int pAge = 57;
  String pId = "2598";
  String riskLevel = "High";
  String status = "Critical";
  int heartRate = 145;
  int spo2 = 82;
  
  // التاريخ الطبي والملاحظات
  List<String> medicalHistoryEn = [
    "Hypertension - Diagnosed 2025",
    "Diabetes - Diagnosed 2024",
    "Stroke - Diagnosed 2026"
  ];
  List<String> medicalHistoryAr = [
    "ارتفاع ضغط الدم - تم التشخيص 2025",
    "السكري - تم التشخيص 2024",
    "سكتة دماغية - تم التشخيص 2026"
  ];
  
  String noteEn = "Recommend ECG and repeat SPO2 measurement if elevated readings persist.";
  String noteAr = "يوصى بعمل رسم قلب وتكرار قياس نسبة الأكسجين إذا استمرت القراءات المرتفعة.";

  // قاموس الترجمة
  Map<String, Map<String, String>> localized = {
    'en': {
      'title': 'Patient Details',
      'name': 'Name : ',
      'age': 'Age : ',
      'id': 'Id : ',
      'risk': 'Risk Level : ',
      'status': 'Status : ',
      'hr': 'Heart Rate : ',
      'spo2': 'Spo2 : ',
      'history': 'Medical History : ',
      'note': 'Note : ',
      'update': 'Update Record',
      'add_test': 'Add Test Result',
      'notify': 'Notify',
      'high': 'High',
      'critical': 'Critical'
    },
    'ar': {
      'title': 'تفاصيل المريض',
      'name': 'الاسم : ',
      'age': 'العمر : ',
      'id': 'المعرف : ',
      'risk': 'مستوى الخطر : ',
      'status': 'الحالة : ',
      'hr': 'نبض القلب : ',
      'spo2': 'الأكسجين : ',
      'history': 'التاريخ الطبي : ',
      'note': 'ملاحظة : ',
      'update': 'تحديث السجل',
      'add_test': 'إضافة نتيجة فحص',
      'notify': 'إشعار',
      'high': 'مرتفع',
      'critical': 'حرج'
    }
  };

  String t(String key) => localized[widget.isArabic ? 'ar' : 'en']![key] ?? key;

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
              // 🔵 Header
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B67A1),
                      borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, 80)),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: widget.isArabic ? null : 15,
                    right: widget.isArabic ? 15 : null,
                    child: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Navigator.pop(context)),
                  ),
                  Positioned(top: 60, child: Text(t('title'), style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Serif'))),
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      // صورة المريض (Avatar)
                      const Icon(Icons.account_circle, size: 120, color: Color(0xFF3B67A1)),
                      
                      const SizedBox(height: 20),

                      // 📝 بيانات المريض (Grid-like Layout)
                      _infoRow(t('name'), pName, t('age'), pAge.toString()),
                      _infoRow(t('id'), pId, t('risk'), t(riskLevel), valueColor2: Colors.red[900]),
                      _infoRow(t('status'), t(status), t('hr'), "$heartRate BPM", valueColor1: Colors.red[900], valueColor2: Colors.red[900]),
                      _infoRow(t('spo2'), "$spo2%", "", ""),

                      const SizedBox(height: 20),

                      // 🏥 التاريخ الطبي
                      _sectionTitle(t('history')),
                      Column(
                        children: (widget.isArabic ? medicalHistoryAr : medicalHistoryEn)
                            .map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4, left: 10, right: 10),
                                  child: Row(children: [const Text("• ", style: TextStyle(color: Color(0xFF6A859A))), Expanded(child: Text(item, style: const TextStyle(color: Color(0xFF6A859A), fontSize: 13)))]),
                                ))
                            .toList(),
                      ),

                      const SizedBox(height: 20),

                      // 🗒 الملاحظة
                      _sectionTitle(t('note')),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(widget.isArabic ? noteAr : noteEn, style: const TextStyle(color: Color(0xFF6A859A), fontSize: 13)),
                      ),

                      const SizedBox(height: 30),

                      // 🔘 الأزرار
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _actionButton(t('update')),
                          _actionButton(t('add_test')),
                        ],
                      ),
                      const SizedBox(height: 15),
                      _actionButton(t('notify'), width: 180),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // 🔻 Bottom Nav
              _bottomNav(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label1, String value1, String label2, String value2, {Color? valueColor1, Color? valueColor2}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: RichText(text: TextSpan(style: const TextStyle(color: Color(0xFF3B67A1), fontSize: 15, fontWeight: FontWeight.bold), children: [TextSpan(text: label1), TextSpan(text: value1, style: TextStyle(color: valueColor1 ?? const Color(0xFF3B67A1)))]))),
          if (label2.isNotEmpty)
            Expanded(child: RichText(text: TextSpan(style: const TextStyle(color: Color(0xFF3B67A1), fontSize: 15, fontWeight: FontWeight.bold), children: [TextSpan(text: label2), TextSpan(text: value2, style: TextStyle(color: valueColor2 ?? const Color(0xFF3B67A1)))]))),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 8), child: Text(title, style: const TextStyle(color: Color(0xFF3B67A1), fontSize: 16, fontWeight: FontWeight.bold)));
  }

  Widget _actionButton(String label, {double? width}) {
    return Container(
      width: width ?? 150,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: const Color(0xFF6A859A), borderRadius: BorderRadius.circular(15), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 4))]),
      child: Center(child: Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))),
    );
  }

  Widget _bottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.grey[50], border: const Border(top: BorderSide(color: Colors.black12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navIcon(Icons.home_outlined, "Home"),
          _navIcon(Icons.person_add_alt, "Patients", active: true),
          _navIcon(Icons.chat_bubble_outline, "Messages"),
        ],
      ),
    );
  }

  Widget _navIcon(IconData icon, String label, {bool active = false}) {
    return Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: active ? const Color(0xFF3B67A1) : Colors.grey, size: 28), Text(label, style: TextStyle(color: active ? const Color(0xFF3B67A1) : Colors.grey, fontSize: 12))]);
  }
}