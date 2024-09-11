import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/pet_model.dart';
import 'package:findhomeforpets/states/adopter/adopterDetail.dart';
import 'package:findhomeforpets/states/adopter/adopter_all.dart';
import 'package:findhomeforpets/states/adopter/adopter_cat.dart';
import 'package:findhomeforpets/states/adopter/adopter_dog.dart';
import 'package:findhomeforpets/states/adopter/adopter_filter.dart';
import 'package:findhomeforpets/states/adopter/adopter_other.dart';
import 'package:findhomeforpets/states/home.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Adopter extends StatefulWidget {
  const Adopter({super.key});

  @override
  State<Adopter> createState() => _AdopterState();
}

class _AdopterState extends State<Adopter> {
  // List<Widget> widgets = [];
  // List<PetModel> petmodels = [];
  List<Widget> widgets = [];
  List<PetModel> petmodels = [];
  double? screenWidth, screenHeight;
  List<String> items = ['ทั้งหมด', 'สุนัข', 'แมว', 'อื่นๆ'];
  int current = 0;

  String? myprovince;
  void initState() {
    super.initState();
    readData();
  }

  late int currentIndex = 0;
  List widgetOptions = [
    Adopterall(),
    Adopterdog(),
    Adoptercat(),
    Adopterother(),
  ];
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        // appBar: AppBar(
        // automaticallyImplyLeading: false,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       IconButton(
        //           onPressed: () {
        //             Navigator.pushReplacement(context,
        //                 MaterialPageRoute(builder: (context) => Home1()));
        //           },
        //           icon: Icon(Icons.arrow_back_outlined)),
        //       Text('โพสต์ของฉัน'),
        //     ],
        //   ),
        //   backgroundColor: MyStyle().primaryColor,
        // ),
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
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Home()));
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
                              size: screenHeight! * 0.02,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              ' $myprovince',
                              style: TextStyle(fontSize: screenHeight! * 0.02),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdopterFilter()));
                  },
                  icon: Icon(Icons.filter_list_outlined))
            ],
          ),
          backgroundColor: MyStyle().primaryColor,
        ),
        body: Container(
          margin: EdgeInsets.all(2),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight! * 0.075,
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
                        ],
                      );
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: double.infinity,
                height: screenHeight! * 0.782,
                child: widgetOptions[currentIndex = current],
              )
            ],
          ),
        ));
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
          // .where('province', isEqualTo: myprovince)
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
            margin: EdgeInsets.only(top: 30, right: 10, bottom: 30),
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
                      width: screenWidth! * 0.9,
                      height: screenHeight! * 0.5,
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
                    width: screenWidth! * 0.8,
                    height: screenHeight! * 0.25,
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
