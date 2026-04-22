import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// 🔵 الخلفية البيضاء
          Container(color: Colors.white),

          /// ⚪ الجزء الرمادي
          Positioned(
            top: 120, // 🔥 بيبدأ تحت الأزرق
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),

                    const Text(
                      "Sign-Up",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C82B4),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildStepCircle("1", true),
                        Container(width: 40, height: 1, color: Colors.grey),
                        buildStepCircle("2", false),
                      ],
                    ),

                    const SizedBox(height: 20),

                    buildTextField("Name"),
                    buildTextField("Email"),
                    buildTextField("Password", isPassword: true),
                    buildTextField("Confirm Password", isConfirm: true),

                    const SizedBox(height: 10),

                    const Text(
                      "Are you a Patient or a Dr?",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    const SizedBox(height: 5),

                    buildTextField("Enter Your Role Here"),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4C82B4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {},
                        child: const Text("Next"),
                      ),
                    ),

                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),

          /// 🔵 الجزء الأزرق (فوق)
          Container(
            height: 160,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF4C82B4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              ),
            ),
            child: const Center(
              child: Text(
                "NeuroPulse",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Step Circle
  Widget buildStepCircle(String text, bool active) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: active ? const Color(0xFF4C82B4) : Colors.grey,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? const Color(0xFF4C82B4) : Colors.grey,
        ),
      ),
    );
  }

  /// TextField
  Widget buildTextField(String hint,
      {bool isPassword = false, bool isConfirm = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        obscureText: (isPassword || isConfirm)
            ? (isConfirm ? isConfirmPasswordHidden : isPasswordHidden)
            : false,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: (isPassword || isConfirm)
              ? IconButton(
                  icon: Icon(
                    (isConfirm
                            ? isConfirmPasswordHidden
                            : isPasswordHidden)
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isConfirm) {
                        isConfirmPasswordHidden =
                            !isConfirmPasswordHidden;
                      } else {
                        isPasswordHidden = !isPasswordHidden;
                      }
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}