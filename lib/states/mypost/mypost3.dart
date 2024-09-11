import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/pet_model.dart';
import 'package:findhomeforpets/states/missingpet/missingpetDetail.dart';

import 'package:findhomeforpets/states/mypost/editmypost3.dart';
import 'package:findhomeforpets/states/mypost/mypost.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Mypost3 extends StatefulWidget {
  const Mypost3({super.key});

  @override
  State<Mypost3> createState() => _Mypost1State();
}

class _Mypost1State extends State<Mypost3> {
  List<Widget> widgets = [];
  List<PetModel> petmodels = [];
  double? screenWidth, screenHeight;
  String currentUserId = "";
  void initState() {
    super.initState();
    readHelppetData();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: widgets.length == 0
          ? Center(child: Text('ไม่มีโพสต์'))
          : SingleChildScrollView(
              scrollDirection:
                  Axis.vertical, //กำหนดว่าจะเลื่อนขึ้นลงหรือเลื่อนซ้ายขวา
              padding: EdgeInsets.only(
                bottom: 5,
              ),
              child: Column(
                children: widgets,
              ),
            ),
    );
  }

//เรียกข้อมูลโพสต์สัตว์ขอความช่วยเหลือ
  Future<Null> readHelppetData() async {
    await Firebase.initializeApp().then((value) async {
      currentUserId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('helppet')
          .orderBy('uid')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');
        int index = 0;
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          PetModel model = PetModel.fromMap(map);
          if (model.uid == currentUserId) {
            petmodels.add(model);
            print('##########Name = ${model.petname}');
            setState(() {
              widgets.add(createWidget(model, index));
              print('#######$index');
            });
            index++;
          }
        }
      });
    });
  }

  deletepost(id) async {
    await FirebaseFirestore.instance
        .collection('helppet')
        .doc(id)
        .delete()
        .then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyPost()));
    });
  }

  Widget createWidget(PetModel model, int index) => Card(
        margin: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        color: MyStyle().secondColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              padding: EdgeInsets.all(20),
              width: screenWidth! * 0.3,
              height: screenHeight! * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(model.PathImage),
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      '${model.petname}',
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      width: screenWidth! * 0.5,
                      height: screenHeight! * 0.04,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MissingpetDetail(
                                          petModel: petmodels[index],
                                        )));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: MyStyle().darkColor,
                                size: 16,
                              ),
                              Text(
                                ' รายละเอียด',
                                style: TextStyle(color: MyStyle().darkColor),
                              )
                            ],
                          ))),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      width: screenWidth! * 0.5,
                      height: screenHeight! * 0.04,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Editmypost3(
                                          petModel: petmodels[index],
                                        )));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit_outlined,
                                color: MyStyle().darkColor,
                                size: 16,
                              ),
                              Text(
                                ' แก้ไขโพสต์',
                                style: TextStyle(color: MyStyle().darkColor),
                              )
                            ],
                          ))),
                  Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: screenWidth! * 0.5,
                      height: screenHeight! * 0.04,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 245, 83, 71),
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                          "คุณต้องการลบโพสต์นี้หรือไม่"),
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
                                          onPressed: () {
                                            deletepost(model.petID);
                                          },
                                          icon: const Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_outline_outlined,
                                color: MyStyle().darkColor,
                                size: 16,
                              ),
                              Text(
                                ' ลบโพสต์',
                                style: TextStyle(color: MyStyle().darkColor),
                              )
                            ],
                          )))
                ],
              ),
            ),
          ],
        ),
      );
}
