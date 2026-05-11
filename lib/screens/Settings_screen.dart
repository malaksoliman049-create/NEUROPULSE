import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class SettingsScreen
    extends StatefulWidget {

  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen>
      createState() =>
          _SettingsScreenState();
}

class _SettingsScreenState
    extends State<
        SettingsScreen> {

  bool isConnected = true;

  String lastSyncValue = "2";

  Map<String, Map<String, String>>
      localizedValues = {

    'en': {

      'settings':
          'Settings',

      'connected':
          'Device Connected',

      'disconnected':
          'Device Disconnected',

      'lastSync':
          'Last Sync : ',

      'minutesAgo':
          ' min ago',

      'sync':
          'Sync Now',

      'logout':
          'Log-Out',
    },

    'ar': {

      'settings':
          'الإعدادات',

      'connected':
          'الجهاز متصل',

      'disconnected':
          'الجهاز غير متصل',

      'lastSync':
          'آخر مزامنة : ',

      'minutesAgo':
          ' دقيقة مضت',

      'sync':
          'مزامنة الآن',

      'logout':
          'تسجيل الخروج',
    }
  };

  @override
  Widget build(
    BuildContext context,
  ) {

    final isArabic =
        Provider.of<
            LanguageProvider>(
      context,
    ).isArabic;

    const primaryColor =
        Color(0xFF4C82B4);

    String t(String key) {

      return localizedValues[
          isArabic
              ? 'ar'
              : 'en']![key]!;
    }

    return AnnotatedRegion<
        SystemUiOverlayStyle>(

      value:
          const SystemUiOverlayStyle(

        statusBarColor:
            Colors.transparent,

        statusBarIconBrightness:
            Brightness.light,
      ),

      child: Directionality(

        textDirection:
            isArabic
                ? TextDirection.rtl
                : TextDirection.ltr,

        child: Scaffold(

          backgroundColor:
              Colors.white,

          body: Column(
            children: [

              /// 🔵 HEADER
              Stack(
                children: [

                  Container(

                    height: 170,

                    width:
                        double.infinity,

                    decoration:
                        BoxDecoration(
  color:
                            const Color(
                          0xFF4C82B4,
                        ),
                      borderRadius:
                          BorderRadius
                              .vertical(

                        bottom:
                            Radius
                                .elliptical(

                          MediaQuery.of(
                                  context)
                              .size
                              .width,

                          60,
                        ),
                      ),
                    ),
                  ),

                  /// 🔙 BACK BUTTON
                  Positioned(

                    top: 80,

                    left:
                        isArabic
                            ? null
                            : 10,

                    right:
                        isArabic
                            ? 10
                            : null,

                    child:
                        IconButton(

                      icon:
                          const Icon(

                        Icons
                            .arrow_back_ios_new,

                        color:
                            Colors.white,

                        size: 24,
                      ),

                      onPressed:
                          () =>
                              Navigator.pop(
                        context,
                      ),
                    ),
                  ),

                  /// 📝 TITLE
                  Positioned(

                    top: 90,

                    left: 0,
                    right: 0,

                    child: Center(

                      child: Text(

                        t(
                          'settings',
                        ),

                        style:
                            const TextStyle(

                          color:
                              Colors.white,

                          fontSize:
                              22,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(

                child: Padding(

                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 25,
                  ),

                  child: Column(

                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,

                    children: [

                      /// 📱 STATUS CARD
                      Container(

                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets
                                .symmetric(

                          vertical: 35,
                          horizontal: 20,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              const Color(
                            0xFFE8F1FA,
                          ),

                          borderRadius:
                              BorderRadius
                                  .circular(
                            20,
                          ),

                          boxShadow: [

                            BoxShadow(

                              color:
                                  Colors.black
                                      .withValues(
                                alpha:
                                    0.05,
                              ),

                              blurRadius:
                                  5,

                              offset:
                                  const Offset(
                                0,
                                2,
                              ),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [

                            Icon(

                              isConnected

                                  ? Icons
                                      .bluetooth_connected

                                  : Icons
                                      .bluetooth_disabled,

                              size: 65,

                              color:
                                  isConnected

                                      ? Colors
                                          .green
                                          .shade700

                                      : Colors
                                          .red,
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            Text(

                              isConnected

                                  ? t(
                                      'connected',
                                    )

                                  : t(
                                      'disconnected',
                                    ),

                              style:
                                  TextStyle(

                                color:
                                    isConnected

                                        ? Colors
                                            .green
                                            .shade700

                                        : Colors
                                            .red,

                                fontSize:
                                    24,

                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Text(

                              "${t('lastSync')}$lastSyncValue${t('minutesAgo')}",

                              style:
                                  const TextStyle(

                                color:
                                    Colors
                                        .blueGrey,

                                fontSize:
                                    15,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 45,
                      ),

                      /// 🔄 SYNC BUTTON
                      _buildMenuButton(

                        t('sync'),

                        primaryColor,

                        onTap: () {},
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      /// 🔴 LOGOUT BUTTON
                      _buildMenuButton(

                        t('logout'),

                        const Color(
                          0xFFD32F2F,
                        ),

                        onTap: () {},
                      ),
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

  /// 📦 BUTTON
  Widget _buildMenuButton(

    String label,
    Color color, {

    required VoidCallback onTap,

  }) {

    return InkWell(

      onTap: onTap,

      borderRadius:
          BorderRadius.circular(
        15,
      ),

      child: Container(

        width: double.infinity,

        padding:
            const EdgeInsets.symmetric(
          vertical: 16,
        ),

        decoration:
            BoxDecoration(

          color: color,

          borderRadius:
              BorderRadius.circular(
            15,
          ),

          boxShadow: [

            BoxShadow(

              color:
                  Colors.black
                      .withValues(
                alpha: 0.08,
              ),

              blurRadius: 10,

              offset:
                  const Offset(
                0,
                4,
              ),
            ),
          ],
        ),

        child: Center(

          child: Text(

            label,

            style:
                const TextStyle(

              color:
                  Colors.white,

              fontSize: 18,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}