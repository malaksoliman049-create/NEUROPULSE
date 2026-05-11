import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class ChatbotScreen
    extends StatefulWidget {

  const ChatbotScreen({
    super.key,
  });

  @override
  State<ChatbotScreen>
      createState() =>
          _ChatbotScreenState();
}

class _ChatbotScreenState
    extends State<
        ChatbotScreen> {

  final TextEditingController
      controller =
          TextEditingController();

  List<Map<String, String>>
      messages = [

    {
      "type": "bot",
      "text":
          "How old are you?",
    },

    {
      "type": "user",
      "text":
          "I'm 45 years old.",
    },

    {
      "type": "bot",
      "text":
          "Do you have Hypertension?",
    },

    {
      "type": "user",
      "text":
          "Yes, I do.",
    },
  ];

  Map<String, Map<String, String>>
      tMap = {

    'en': {

      'title':
          'Health Assistant',

      'hint':
          'Type your message here...',

      'got':
          'Got it 👍',
    },

    'ar': {

      'title':
          'المساعد الصحي',

      'hint':
          'اكتب رسالتك هنا...',

      'got':
          'تم 👍',
    }
  };

  void sendMessage(

    String Function(String) t,

  ) {

    final text =
        controller.text.trim();

    if (text.isEmpty) return;

    setState(() {

      messages.add({

        "type": "user",

        "text": text,
      });

      messages.add({

        "type": "bot",

        "text": t('got'),
      });

      controller.clear();
    });
  }

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

      return tMap[
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
              const Color(
            0xFFF2F2F2,
          ),

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
                          () {

                        Navigator.pop(
                          context,
                        );
                      },
                    ),
                  ),

                  /// 📝 TITLE
                  Positioned(

                    top: 90,

                    left: 0,
                    right: 0,

                    child: Center(

                      child: Text(

                        t('title'),

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

              const SizedBox(
                height: 20,
              ),

              /// 💬 MESSAGES
              Expanded(

                child:
                    ListView.builder(

                  padding:
                      const EdgeInsets
                          .all(
                    16,
                  ),

                  itemCount:
                      messages.length,

                  itemBuilder:
                      (
                        context,
                        index,
                      ) {

                    final msg =
                        messages[
                            index];

                    return msg[
                                "type"] ==
                            "user"

                        ? userMessage(
                            msg["text"]!,
                          )

                        : botMessage(
                            msg["text"]!,
                          );
                  },
                ),
              ),

              /// ✍️ INPUT AREA
              Container(

                margin:
                    const EdgeInsets
                        .all(
                  15,
                ),

                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 15,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius
                          .circular(
                    18,
                  ),

                  boxShadow: [

                    BoxShadow(

                      color:
                          Colors.black
                              .withValues(
                        alpha: 0.05,
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

                child: Row(
                  children: [

                    Expanded(

                      child: TextField(

                        controller:
                            controller,

                        decoration:
                            InputDecoration(

                          hintText:
                              t('hint'),

                          border:
                              InputBorder
                                  .none,
                        ),
                      ),
                    ),

                    IconButton(

                      onPressed:
                          () =>
                              sendMessage(
                        t,
                      ),

                      icon: Icon(

                        Icons.send,

                        color:
                            primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🤖 BOT MESSAGE
  Widget botMessage(
    String text,
  ) {

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        const CircleAvatar(

          backgroundColor:
              Color(
            0xFFE8F1FA,
          ),

          child: Icon(

            Icons.smart_toy,

            color:
                Color(
              0xFF4C82B4,
            ),
          ),
        ),

        const SizedBox(
          width: 10,
        ),

        Flexible(

          child: Container(

            margin:
                const EdgeInsets.only(
              bottom: 12,
            ),

            padding:
                const EdgeInsets.all(
              14,
            ),

            decoration:
                BoxDecoration(

              color:
                  Colors.white,

              borderRadius:
                  BorderRadius.circular(
                15,
              ),

              boxShadow: [

                BoxShadow(

                  color:
                      Colors.black
                          .withValues(
                    alpha: 0.03,
                  ),

                  blurRadius:
                      4,

                  offset:
                      const Offset(
                    0,
                    2,
                  ),
                ),
              ],
            ),

            child: Text(

              text,

              style:
                  const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 👤 USER MESSAGE
  Widget userMessage(
    String text,
  ) {

    return Row(

      mainAxisAlignment:
          MainAxisAlignment.end,

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Flexible(

          child: Container(

            margin:
                const EdgeInsets.only(
              bottom: 12,
            ),

            padding:
                const EdgeInsets.all(
              14,
            ),

            decoration:
                BoxDecoration(

              color:
                  const Color(
                0xFF4C82B4,
              ),

              borderRadius:
                  BorderRadius.circular(
                15,
              ),
            ),

            child: Text(

              text,

              style:
                  const TextStyle(

                color:
                    Colors.white,

                fontSize: 14,
              ),
            ),
          ),
        ),

        const SizedBox(
          width: 20,
        ),

        const CircleAvatar(

          backgroundColor:
              Color(
            0xFFE8F1FA,
          ),

          child: Icon(

            Icons.person,

            color:
                Color(
              0xFF4C82B4,
            ),
          ),
        ),
      ],
    );
  }
}