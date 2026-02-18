import 'package:flexfit/pages/signup.dart';
import 'package:flutter/material.dart';

import '../widgets/support_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "images/login.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              SizedBox(height: 100.0),
              Center(
                child: Text(
                  "Welcome Back",
                  style: AppWidget.greenTextstyle(40.0),
                ),
              ),
              SizedBox(height: 120.0),

              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: AppWidget.greenTextstyle(20.0),
                  ),
                ),
              ),
              SizedBox(height: 50.0),

              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: AppWidget.greenTextstyle(20.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),

              Padding(
                padding: const EdgeInsets.only(right: 40.0),
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
              SizedBox(height: 90.0),

              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sign In", style: AppWidget.greenTextstyle(30.0)),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Color(0xff494b2b),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 5),

              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
