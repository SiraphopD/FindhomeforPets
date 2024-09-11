import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late double screenWidth, screenHeight;
  String? user;
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('ลืมรหัสผ่าน'),
        backgroundColor: MyStyle().primaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            buildtext(),
            buildEmail(),
            buildPassReset(),
          ],
        ),
      ),
    );
  }

  Container buildtext() {
    return Container(
      margin: EdgeInsets.only(top: 235),
      width: screenWidth * 0.9,
      child: Text('ลืมรหัสผ่าน', textAlign: TextAlign.center),
    );
  }

  Container buildEmail() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screenWidth * 0.9,
      child: TextField(
        controller: email,
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ),
          labelStyle: MyStyle().darkStyle(),
          labelText: 'อีเมล',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().primaryColor)),
        ),
      ),
    );
  }

  Container buildPassReset() {
    return Container(
      padding: EdgeInsets.all(2),
      // ignore: prefer_const_constructors
      margin: EdgeInsets.only(top: 10),
      width: screenWidth * 0.5,
      height: screenHeight * 0.07,
      decoration: BoxDecoration(
          color: MyStyle().primaryColor,
          borderRadius: BorderRadius.circular(29)),
      child: TextButton(
          onPressed: () {
            _Passwordreset();
          },
          child: Text(
            'Reset password',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenHeight * 0.019),
          )),
    );
  }

  Future _Passwordreset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      print('Password reset email sent');
    } catch (e) {}
  }
}
