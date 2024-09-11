import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/pet_model.dart';

import 'package:findhomeforpets/states/chat/chat_screen.dart';
import 'package:findhomeforpets/states/mypost/editmypost2.dart';

import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MissingpetDetail extends StatefulWidget {
  late final PetModel petModel;
  MissingpetDetail({Key? key, required this.petModel}) : super(key: key);

  @override
  State<MissingpetDetail> createState() => _MissingpetDetailState();
}

class _MissingpetDetailState extends State<MissingpetDetail> {
  String? displayName, gender, phonenumber, province, PathImage, age, vaccine;
  String currentUserId = "";
  late PetModel model;
  late double screenWidth, screenHeight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.petModel;
    showProfile();
  }

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
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5, right: 5, bottom: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('    '),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child:
                                            Text('   ชื่อ: ${model.petname}'),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child:
                                            Text('   เพศ: ${model.petgender}'),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('   สี: ${model.petcolor}'),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            '   สายพันธุ์: ${model.breed}'),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Icon(Icons.pin_drop),
                                            Text('${model.province}'),
                                          ],
                                        ),
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
                          // เช็คว่าuid เป็นของเรามั้ย ถ้าใช่ให้แสดงปุ่มแก้ไขโพสต์
                          model.uid != currentUserId
                              ? Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
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
                                                      Chat_Screen(
                                                        uid: model.uid,
                                                      )));
                                        },
                                        icon: Icon(
                                          Icons.chat_bubble_outline_rounded,
                                          color: Colors.white,
                                        ),
                                        label: Text('แชท',
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
                                                      Editmypost2(
                                                          petModel: model)));
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
}
