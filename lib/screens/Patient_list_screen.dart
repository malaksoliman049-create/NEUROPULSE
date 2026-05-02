import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'patient_details_screen.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() =>
      _PatientListScreenState();
}

class _PatientListScreenState
    extends State<PatientListScreen> {
  final List<Map<String, String>> patientsData = [
    {"name": "Ali Ahmed", "risk": "High", "status": "Critical"},
    {"name": "Sara Hassan", "risk": "Medium", "status": "Under Observation"},
    {"name": "Ziad Khalil", "risk": "Low", "status": "Stable"},
    {"name": "Mona Omar", "risk": "High", "status": "Critical"},
  ];

  Map<String, String>? selectedPatient;

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Provider.of<LanguageProvider>(context).isArabic;

    String t(String en, String ar) =>
        isArabic ? ar : en;

    Color getRiskColor(String risk) {
      if (risk == "High") return const Color(0xFFD32F2F);
      if (risk == "Medium") return const Color(0xFF4C82B4);
      return Colors.green;
    }

    return Directionality(
      textDirection:
          isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [

            // HEADER
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4C82B4),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(200, 50),
                    ),
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Text(
                      t("Patients List", "قائمة المرضى"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 50,
                  left: isArabic ? null : 10,
                  right: isArabic ? 10 : null,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white),
                  ),
                ),
              ],
            ),

            // SEARCH
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 15),
              child: TextField(
                textAlign:
                    isArabic ? TextAlign.right : TextAlign.left,
                decoration: InputDecoration(
                  hintText:
                      t("Search patient...", "ابحث عن مريض..."),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // TABLE
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD)
                        .withValues(alpha: 0.5),
                    borderRadius:
                        BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF4C82B4)
                          .withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            _tableHeader(
                                t("Patient Name", "اسم المريض")),
                            _tableHeader(
                                t("Risk Level", "مستوى الخطر")),
                            _tableHeader(
                                t("Status", "الحالة")),
                          ],
                        ),
                      ),

                      const Divider(),

                      Expanded(
                        child: ListView.builder(
                          itemCount: patientsData.length,
                          itemBuilder: (context, index) {
                            final p = patientsData[index];

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedPatient = p;
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    _tableCell(
                                        p['name']!,
                                        Colors.black,
                                        isBold: true),
                                    _tableCell(
                                        p['risk']!,
                                        getRiskColor(
                                            p['risk']!)),
                                    _tableCell(
                                        p['status']!,
                                        getRiskColor(
                                            p['risk']!)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // BUTTON
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: selectedPatient == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                      builder: (_) => const PatientDetails(),
                            )
                        );
                      },
                child: Text(
                  t("View Full Records",
                      "عرض السجلات الكاملة"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tableHeader(String text) {
    return Expanded(
      child: Text(text,
          textAlign: TextAlign.center,
          style:
              const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _tableCell(String text, Color color,
      {bool isBold = false}) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight:
              isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}