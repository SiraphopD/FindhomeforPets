import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/states/chat/chat.dart';
import 'package:findhomeforpets/states/home1.dart';
import 'package:findhomeforpets/states/profile.dart';
import 'package:findhomeforpets/states/setting.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FToast fToast = FToast();
  @override
  void initState() {
    // TODO: implement initState
    fToast.init(context);
    super.initState();
    checkFirebaseData();
  }

// check uid ----------------------------------------------------------------------------
  void checkFirebaseData() async {
    // Check if user is signed in
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('Firebase UID: ${user.uid}');

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();
      if (userDoc.exists && user.uid == userDoc.id) {
        print('UID matches in Firestore: ${user.uid}');
      } else {
        print('x');
      }
    } else {
      print('User is not signed in');
    }
  }

//--------------------------------------------------------------------
  late int currentIndex = 0;
  List widgetOptions = [Home1(), Chat(), Profile(), Setting()];
  @override
  Widget build(BuildContext context) {
    final message = 'กดอีกครั้งเพื่อออก';
    bool doubleBack = false;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didpop) async {
        if (currentIndex == 0 ||
            currentIndex == 1 ||
            currentIndex == 2 ||
            currentIndex == 3) {
          if (doubleBack) {
            Fluttertoast.cancel();
            SystemNavigator.pop();
          } else {
            doubleBack = true;
            Fluttertoast.showToast(
              msg: message,
              fontSize: 15,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black.withOpacity(0.5),
            );
            await Future.delayed(Duration(seconds: 2));
            doubleBack = false;
          }
        }
      },
      child: Scaffold(
        body: Center(
          child: widgetOptions[currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: 'หน้าหลัก',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat, color: Colors.black), label: 'แชท'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.black),
                label: 'โปรไฟล์'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings, color: Colors.black),
                label: 'ตั้งค่า'),
          ],
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          unselectedItemColor: Colors.black,
          selectedItemColor: MyStyle().primaryColor,
        ),
      ),
    );
  }
}
