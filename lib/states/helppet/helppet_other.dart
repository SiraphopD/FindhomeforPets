import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/pet_model.dart';
import 'package:findhomeforpets/states/chat/chat.dart';
import 'package:findhomeforpets/states/helppet/helppetDetail.dart';

import 'package:findhomeforpets/states/home1.dart';
import 'package:findhomeforpets/states/profile.dart';
import 'package:findhomeforpets/states/setting.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HelpPet_other extends StatefulWidget {
  const HelpPet_other({super.key});

  @override
  State<HelpPet_other> createState() => _HelpPet_otherState();
}

class _HelpPet_otherState extends State<HelpPet_other> {
  String? userID,
      displayName,
      Surname,
      uid,
      gender,
      phonenumber,
      housenumber,
      street,
      district,
      subdistrict,
      province,
      PathImage,
      postcode;

  @override
  void initState() {
    super.initState();
    readData();
  }

  //ดึงข้อมูล
  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      print('initialize Success');
      await FirebaseFirestore.instance
          .collection('helppet')
          .where('pettype', isEqualTo: 'อื่นๆ')
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

  List<Widget> widgets = [];
  List<PetModel> petmodels = [];

  double? screenWidth, screenHeight;
  List widgetOptions = [Home1(), Chat(), Profile(), Setting()];
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ช่วยเหลือสัตว์'),
      //   backgroundColor: MyStyle().primaryColor,
      //   actions: <Widget>[
      //     IconButton(
      //         icon: Icon(Icons.add),
      //         onPressed: () => Navigator.pushNamed(context, '/posthelppet'))
      //   ],
      // ),
      body: widgets.length == 0
          ? Center(child: Text('ไม่พบสัตว์ชนิดนี้'))
          : SingleChildScrollView(
              scrollDirection:
                  Axis.vertical, //กำหนดว่าจะเลื่อนขึ้นลงหรือเลื่อนซ้ายขวา
              padding: EdgeInsets.only(bottom: 5),
              child: Center(
                child: Column(
                  children: widgets,
                ),
              ),
            ),
    );
  }

  Widget createWidget(PetModel model, int index) => GestureDetector(
        //ให้cardคลิกได้
        onTap: () {
          print('Clicked from index = $index');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HelppetDetail(
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
                        Text(
                          '${model.more_info}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
}
