import 'dart:async';

import 'package:cinch/camera/screen_takepicture.dart';
import 'package:cinch/chat/ChatRoom.dart';
import 'package:cinch/chat/group_chat_room.dart';
import 'package:cinch/chat/NearbyPeople.dart';
import 'package:cinch/login/Methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:material_dialogs/material_dialogs.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final name = FirebaseAuth.instance.currentUser!.displayName;
  List groupList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = false;
    });

    await _firestore
        .collection('users')
        .where("name", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  void getAvailableGroups() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get()
        .then((value) {
      setState(() {
        groupList = value.docs;
        isLoading = false;
      });
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GroupChatRoom(
          groupName: groupList[0]['name'],
          groupChatId: groupList[0]['name'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(
              child: SizedBox(
                height: size.height / 20,
                width: size.height / 20,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: size.height / 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Hello ",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                          Text(name!,
                              style: const TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                          const Text(
                            "! ",
                            style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Lottie.asset(
                        'assets/chat.json',
                        width: size.width / 2,
                        height: size.height / 4,
                      ),
                      // SizedBox(
                      //   height: size.height / 20,
                      // ),
                      Column(
                        children: [
                          Container(
                            height: size.height / 14,
                            width: size.width,
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: size.height / 14,
                              width: size.width / 1.15,
                              child: TextField(
                                controller: _search,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search),
                                  hintText: "Search for People",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height / 50,
                          ),
                          ElevatedButton(
                            onPressed: onSearch,
                            child: Container(
                                height: size.height / 20,
                                width: size.width / 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Search",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          userMap != null
                              ? ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  onTap: () {
                                    String roomId = chatRoomId(
                                        _auth.currentUser!.displayName!,
                                        userMap!['name']);

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => ChatRoom(
                                          chatRoomId: roomId,
                                          userMap: userMap!,
                                        ),
                                      ),
                                    );
                                  },
                                  title: Text(
                                    userMap!['name'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(userMap!['place']),
                                  trailing: const Text("Tap to chat"),
                                )
                              : Container(),
                          SizedBox(height: size.height / 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.connect_without_contact,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => NearbyPeople(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => NearbyPeople(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Nearby People",
                                        style: TextStyle(
                                            fontSize: size.width / 40),
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.group,
                                        color: Colors.white,
                                      ),
                                      onPressed: () =>
                                          Timer(const Duration(seconds: 0), () {
                                        getAvailableGroups();
                                      }),
                                    ),
                                  ),
                                  TextButton(
                                      child: Text(
                                        "Group Chat",
                                        style: TextStyle(
                                            fontSize: size.width / 40),
                                      ),
                                      onPressed: () =>
                                          Timer(const Duration(seconds: 0), () {
                                            getAvailableGroups();
                                          })),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: IconButton(
                                        icon: const Icon(
                                          Icons.translate,
                                          color: Colors.white,
                                        ),
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
                                            msg:
                                                'You could only recognise Alphabets',
                                            title: 'Hold the Camera Steadily',
                                            lottieBuilder: Lottie.asset(
                                                'assets/cameraloading.json'),
                                            context: context,
                                            actions: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                      ),
                                                      minimumSize:
                                                          const Size(140, 52),
                                                      primary: Colors.blue,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          PageTransition(
                                                              type: PageTransitionType
                                                                  .rightToLeft,
                                                              child:
                                                                  const TakePicture()));
                                                    },
                                                    child: Text(
                                                      "Open Translator",
                                                      style: GoogleFonts.poppins(
                                                          textStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18)),
                                                    )),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                  TextButton(
                                      child: Text(
                                        "Translator",
                                        style: TextStyle(
                                            fontSize: size.width / 40),
                                      ),
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
                                          msg:
                                              'You could only recognise Alphabets',
                                          title: 'Hold the Camera Steadily',
                                          lottieBuilder: Lottie.asset(
                                              'assets/cameraloading.json'),
                                          context: context,
                                          actions: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                    ),
                                                    minimumSize:
                                                        const Size(140, 52),
                                                    primary: Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .rightToLeft,
                                                            child:
                                                                const TakePicture()));
                                                  },
                                                  child: Text(
                                                    "Open Translator",
                                                    style: GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18)),
                                                  )),
                                            ),
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height / 30,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: OutlineButton(
                                  child: const Text("Logout"),
                                  onPressed: () {
                                    logOut(context);
                                    setStatus("Offline");
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
