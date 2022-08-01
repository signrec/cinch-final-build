import 'package:cinch/swipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../chat/HomeScreen.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    void didChangeDependencies() {
      precacheImage(const AssetImage("assets/loader.json"), context);
    }

    if (_auth.currentUser != null) {
      return HomeScreen();
    } else {
      return const Swipe();
    }
  }
}
