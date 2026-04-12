import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 🔵 Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                color: Color(0xFF4C82B4),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: const Center(
                child: Text(
                  "NeuroPulse",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Sign-Up",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C82B4),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildTextField("Name"),
                    buildTextField("Email"),
                    buildTextField("Password", isPassword: true),
                    buildTextField("Confirm Password",
                        isPassword: true, isConfirm: true),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(child: buildSmallField("Age")),
                        const SizedBox(width: 10),
                        Expanded(child: buildGenderSelector()),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Are you a Patient or a Dr?",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    const SizedBox(height: 5),

                    buildTextField("Enter Your Role Here"),

                    const SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4C82B4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding:
                                const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text("Sign Up"),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const SizedBox(height: 10),

                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("OR"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          "https://img.icons8.com/color/48/google-logo.png",
                          width: 30,
                        ),
                        const SizedBox(width: 20),
                        Image.network(
                          "https://img.icons8.com/color/48/facebook-new.png",
                          width: 30,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 TextField كبير (مع العين)
  Widget buildTextField(String hint,
      {bool isPassword = false, bool isConfirm = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: TextField(
        obscureText: isPassword
            ? (isConfirm ? isConfirmPasswordHidden : isPasswordHidden)
            : false,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[100],

          // 👁️ أيقونة العين
          suffixIcon: isPassword
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

  // 🔹 TextField صغير
  Widget buildSmallField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildGenderSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedGender,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            items: const [
              DropdownMenuItem(
                value: 'Male',
                child: Text('Male'),
              ),
              DropdownMenuItem(
                value: 'Female',
                child: Text('Female'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedGender = value;
                });
              }
            },
            hint: const Text('Gender'),
            style: TextStyle(
              color: selectedGender == null ? Colors.grey.shade700 : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
