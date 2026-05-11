import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';

class ChatWPatientScreen extends StatefulWidget {
  const ChatWPatientScreen({super.key});

  @override
  State<ChatWPatientScreen> createState() =>
      _ChatWPatientScreenState();
}

class _ChatWPatientScreenState
    extends State<ChatWPatientScreen> {

  final TextEditingController controller =
      TextEditingController();

  final List<Map<String, dynamic>> messages = [

    {
      "en": "How are you feeling today?",
      "ar": "كيف تشعر اليوم؟",
      "isMe": true
    },

    {
      "en": "I feel dizzy",
      "ar": "أشعر بدوخة",
      "isMe": false
    },
  ];

  void sendMessage() {

    if (controller.text.trim().isEmpty) {
      return;
    }

    setState(() {

      messages.add({

        "en": controller.text,
        "ar": controller.text,
        "isMe": true,
      });

      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {

    final isArabic =
        Provider.of<LanguageProvider>(
          context,
        ).isArabic;

    return AnnotatedRegion<SystemUiOverlayStyle>(

      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
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
              Colors.grey[200],

          body: Column(
            children: [

              // ================= HEADER =================

              Stack(
                children: [

                  Container(

                    height: 220,
                    width: double.infinity,

                    decoration: BoxDecoration(

                      color:
                          const Color(
                        0xFF4C82B4,
                      ),

                      borderRadius:
                          BorderRadius.vertical(
                        bottom:
                            Radius.elliptical(
                          MediaQuery.of(context)
                              .size
                              .width,
                          60,
                        ),
                      ),
                    ),
                  ),

                  // ================= BACK BUTTON =================

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

                    child: IconButton(

                      onPressed: () =>
                          Navigator.pop(
                        context,
                      ),

                      icon: const Icon(
                        Icons
                            .arrow_back_ios_new,
                        color:
                            Colors.white,
                        size: 22,
                      ),
                    ),
                  ),

                  // ================= PROFILE =================

                  Positioned(

                    top: 85,
                    left: 0,
                    right: 0,

                    child: Column(
                      children: [

                        const CircleAvatar(

                          radius: 32,

                          backgroundImage:
                              NetworkImage(
                            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        const Text(

                          "Ahmed Ali",

                          style: TextStyle(
                            color:
                                Colors.white,
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 3,
                        ),

                        Text(

                          isArabic
                              ? "متصل الآن"
                              : "Online",

                          style:
                              const TextStyle(
                            color:
                                Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // ================= CHAT BODY =================

              Expanded(

                child: ListView.builder(

                  padding:
                      const EdgeInsets.all(
                    15,
                  ),

                  itemCount:
                      messages.length,

                  itemBuilder:
                      (context, index) {

                    final msg =
                        messages[index];

                    return Align(

                      alignment:
                          msg["isMe"]
                              ? Alignment
                                  .centerRight
                              : Alignment
                                  .centerLeft,

                      child: Container(

                        margin:
                            const EdgeInsets
                                .symmetric(
                          vertical: 5,
                        ),

                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),

                        decoration:
                            BoxDecoration(

                          color:
                              msg["isMe"]
                                  ? const Color(
                                      0xFF9BB3C9,
                                    )
                                  : Colors
                                      .blueGrey[200],

                          borderRadius:
                              BorderRadius
                                  .circular(
                            20,
                          ),
                        ),

                        child: Text(

                          isArabic
                              ? msg["ar"]
                              : msg["en"],

                          style: TextStyle(

                            color:
                                msg["isMe"]
                                    ? Colors
                                        .white
                                    : Colors
                                        .black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ================= INPUT =================

              Container(

                margin: const EdgeInsets.only(
                  bottom: 5,
                ),

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),

                decoration:
                    const BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                      BorderRadius.vertical(
                    top:
                        Radius.circular(20),
                  ),
                ),

                child: Row(
                  children: [

                    Expanded(

                      child: TextField(

                        controller:
                            controller,

                        textAlign:
                            isArabic
                                ? TextAlign
                                    .right
                                : TextAlign
                                    .left,

                        decoration:
                            InputDecoration(

                          hintText:
                              isArabic
                                  ? "اكتب رسالتك..."
                                  : "Type message...",

                          border:
                              InputBorder.none,
                        ),
                      ),
                    ),

                    IconButton(

                      onPressed:
                          sendMessage,

                      icon: const Icon(

                        Icons.send,

                        color:
                            Color(
                          0xFF4C82B4,
                        ),
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
}