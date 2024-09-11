import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/pet_model.dart';
import 'package:findhomeforpets/states/adopter/adopterDetail.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Adopter2 extends StatefulWidget {
  final String pettypeitem;
  final String petgenderitem;
  final String provinceitem;
  final String breeditem;
  const Adopter2(
      {Key? key,
      required this.pettypeitem,
      required this.petgenderitem,
      required this.provinceitem,
      required this.breeditem})
      : super(key: key);
  @override
  State<Adopter2> createState() => _AdopterState();
}

class _AdopterState extends State<Adopter2> {
  List<Widget> widgets = [];
  List<PetModel> petmodels = [];
  String? pettypeitem, petgenderitem, provinceitem, breeditem;
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_outlined)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('รับเลี้ยง'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.pin_drop_rounded,
                            size: screenHeight * 0.02,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            ' $myprovince',
                            style: TextStyle(fontSize: screenHeight * 0.02),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.filter_list_outlined))
          ],
        ),
        backgroundColor: MyStyle().primaryColor,
      ),
      body: widgets.length == 0
          ? Center(child: Text('ไม่พบสัตว์ที่คุณค้นหา'))
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
      pettypeitem = widget.pettypeitem;
      petgenderitem = widget.petgenderitem;
      provinceitem = widget.provinceitem;
      breeditem = widget.breeditem;

      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUserId)
          .get();

      setState(() {
        myprovince = userDoc.get('province');
      });
      pettypeitem != 'อื่นๆ'
          ? petgenderitem == 'ทั้งหมด' &&
                  provinceitem == 'ทั้งหมด' &&
                  breeditem == 'อื่นๆ'
              ? await FirebaseFirestore.instance
                  .collection('pets')
                  .where('pettype', isEqualTo: pettypeitem)
                  .where('breed', isEqualTo: breeditem)
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
                })
              : petgenderitem == 'ทั้งหมด' && provinceitem == 'ทั้งหมด'
                  ? await FirebaseFirestore.instance
                      .collection('pets')
                      .where('pettype', isEqualTo: pettypeitem)
                      .where('breed', isEqualTo: breeditem)
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
                    })
                  : provinceitem == 'ทั้งหมด'
                      ? await FirebaseFirestore.instance
                          .collection('pets')
                          .where('pettype', isEqualTo: pettypeitem)
                          .where('petgender', isEqualTo: petgenderitem)
                          .where('breed', isEqualTo: breeditem)
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
                        })
                      : petgenderitem == 'ทั้งหมด'
                          ? await FirebaseFirestore.instance
                              .collection('pets')
                              .where('pettype', isEqualTo: pettypeitem)
                              .where('breed', isEqualTo: breeditem)
                              .where('province', isEqualTo: provinceitem)
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
                            })
                          : breeditem == 'อื่นๆ'
                              ? await FirebaseFirestore.instance
                                  .collection('pets')
                                  .where('pettype', isEqualTo: pettypeitem)
                                  .where('breed', isEqualTo: breeditem)
                                  .where('province', isEqualTo: provinceitem)
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
                                })
                              : await FirebaseFirestore.instance
                                  .collection('pets')
                                  .where('pettype', isEqualTo: pettypeitem)
                                  .where('petgender', isEqualTo: petgenderitem)
                                  .where('breed', isEqualTo: breeditem)
                                  .where('province', isEqualTo: provinceitem)
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
                                })
          : petgenderitem == 'ทั้งหมด' &&
                  provinceitem == 'ทั้งหมด' &&
                  breeditem == 'อื่นๆ'
              ? await FirebaseFirestore.instance
                  .collection('pets')
                  .where('pettype', isEqualTo: pettypeitem)
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
                })
              : provinceitem == 'ทั้งหมด'
                  ? await FirebaseFirestore.instance
                      .collection('pets')
                      .where('pettype', isEqualTo: pettypeitem)
                      .where('petgender', isEqualTo: petgenderitem)
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
                    })
                  : petgenderitem == 'ทั้งหมด'
                      ? await FirebaseFirestore.instance
                          .collection('pets')
                          .where('pettype', isEqualTo: pettypeitem)
                          .where('province', isEqualTo: provinceitem)
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
                        })
                      : breeditem == 'อื่นๆ'
                          ? await FirebaseFirestore.instance
                              .collection('pets')
                              .where('pettype', isEqualTo: pettypeitem)
                              .where('breed', isEqualTo: breeditem)
                              .where('province', isEqualTo: provinceitem)
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
                            })
                          : await FirebaseFirestore.instance
                              .collection('pets')
                              .where('pettype', isEqualTo: pettypeitem)
                              .where('petgender', isEqualTo: petgenderitem)
                              .where('province', isEqualTo: provinceitem)
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
            margin: EdgeInsets.only(top: 20, right: 10, bottom: 30),
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
                      height: screenHeight * 0.5,
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
                    margin: EdgeInsets.only(top: 10),
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.259,
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
                      children: [
                        const Divider(
                          height: 20,
                        ),
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
