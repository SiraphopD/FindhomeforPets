import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/pet_model.dart';
// import 'package:findhomeforpets/states/home.dart';
import 'package:findhomeforpets/states/missingpet/missingpetDetail.dart';
import 'package:findhomeforpets/states/missingpet/missingpet_all.dart';
import 'package:findhomeforpets/states/missingpet/missingpet_cat.dart';
import 'package:findhomeforpets/states/missingpet/missingpet_dog.dart';
import 'package:findhomeforpets/states/missingpet/missingpet_other.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Missingpet extends StatefulWidget {
  const Missingpet({super.key});

  @override
  State<Missingpet> createState() => _MissingpetState();
}

class _MissingpetState extends State<Missingpet> {
  double? screenWidth, screenHeight;
  List<String> items = ['ทั้งหมด', 'สุนัข', 'แมว', 'อื่นๆ'];
  int current = 0;
  List<Widget> widgets = [];
  List<PetModel> petmodels = [];
  String? myprovince;
  void initState() {
    super.initState();
    // readData();
  }

  late int currentIndex = 0;
  List widgetOptions = [
    MissingPet_all(),
    MissingPet_dog(),
    MissingPet_cat(),
    MissingPet_other(),
  ];

  // ดึงข้อมูล
  Future<Null> readData() async {
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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('ประกาศสัตว์เลี้ยงหาย'),
          backgroundColor: MyStyle().primaryColor,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () =>
                    Navigator.pushNamed(context, '/postmissingpet'))
          ],
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
                              margin: EdgeInsets.only(top: 10, right: 4),
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
                margin: const EdgeInsets.only(top: 1),
                width: double.infinity,
                height: screenHeight! * 0.79,
                child: widgetOptions[currentIndex = current],
              )
            ],
          ),
        ));
  }
}
