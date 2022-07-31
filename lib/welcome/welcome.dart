import 'package:cinch/login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../camera/screen_takepicture.dart';
import '../resources/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 100.w,
                    ),
                    Text("Welcome to Cinch",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20.w,
                        )),
                    SizedBox(
                      height: 15.w,
                    ),
                    const Text("A Connectivity App for Deaf and Mute",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 15,
                          fontFamily: 'Roboto-Regular',
                        )),
                    SizedBox(
                      height: 20.w,
                    ),
                    Container(
                        child: Center(
                      child: Lottie.asset('assets/connect.json',
                          height: size.height / 3),
                    )),
                    SizedBox(
                      height: size.height / 8,
                    ),
                    ButtonTheme(
                      minWidth: 335.0,
                      height: 50.0,
                      child: FlatButton(
                        textColor: Color.fromARGB(255, 213, 0, 0),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const TakePicture()));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: const Text(
                          "Register Later\u200d",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontFamily: 'Roboto-Regular',
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50.0,
                      width: 335.0,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.blue,
                          side: const BorderSide(color: Colors.blue, width: 2),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                        ),
                        child: const Text('Login / SignUp',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontFamily: 'Roboto-Regular',
                              height: 1.5,
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: LoginScreen()));
                        },
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
