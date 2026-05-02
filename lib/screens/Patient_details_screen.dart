import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  String pName = "Ali Ahmed";
  int pAge = 57;
  String pId = "2598";
  String riskLevel = "High";
  String status = "Critical";
  int heartRate = 145;
  int spo2 = 82;

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

  String noteEn =
      "Recommend ECG and repeat SPO2 measurement if elevated readings persist.";
  String noteAr =
      "يوصى بعمل رسم قلب وتكرار قياس نسبة الأكسجين إذا استمرت القراءات المرتفعة.";

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
      'notify': 'إشعار',
      'high': 'مرتفع',
      'critical': 'حرج'
    }
  };

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Provider.of<LanguageProvider>(context).isArabic;

    String t(String key) =>
        localized[isArabic ? 'ar' : 'en']![key] ?? key;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Directionality(
        textDirection:
            isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              // HEADER
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B67A1),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 80),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: isArabic ? null : 15,
                    right: isArabic ? 15 : null,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    child: Text(
                      t('title'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Icon(Icons.account_circle,
                          size: 120, color: Color(0xFF3B67A1)),

                      const SizedBox(height: 20),

                      _infoRow(t('name'), pName, t('age'), pAge.toString()),
                      _infoRow(t('id'), pId, t('risk'), t(riskLevel),
                          valueColor2: Colors.red[900]),
                      _infoRow(
                        t('status'),
                        t(status),
                        t('hr'),
                        "$heartRate BPM",
                        valueColor1: Colors.red[900],
                        valueColor2: Colors.red[900],
                      ),
                      _infoRow(t('spo2'), "$spo2%", "", ""),

                      const SizedBox(height: 20),

                      _sectionTitle(t('history')),
                      Column(
                        children: (isArabic
                                ? medicalHistoryAr
                                : medicalHistoryEn)
                            .map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    children: [
                                      const Text("• "),
                                      Expanded(child: Text(item))
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),

                      const SizedBox(height: 20),

                      _sectionTitle(t('note')),
                      Text(isArabic ? noteAr : noteEn),

                      const SizedBox(height: 30),

                      _actionButton(t('update')),
                      const SizedBox(height: 15),
                      _actionButton(t('notify'), width: 180),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String l1, String v1, String l2, String v2,
      {Color? valueColor1, Color? valueColor2}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text("$l1$v1")),
          if (l2.isNotEmpty) Expanded(child: Text("$l2$v2")),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _actionButton(String label, {double? width}) {
    return Container(
      width: width ?? 150,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF6A859A),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(label,
            style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}