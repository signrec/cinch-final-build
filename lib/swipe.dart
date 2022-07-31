import 'package:cinch/resources/colors.dart';
import 'package:cinch/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class Swipe extends StatefulWidget {
  const Swipe({Key? key}) : super(key: key);

  @override
  State<Swipe> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Swipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LiquidSwipe(
      //enableSideReveal: true,
      slideIconWidget: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      pages: [
        Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset('assets/loader.json'),
                ),
                Text(
                  'Welcome to ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.w,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Cinch',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 80.w,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Color.fromARGB(255, 113, 200, 116),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Lottie.asset('assets/talking.json')),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Connect with  ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'People in your Locality',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          color: Color.fromARGB(255, 81, 154, 213),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset('assets/locations.json'),
                ),
                Center(
                  child: Text(
                    ' Exclusively for ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Deaf & Mute',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50.w,
                ),
                ButtonTheme(
                  minWidth: 100,
                  height: 50.0,
                  child: FlatButton(
                    textColor: NowUIColors.homeclr,
                    color: NowUIColors.beyaz,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: Home()));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: const Text(
                      "Next\u200d",
                      style: TextStyle(
                        color: NowUIColors.homeclr,
                        fontSize: 14,
                        fontFamily: 'Roboto-Regular',
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
