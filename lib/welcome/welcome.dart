import 'package:cinch/login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../camera/screen_takepicture.dart';

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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 100.w,
                  ),
                  Text(
                    "Welcome to Cinch",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24)),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  // const Text(
                  //   "A Connectivity App for Deaf and Mute",
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 14,
                  //     // fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  DefaultTextStyle(
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 14)),
                    child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TyperAnimatedText(
                              'A Connectivity App for Deaf and Mute',
                              speed: const Duration(milliseconds: 100)),
                        ]),
                  ),
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
                      textColor: const Color.fromARGB(255, 213, 0, 0),
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: LoginScreen()));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: const Text(
                        "Login / Signup\u200d",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
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
                      child: const Text('Open Translator',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            // fontFamily: 'Roboto-Regular',
                            height: 1.5,
                          )),
                      onPressed: () {
                        Dialogs.bottomMaterialDialog(
                          color: Colors.white,
                          titleStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.w,
                          )),
                          msgStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.w,
                          )),
                          msg: 'You could only recognise Alphabets',
                          title: 'Hold the Camera Steadily',
                          lottieBuilder:
                              Lottie.asset('assets/cameraloading.json'),
                          context: context,
                          actions: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  minimumSize: Size(140.w, 52.w),
                                  primary: Colors.blue,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: const TakePicture()));
                                },
                                child: Text(
                                  "Open Translator",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                )),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
