import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';
import '../services/shared_pref.dart';
import '../widgets/support_widget.dart';
import 'home.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> registration() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      //  Create Firebase Authentication User
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      //  Unique Firebase UID
      String uid = userCredential.user!.uid;

      //  User Info Map
      Map<String, dynamic> userInfoMap = {
        "Name": nameController.text.trim(),
        "Email": emailController.text.trim(),
        "Id": uid,
        "Wallet": "0",
      };

      await SharedpreferenceHelper().saveUserId(uid);
      await SharedpreferenceHelper().saveUserEmail(emailController.text.trim());
      await SharedpreferenceHelper().saveUserName(nameController.text.trim());
      await SharedpreferenceHelper().saveUserWallet("0");

      await DatabaseMethods().addUserInfo(userInfoMap, uid);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Registered Successfully",
            style: AppWidget.whiteTextstyle(18.0),
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Home()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Registration Failed";
      if (e.code == 'weak-password')
        message = "The password provided is too weak.";
      if (e.code == 'email-already-in-use')
        message = "The account already exists for that email.";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An unexpected error occurred.")),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Prevents keyboard from causing layout overflow
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            "images/signup.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 120.0),
                Center(
                  child: Text(
                    "Create Account",
                    style: AppWidget.greenTextstyle(40.0),
                  ),
                ),
                const SizedBox(height: 120.0),

                // Input Fields
                _buildTextField(nameController, "Name", Icons.person, false),
                const SizedBox(height: 30.0),
                _buildTextField(emailController, "Email", Icons.email, false),
                const SizedBox(height: 30.0),
                _buildTextField(
                  passwordController,
                  "Password",
                  Icons.lock,
                  true,
                ),

                const SizedBox(height: 60.0),

                // --- Sign Up Button ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sign Up", style: AppWidget.greenTextstyle(30.0)),
                      GestureDetector(
                        onTap: isLoading ? null : registration,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xff494b2b),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: isLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 80.0),

                Padding(
                  padding: const EdgeInsets.only(left: 30.0, bottom: 40.0),
                  child: Row(
                    children: [
                      const Text("Already have an account?"),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Login()),
                        ),
                        child: const Text(
                          "LogIn",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget
  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon,
    bool isPassword,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: (value) => value!.isEmpty ? "Please enter your $hint" : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xff494b2b)),
          hintText: hint,
          hintStyle: AppWidget.greenTextstyle(20.0),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
