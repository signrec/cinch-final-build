import 'package:cinch/resources/reusable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cinch/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
              child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width / 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  SizedBox(
                    width: size.width / 1.1,
                    child: const Text(
                      "Forgot Again?",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 1.1,
                    child: Text(
                      "Fill the fields to continue",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: size.height / 20,
                        ),
                        Lottie.asset(
                          'assets/fpass.json',
                          //  width: size.width / 3,
                          // height: size.height / 6,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextField("Enter Email Id", Icons.mail, false,
                            _emailTextController),
                        const SizedBox(
                          height: 20,
                        ),
                        firebaseUIButton(context, "Reset Password", () {
                          FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: _emailTextController.text)
                              .then((value) => Navigator.of(context).pop());
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Password Reset Link Sent')));
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ))),
    );
  }
}
