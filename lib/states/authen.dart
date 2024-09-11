import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/utility/dialog.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authen extends StatefulWidget {
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? user, password;
  double? screenWidth, screenHeight;
  bool redEye = true;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyStyle().primaryColor,
      // floatingActionButton: BuildCreateAccount(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // MyStyle().buildBackground(screenWidth!, screenHeight!),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(18),
                          margin: EdgeInsets.only(
                              right: 20, left: 20, top: 50, bottom: 10),
                          // width: 360,
                          width: screenWidth! * 0.9,
                          height: screenHeight! * 0.55,
                          decoration: BoxDecoration(
                              color: MyStyle().secondColor,
                              borderRadius: BorderRadius.circular(29)),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                MyStyle().buildLogo(
                                    screenWidth! * 0.5, screenHeight! * 0.5),
                                buildUser(),
                                buildPassword(),
                                buildforgotpassword(),
                                buildLogin(),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // buildSigninFacebook(),
                              buildSigninGoogle(),
                            ],
                          ),
                        ),
                        Container(
                          child: SizedBox(
                            height: screenHeight! * 0.1,
                            child: BuildCreateAccount(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildforgotpassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 90,
        ),
        TextButton(
            onPressed: () => Navigator.pushNamed(context, '/forgotPassword'),
            child: Text('ลืมรหัสผ่านใช่ไหม',
                style: TextStyle(
                    color: MyStyle().darkColor,
                    fontSize: screenHeight! * 0.019)))
      ],
    );
  }

  Row BuildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 18,
        ),
        Text('ไม่มีบัญชีใช่หรือไม่?',
            style: TextStyle(
              color: MyStyle().darkColor,
              fontSize: screenHeight! * 0.019,
            )),
        TextButton(
            onPressed: () => Navigator.pushNamed(context, '/createAccount'),
            child: Text('สร้างบัญชีใหม่',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: screenHeight! * 0.019,
                  fontWeight: FontWeight.bold,
                )))
      ],
    );
  }

  Container buildSigninFacebook() => Container(
        margin: EdgeInsets.only(top: 10),
        width: screenWidth! * 0.8,
        height: screenHeight! * 0.07,
        child: SignInButton(
          Buttons.Facebook,
          onPressed: () {
            //FBsignin();
            GoogleSignIn().signOut();
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
        ),
      );
  void FBsignin() async {
    Navigator.pushNamedAndRemoveUntil(
        context, '/createGoogleAcc', (route) => false);
  }

  Container buildSigninGoogle() => Container(
        margin: EdgeInsets.only(top: 10),
        width: screenWidth! * 0.8,
        height: screenHeight! * 0.07,
        child: SignInButton(
          Buttons.Google,
          onPressed: () {
            googlesignin();
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
        ),
      );

  Future<Null> googlesignin() async {
    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ];
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: scopes,
    );
    await Firebase.initializeApp().then((value) async {
      await _googleSignIn.signIn().then((value) async {
        String? name = value!.displayName; //check
        String email = value.email; //check
        await value.authentication.then((value2) async {
          AuthCredential authCredential = GoogleAuthProvider.credential(
              idToken: value2.idToken, accessToken: value2.accessToken);
          await FirebaseAuth.instance
              .signInWithCredential(authCredential)
              .then((value3) {
            String? uidGoogle = value3.user!.uid;
            print('Login with gmail $email name is $name uid: $uidGoogle');
            checkFirebaseData();
          });
        });
      });
    });
  }

  void checkFirebaseData() async {
    // Check if user is signed in
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('Firebase UID: ${user.uid}');
      // Check Auth and Firestore uid
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();
      if (userDoc.exists && user.uid == userDoc.id) {
        print('UID matches in Firestore: ${user.uid}');
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        print('x');
        await GoogleSignIn().signOut();
        FirebaseAuth.instance.signOut();
        popup();
      }
    } else {
      print('User is not signed in');
    }
  }

  void popup() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(
                        context,
                        '/createGoogleAcc',
                      );
                    },
                    child: const Text('ดำเนินการต่อ')),
              ],
              title: const Text('ยังไม่ได้ลงทะเบียน'),
              contentPadding: const EdgeInsets.all(20),
              content: const Text('กรุณาคลิกดำเนินการต่อเพื่อลงทะเบียน'),
            ));
  }
  /*
 showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close')),
                      ],
                      title: const Text('Test'),
                      contentPadding: const EdgeInsets.all(20),
                      content: const Text('This isit'),
                    ));
                    */

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screenWidth! * 0.9,
      height: screenHeight! * 0.099,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
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
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      padding: EdgeInsets.all(2),
      // ignore: prefer_const_constructors
      margin: EdgeInsets.only(top: 0.5),
      width: screenWidth! * 0.9,
      height: screenHeight! * 0.07,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(29)),
      child: TextButton(
          onPressed: () {
            if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
              normailDialog(context, 'คำเตือน', 'มีช่องว่างกรุณากรอกให้ครบ');
            } else {
              checkAuthen();
            }
          },
          child: Text(
            'Login',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenHeight! * 0.019),
          )),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screenWidth! * 0.9,
      height: screenHeight! * 0.099,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: redEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              redEye
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye_sharp,
              color: MyStyle().darkColor,
            ),
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
          ),
          prefixIcon: Icon(
            Icons.lock_outlined,
            color: MyStyle().darkColor,
          ),
          labelStyle: MyStyle().darkStyle(),
          labelText: 'รหัสผ่าน',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user!, password: password!)
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, '/home', (route) => false))
          .catchError(
              (value) => normailDialog(context, value.code, value.message));
    });
  }
}
