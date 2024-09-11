import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/pet_model.dart';
import 'package:findhomeforpets/states/missingpet/missingpetDetail.dart';
// import 'package:findhomeforpets/states/chat/chat.dart';

import 'package:findhomeforpets/states/mypost/mypost1.dart';
import 'package:findhomeforpets/states/mypost/mypost2.dart';
import 'package:findhomeforpets/states/mypost/mypost3.dart';
// import 'package:findhomeforpets/states/profile.dart';
import 'package:findhomeforpets/states/setting.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

const activeColor = Color.fromARGB(255, 248, 176, 121);
const deActiveColor = Color.fromARGB(255, 250, 218, 189);

class MyPost extends StatefulWidget {
  const MyPost({super.key});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  List<Widget> widgets = [];
  List<PetModel> petmodels = [];
  double? screenWidth, screenHeight;
  List<String> items = ['โพสต์หาบ้าน', 'โพสต์สัตว์หาย', 'โพสต์ช่วยเหลือสัตว์'];
  int current = 0;

  void initState() {
    super.initState();
    readAdopterData();
  }

  late int currentIndex = 0;
  List widgetOptions = [
    Mypost1(),
    Mypost2(),
    Mypost3(),
  ];

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Setting()));
                  },
                  icon: Icon(Icons.arrow_back_outlined)),
              Text('โพสต์ของฉัน'),
            ],
          ),
          backgroundColor: MyStyle().primaryColor,
        ),
        body: Container(
          margin: EdgeInsets.all(5),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight! * 0.08,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                current = index;
                                // if (current == 0) {
                                //   readAdopterData();
                                // }
                                // if (current == 1) {
                                //   readMissingpetData();
                                // }
                                // if (current == 2) {
                                //   readHelppetData();
                                // }
                              });
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.all(5),
                              width: screenWidth! * 0.3,
                              height: screenHeight! * 0.06,
                              decoration: BoxDecoration(
                                color: current == index
                                    ? MyStyle().primaryColor
                                    : MyStyle().secondColor,
                                borderRadius: current == index
                                    ? BorderRadius.circular(25)
                                    : BorderRadius.circular(20),
                              ),
                              duration: Duration(milliseconds: 300),
                              child: Center(
                                child: Text(
                                  items[index],
                                  style: TextStyle(
                                      color: current == index
                                          ? Colors.black
                                          : const Color.fromARGB(
                                              255, 77, 76, 76)),
                                ),
                              ),
                            ),
                          ),
                          // Visibility(
                          //     visible: current == index,
                          //     child: Container(
                          //       width: 5,
                          //       height: 5,
                          //       decoration: BoxDecoration(
                          //           shape: BoxShape.circle,
                          //           color: MyStyle().primaryColor),
                          //     ))
                        ],
                      );
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: double.infinity,
                height: screenHeight! * 0.77,
                child: widgetOptions[currentIndex = current],
              )
            ],
          ),
        )
        // SafeArea(
        //     child: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Row(children: <Widget>[
        //         Expanded(
        //           child: GestureDetector(
        //             onTap: () {
        //               setState(() {
        //                 updateColor(1);

        //                 // readAdopterData();
        //               });
        //             },
        //             child: Container(
        //               margin: EdgeInsets.only(top: 10, left: 3),
        //               width: screenWidth! * 0.12,
        //               height: screenHeight! * 0.06,
        //               decoration: BoxDecoration(
        //                   color: adopter,
        //                   borderRadius: BorderRadius.circular(15)),
        //               child: Center(child: Text('ตามหาบ้าน')),
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           child: GestureDetector(
        //             onTap: () {
        //               setState(() {
        //                 updateColor(2);

        //                 // readMissingpetData();
        //               });
        //             },
        //             child: Container(
        //               margin: EdgeInsets.only(top: 10, left: 3),
        //               width: screenWidth! * 0.5,
        //               height: screenHeight! * 0.06,
        //               decoration: BoxDecoration(
        //                   color: missing,
        //                   borderRadius: BorderRadius.circular(15)),
        //               child: Center(child: Text('สัตว์หาย')),
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           child: GestureDetector(
        //             onTap: () {
        //               setState(() {
        //                 updateColor(3);
        //                 // readHelppetData();
        //               });
        //             },
        //             child: Container(
        //               margin: EdgeInsets.only(top: 10, left: 3, right: 3),
        //               width: screenWidth! * 0.09,
        //               height: screenHeight! * 0.06,
        //               decoration: BoxDecoration(
        //                   color: help, borderRadius: BorderRadius.circular(15)),
        //               child: Center(
        //                 child: Text('ช่วยเหลือสัตว์'),
        //               ),
        //             ),
        //           ),
        //         )
        //       ]),
        // widgets.length == 0
        //     ? Center(child: CircularProgressIndicator())
        //     : SingleChildScrollView(
        //         scrollDirection: Axis
        //             .horizontal, //กำหนดว่าจะเลื่อนขึ้นลงหรือเลื่อนซ้ายขวา
        //         padding: EdgeInsets.only(
        //           bottom: 5,
        //         ),
        //         child: Column(
        //           children: widgets,
        //         ),
        //       )
        //     ],
        //   ),
        // )),
        );
  }

  //ดึงข้อมูล
  Future<Null> readAdopterData() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('pets')
          .orderBy('petname')
          .snapshots()
          .listen((event) {
        // print('snapshot=${event.docs}');
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print('####map=$map');
          PetModel model = PetModel.fromMap(map);
          petmodels.add(model);
          print('Name = ${model.petname}');
          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

  //ดึงข้อมูล
  Future<Null> readMissingpetData() async {
    await Firebase.initializeApp().then((value) async {
      print('initialize Success');
      await FirebaseFirestore.instance
          .collection('missingpet')
          .orderBy('petname')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');
        int index = 0;
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          PetModel model = PetModel.fromMap(map);
          petmodels.add(model);
          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

  Future<Null> readHelppetData() async {
    await Firebase.initializeApp().then((value) async {
      print('initialize Success');
      await FirebaseFirestore.instance
          .collection('helppet')
          .orderBy('petname')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');
        int index = 0;
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          PetModel model = PetModel.fromMap(map);
          petmodels.add(model);

          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

  Widget createWidget(PetModel model, int index) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MissingpetDetail(
                        petModel: petmodels[index],
                      )));
        },
        child: Card(
          margin: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          color: MyStyle().secondColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: screenWidth! * 0.85,
                    height: screenHeight! * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(model.PathImage),
                          fit: BoxFit.cover,
                        )),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  width: screenWidth! * 0.85,
                  height: screenHeight! * 0.1,
                  decoration: BoxDecoration(
                      color: MyStyle().lightColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Divider(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            '${model.more_info}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
}
