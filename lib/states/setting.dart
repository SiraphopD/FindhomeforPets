// import 'dart:js_interop';

import 'package:findhomeforpets/states/authen.dart';
import 'package:findhomeforpets/states/home.dart';
// import 'package:findhomeforpets/states/home1.dart';
import 'package:findhomeforpets/states/mypost/mypost.dart';
import 'package:findhomeforpets/states/profile.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  double? screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  icon: Icon(Icons.arrow_back_outlined)),
              Text('ตั้งค่า'),
            ],
          ),
          backgroundColor: MyStyle().primaryColor,
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            children: [buildH1(), buildH2(), Spacer(), buildlogout()],
          ),
        )));
  }

  Container buildH1() {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(top: 10),
      width: screenWidth! * 0.9,
      height: screenHeight! * 0.12,
      decoration: BoxDecoration(
          color: MyStyle().secondColor,
          borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile())),
          child: Text(
            'โปรไฟล์',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenHeight! * 0.025),
          )),
    );
  }

  Container buildH2() {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(top: 10),
      width: screenWidth! * 0.9,
      height: screenHeight! * 0.12,
      decoration: BoxDecoration(
          color: MyStyle().secondColor,
          borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyPost()));
          },
          child: Text(
            'โพสต์ของฉัน',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenHeight! * 0.025),
          )),
    );
  }

  Container buildlogout() {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(top: 1, bottom: 20),
      width: screenWidth! * 0.6,
      height: screenHeight! * 0.1,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: () async {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("ออกจากระบบ"),
                    content: const Text("คุณต้องการออกจากระบบหรือไม่"),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await GoogleSignIn().signOut();
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Authen()),
                              (route) => false);
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  );
                });
          },
          child: Text(
            'ออกจากระบบ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenHeight! * 0.025),
          )),
    );
  }
}
