import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/api/access_firebase_token.dart';
import 'package:findhomeforpets/models/pet_model.dart';
import 'package:findhomeforpets/states/chat/chat.dart';
import 'package:findhomeforpets/states/chat/chat_screen.dart';
import 'package:findhomeforpets/states/home1.dart';
import 'package:findhomeforpets/states/mypost/mypost.dart';
import 'package:findhomeforpets/states/profile.dart';
import 'package:findhomeforpets/states/setting.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class adopterDetail extends StatefulWidget {
  final PetModel petModel;

  const adopterDetail({Key? key, required this.petModel}) : super(key: key);

  @override
  State<adopterDetail> createState() => _adopterDetailState();
}

class _adopterDetailState extends State<adopterDetail> {
  String? displayName,
      gender,
      phonenumber,
      province,
      PathImage,
      age,
      petID,
      friendID,
      status,
      vaccine,
      mydisplayName,
      myPathImage;

  String currentUserId = "";
  late PetModel model;
  late double screenWidth, screenHeight;
  List widgetOptions = [Home1(), Chat(), Profile(), Setting()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.petModel;
    showProfile();
  }

//เอาuid ไปเรียกข้อมูลเจ้าของโพสต์
  Future<void> showProfile() async {
    await Firebase.initializeApp().then((value) async {
      String uid = model.uid;
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('user').doc(uid).get();
      setState(() {
        displayName = userDoc.get('name');
        phonenumber = userDoc.get('phonenum');
        gender = userDoc.get('gender');

        province = userDoc.get('province');

        PathImage = userDoc.get('PathImage');
      });
    });
  }

  Future<void> pushMatchpet() async {
    await Firebase.initializeApp().then((value) async {
      // currentUserId = FirebaseAuth.instance.currentUser!.uid;
      Map<String, dynamic> map = Map();
      map['petID'] = model.petID;
      map['Image'] = model.PathImage;
      map['status'] = status = 'กำลังเจรจา';
      map['petname'] = model.petname;

      await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUserId)
          .collection('matchpet')
          .doc(model.petID)
          .set(map);
      pushRequest();
    });
  }

  Future<void> pushRequest() async {
    await Firebase.initializeApp().then((value) async {
      // currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUserId)
          .get();

      setState(() {
        mydisplayName = userDoc.get('name');
        myPathImage = userDoc.get('PathImage');
      });
      Map<String, dynamic> map = Map();

      String requestID = '$currentUserId-${model.petID}';
      map['Image'] = myPathImage;
      map['name'] = mydisplayName;
      map['petname'] = model.petname;
      map['petID'] = model.petID;
      map['petImage'] = model.PathImage;
      map['requestID'] = requestID;
      map['adopterID'] = currentUserId;

      await FirebaseFirestore.instance
          .collection('user')
          .doc(model.uid)
          .collection('request')
          .doc(requestID)
          .set(map);
    });
  }

  Future<void> sendPushNotification() async {
    await Firebase.initializeApp().then((value) async {
      String uid = model.uid;

      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('user').doc(uid).get();
      String pushToken = userDoc.get('pushToken');

      DocumentSnapshot userDoc2 = await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUserId)
          .get();
      String name = userDoc2.get('name');
      AccessFirebaseToken accessToken = AccessFirebaseToken();
      String bearerToken = await accessToken.getAccessToken();

      final body = {
        "message": {
          "token": pushToken.toString(),
          "notification": {
            "title": name,
            "body": '$name ต้องการรับเลี้ยงสัตว์ของคุณ'
          },
        }
      };
      try {
        var res = await post(
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/findhomeforpets/messages:send'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $bearerToken'
          },
          body: jsonEncode(body),
        );
        print("Response statusCode: ${res.statusCode}");
        print("Response body: ${res.body}");
      } catch (e) {
        print("\nsendPushNotification: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: MyStyle().primaryColor,
            expandedHeight: screenHeight * 0.35,
            floating: false,
            pinned: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Container(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(model.PathImage),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('รายละเอียด'),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 5, bottom: 10),
                              width: screenWidth * 0.95,
                              height: screenHeight * 0.31,
                              decoration: BoxDecoration(
                                  color: MyStyle().lightColor,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 152, 152, 152),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(0, 3),
                                    )
                                  ]),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('    '),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('   ชื่อ: ${model.petname}'),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('   อายุ: ${model.age}'),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('   เพศ: ${model.petgender}'),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('   สี: ${model.petcolor}'),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child:
                                          Text('   สายพันธุ์: ${model.breed}'),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          '   ประวัติการฉีดวัคซีน: ${model.vaccine}'),
                                    ),
                                    Text('    '),
                                    Text('รายละเอียดเพิ่มเติม'),
                                    const Divider(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text('${model.more_info}')),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  width: screenWidth * 0.9,
                                  height: screenHeight * 0.05,
                                  decoration: BoxDecoration(
                                      color: MyStyle().primaryColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.09,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.09,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              image: DecorationImage(
                                                image: PathImage == null
                                                    ? NetworkImage(
                                                        'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg')
                                                    : NetworkImage(PathImage!),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ),
                                      Text('      '),
                                      Text('${displayName}'),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.9,
                                  height: screenHeight * 0.05,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 230, 227, 227),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.phone),
                                      Text('             '),
                                      Text('${phonenumber}'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          model.uid != currentUserId
                              ? Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(180)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {
                                          pushMatchpet();
                                          sendPushNotification();
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Chat_Screen(uid: model.uid);
                                          }));
                                        },
                                        icon: Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,
                                        ),
                                        label: Text('Match',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[300],
                                      borderRadius: BorderRadius.circular(180)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyPost()));
                                        },
                                        icon: Icon(
                                          Icons.mode_edit_outlined,
                                          color: Colors.white,
                                        ),
                                        label: Text('แก้ไขโพสต์',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      )
                                    ],
                                  ),
                                )
                        ],
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Future<void> uploadInformationToChat() async {
  //   await FirebaseAuth.instance.authStateChanges().listen((event) {
  //     String? myuid = event!.uid;
  //     Map<String, dynamic> map = Map();
  //     map['fromPathImage'] =
  //   });
  // }
}
