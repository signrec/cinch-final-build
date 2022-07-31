import 'dart:async';

import 'package:cinch/camera/screen_camera.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:lottie/lottie.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({
    Key? key,
  }) : super(key: key);

  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 5),
      () async {
        await availableCameras().then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OpenCamera(
                  cameras: value,
                ),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    // color: Colors.black,
                    child: Lottie.asset(
                      'assets/mute.json',
                      width: size.width / 1,
                      height: size.height / 2,
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () async {
                  //     await availableCameras().then((value) => Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => OpenCamera(
                  //               cameras: value,
                  //             ),
                  //           ),
                  //         ));
                  //   },
                  CircularProgressIndicator(),

                  // Text(
                  //   "Open Translator",
                  //   style: GoogleFonts.lato(
                  //       textStyle: const TextStyle(
                  //     fontWeight: FontWeight.w700,
                  //     fontSize: 15,
                  //   )),
                  // ),
                ],
              ),
              // child: TextButton(
              //   onPressed: () async {
              //     await availableCameras().then((value) => Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => OpenCamera(
              //               cameras: value,
              //             ),
              //           ),
              //         ));
              //   },
              //   child: const Text(
              //     "Open Translator",
              //     style: TextStyle(
              //         color: Color.fromARGB(255, 94, 125, 216), fontSize: 40),
              //   ),

              //   // Text(
              //   //   "Open Translator",
              //   //   style: GoogleFonts.lato(
              //   //       textStyle: const TextStyle(
              //   //     fontWeight: FontWeight.w700,
              //   //     fontSize: 15,
              //   //   )),
              //   // ),
              // ),
            ),
          ),
        ));
  }
}
