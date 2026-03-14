import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexfit/pages/home.dart';
import 'package:flexfit/pages/signup.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';
import '../services/shared_pref.dart';
import '../widgets/support_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> userLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      //  Authentication User
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      String uid = userCredential.user!.uid;

      // Fetch User Data from Firestore using UID
      DocumentSnapshot userDoc = await DatabaseMethods().getUserDetails(uid);

      // Syn Cloud data to Local Shared Preferences
      if (userDoc.exists) {
        await SharedpreferenceHelper().saveUserId(uid);
        await SharedpreferenceHelper().saveUserName(userDoc['Name']);
        await SharedpreferenceHelper().saveUserEmail(userDoc['Email']);
        await SharedpreferenceHelper().saveUserWallet(userDoc['Wallet']);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Logged In Successfully"),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Home()),
        );
      } else {
        throw "User data not found in database.";
      }
    } on FirebaseAuthException catch (e) {
      String message = "Login Failed";
      if (e.code == "user not found") message = "No user found for that email.";
      if (e.code == "wrong-password") message = "Wrong password provided.";

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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            "images/login.jpg",
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
                    "Welcome Back",
                    style: AppWidget.greenTextstyle(40.0),
                  ),
                ),
                const SizedBox(height: 140.0),

                // Email Field
                _buildTextField(emailController, "Email", Icons.email, false),
                const SizedBox(height: 40.0),

                // Password Field
                _buildTextField(
                  passwordController,
                  "Password",
                  Icons.lock,
                  true,
                ),

                const SizedBox(height: 15.0),

                // Forgot Password
                const Padding(
                  padding: EdgeInsets.only(right: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60.0),

                // Sign In
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sign In", style: AppWidget.greenTextstyle(30.0)),
                      GestureDetector(
                        onTap: isLoading ? null : userLogin,
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

                // Sign Up
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, bottom: 40.0),
                  child: Row(
                    children: [
                      const Text("New here? "),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        ),
                        child: const Text(
                          "Sign Up",
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
        validator: (value) => value!.isEmpty ? "Enter your $hint" : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xff494b2b)),
          hintText: hint,
          hintStyle: AppWidget.greenTextstyle(20.0),
        ),
      ),
    );
  }
}
