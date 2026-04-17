import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // مهم جداً للتحكم في الـ Status Bar

class AlertScreen extends StatefulWidget {
  final bool isArabic; // حالة اللغة ممررة من صفحة الإعدادات

  const AlertScreen({super.key, required this.isArabic});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  // ---------------------------------------------------------
  // 💾 المتغيرات التي ستتغير تلقائياً عند ربط الساعة
  // ---------------------------------------------------------
  String strokeRiskStatus = "High"; 
  int heartRateValue = 145;        
  int oxygenLevel = 82;           
  String aiPredictionTextEn = "High stroke risk";
  String aiPredictionTextAr = "خطر إصابة مرتفع بالسكتة";
  // ---------------------------------------------------------

  // قاموس الترجمة
  Map<String, Map<String, String>> localized = {
    'en': {
      'risk_label': 'Stroke Risk: ',
      'high': 'High',
      'low': 'Low',
      'ai_title': 'AI Prediction',
      'call_doc': 'Call Doctor!',
      'call_emg': 'Call Emergency!',
    },
    'ar': {
      'risk_label': 'خطر الإصابة بالسكتة: ',
      'high': 'عالي',
      'low': 'منخفض',
      'ai_title': 'توقعات الذكاء الاصطناعي',
      'call_doc': 'اتصل بالطبيب!',
      'call_emg': 'اتصل بالطوارئ!',
    }
  };

  String t(String key) => localized[widget.isArabic ? 'ar' : 'en']![key]!;

  @override
  Widget build(BuildContext context) {
    // تحديد لون الكارت بناءً على مستوى الخطر
    Color statusColor = strokeRiskStatus == "High" ? const Color(0xFFB71C1C) : Colors.green[800]!;

    // AnnotatedRegion بتخلينا نتحكم في شكل الـ Status Bar اللي فيه الساعة والبطارية
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // شفاف عشان يبان لون الهيدر تحته
        statusBarIconBrightness: Brightness.light, // الأيقونات (ساعة، واي فاي) تبان بيضاء
      ),
      child: Directionality(
        textDirection: widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              // 🔵 الجزء العلوي المنحني (Header)
              Stack(
                children: [
                  Container(
                    height: 160, // طول الهيدر لضمان تغطية منطقة الساعة
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B67A1),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(MediaQuery.of(context).size.width, 80),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 55, // مكان أيقونة الرجوع تحت الـ Status Bar مباشرة
                    left: widget.isArabic ? null : 15,
                    right: widget.isArabic ? 15 : null,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // 🔴 كارت البيانات المتغيرة (Red Alert Card)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${t('risk_label')}${strokeRiskStatus == 'High' ? t('high') : t('low')}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Serif',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "HR: $heartRateValue bpm | SpO2: $oxygenLevel%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Serif',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🧠 كارت الـ AI Prediction
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6A859A),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.psychology, color: Colors.pinkAccent, size: 55),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t('ai_title'),
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.isArabic ? aiPredictionTextAr : aiPredictionTextEn,
                              style: const TextStyle(
                                color: Color(0xFFB71C1C), // أحمر غامق للتنبيه
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Serif',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // 📞 أزرار الاتصال بالطوارئ
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCallButton(t('call_doc')),
                    _buildCallButton(t('call_emg')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ويجت مساعد لتصميم أزرار الاتصال
  Widget _buildCallButton(String label) {
    return Container(
      width: 155,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF6A859A),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}