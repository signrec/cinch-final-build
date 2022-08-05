import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tflite/tflite.dart';

class OpenCamera extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const OpenCamera({this.cameras, Key? key}) : super(key: key);

  @override
  _OpenCameraState createState() => _OpenCameraState();
}

class _OpenCameraState extends State<OpenCamera> {
  bool isWorking = false;
  String output = "";
  CameraImage? cameraImage;

  late CameraController cameraController;
  @override
  void initState() {
    super.initState();
    loadmodel();
    initCamera();
  }

  @override
  void dispose() async {
    super.dispose();
    cameraController.stopImageStream();
    Tflite.close();
  }

  Future loadmodel() async {
    Tflite.close();
    await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/model.txt");
  }

  initCamera() {
    cameraController =
        CameraController(widget.cameras![0], ResolutionPreset.ultraHigh);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imageFromStream) => {
              if (!isWorking)
                {isWorking = true, cameraImage = imageFromStream, runModel()}
            });
      });
    });
  }

  runModel() async {
    {
      var recognitions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          // rotation: 90,
          numResults: 1,
          threshold: 0.1,
          asynch: true);
      output = "";
      recognitions?.forEach((response) {
        output += response["label"];
        print(output);
      });

      setState(() {
        output;
      });
      isWorking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                            ),
                            child: CameraPreview(cameraController)),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            left: 14.w,
                            right: 18.w,
                            top: 18.h,
                          ),
                          child: Row(children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                              splashColor: const Color(0xff121421),
                              iconSize: 20.w,
                              color: Colors.white,
                            ),
                          ])),
                      Positioned(
                          bottom: 0,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: Container(
                            height: 80.w,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(39, 42, 44, 1)
                                  .withOpacity(0.7),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                topLeft: Radius.circular(30.0),
                                // bottomLeft: Radius.circular(30.0),
                                // bottomRight: Radius.circular(30.0),
                              ),
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 5)
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.w),
                              child: Text(output,
                                  style:
                                      // GoogleFonts.ubuntu(textStyle:
                                      TextStyle(
                                          fontSize: 18.w,
                                          color: const Color.fromARGB(
                                              255, 208, 204, 204)
                                          // ),
                                          ),
                                  textAlign: TextAlign.center),
                            ),
                          )))
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
