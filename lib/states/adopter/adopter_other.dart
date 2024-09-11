// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/pet_model.dart';
import 'package:findhomeforpets/states/adopter/adopterDetail.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
// import 'package:findhomeforpets/widgets/pet_item.dart';

import 'package:flutter/material.dart';

class Adopterother extends StatefulWidget {
  const Adopterother({super.key});

  @override
  State<Adopterother> createState() => _AdoptercatState();
}

class _AdoptercatState extends State<Adopterother> {
  List<Widget> widgets = [];
  List<PetModel> petmodels = [];
  @override
  void initState() {
    super.initState();
    readData();
  }

  String? myprovince;
  late double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               Text('รับเลี้ยง'),
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               Icon(
      //                 Icons.pin_drop_rounded,
      //                 size: screenHeight * 0.02,
      //               ),
      //               SizedBox(
      //                 height: 5,
      //               ),
      //               Text(
      //                 ' $myprovince',
      //                 style: TextStyle(fontSize: screenHeight * 0.02),
      //               )
      //             ],
      //           )
      //         ],
      //       ),
      //       IconButton(
      //           onPressed: () {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => AdopterFilter()));
      //           },
      //           icon: Icon(Icons.filter_list_outlined))
      //     ],
      //   ),
      //   backgroundColor: MyStyle().primaryColor,
      // ),
      body: widgets.length == 0
          ? Center(child: Text('ไม่มีสัตว์ชนิดนี้'))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(bottom: 5, left: 15),
              child: Row(
                children: widgets,
              ),
            ),
    );
  }

  //ดึงข้อมูล
  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUserId)
          .get();

      setState(() {
        myprovince = userDoc.get('province');
      });
      await FirebaseFirestore.instance
          .collection('pets')
          .where('pettype', isEqualTo: 'อื่นๆ')
          // .where('pettype', isNotEqualTo: 'สุนัข')
          .orderBy('petname')
          .snapshots()
          .listen((event) {
        // print('snapshot=${event.docs}');
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print('map=$map');
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

  Widget createWidget(PetModel model, int index) => GestureDetector(
        onTap: () {
          print('Clicked from index = $index');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => adopterDetail(
                        petModel: petmodels[index],
                      )));
        },
        child: Container(
          child: Card(
            margin: EdgeInsets.only(top: 1, right: 10, bottom: 15),
            color: MyStyle().secondColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.42,
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
                    margin: EdgeInsets.only(top: 20),
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.26,
                    decoration: BoxDecoration(
                        color: MyStyle().lightColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 126, 126, 126)
                                .withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('   ชื่อ :${model.petname}'),
                          ],
                        ),
                        const Divider(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('   อายุ :${model.age}'),
                          ],
                        ),
                        const Divider(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('   เพศ :${model.petgender}'),
                          ],
                        ),
                        const Divider(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('   สี :${model.petcolor}'),
                          ],
                        ),
                        const Divider(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text('   จังหวัด :${model.province}'),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      );
}
