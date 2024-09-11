import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/match_model.dart';
import 'package:findhomeforpets/models/pet_model.dart';
import 'package:findhomeforpets/states/PetIdentifier.dart';
import 'package:findhomeforpets/states/adopter/adopter.dart';
import 'package:findhomeforpets/states/findhome.dart';
import 'package:findhomeforpets/states/helppet/helppet.dart';
import 'package:findhomeforpets/states/missingpet/missingpet.dart';
import 'package:findhomeforpets/states/missingpet/missingpetDetail.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  String currentUserId = "";
  List<Widget> widgets = [];
  List<Widget> widgets2 = [];
  List<PetModel> petmodels = [];
  List<MatchModel> matchpetmodels = [];
  late double screenWidth, screenHeight;
  @override
  void initState() {
    super.initState();
    readData();
    // matchpet();
  }

  init() async {
    String deviceToken = await getDeviceToken();
    print('############PRINT DEVICE TOKEN');
    print(deviceToken);
    print('###############################');
    FirebaseMessaging.instance.onTokenRefresh
        .listen((deviceToken) {})
        .onError((err) {
      // Error getting token.
    });
    await Firebase.initializeApp().then((value) async {
      // .listen ถ้าloginจะมีข้อมูลถ้าไม่loginไม่มีข้อมูล
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      Map<String, dynamic> map = Map();
      map['pushToken'] = deviceToken;
      await FirebaseFirestore.instance.collection('user').doc(uid).update(map);
    });
    matchpet();
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
            automaticallyImplyLeading: false,
            backgroundColor: MyStyle().primaryColor,
            expandedHeight: 250,
            floating: false,
            pinned: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: widgets.length == 0
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(bottom: 5, left: 15),
                        child: Row(
                          children: widgets,
                        ),
                      ),
              ),
            ),
            title: Text('หน้าหลัก'),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Adopter()));
                      },
                      child: Card(
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 10,
                          right: 10,
                          bottom: 5,
                        ),
                        color: MyStyle().lightColor,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        shadowColor: MyStyle().primaryColor,
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 1),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                width: screenWidth * 0.26,
                                height: screenHeight * 0.13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: AssetImage('images/adopter.png'),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'รับเลี้ยง',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenHeight * 0.015),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Findhome()));
                      },
                      child: Card(
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 10,
                          right: 10,
                          bottom: 5,
                        ),
                        color: MyStyle().lightColor,
                        // clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        shadowColor: MyStyle().primaryColor,
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 1),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/findhome .png'),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'ตามหาบ้าน',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenHeight * 0.015),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Missingpet()));
                      },
                      child: Card(
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        color: MyStyle().lightColor,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        shadowColor: MyStyle().primaryColor,
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 1),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                width: screenWidth * 0.24,
                                height: screenHeight * 0.11,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image:
                                          AssetImage('images/missingpet.png'),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'ประกาศสัตว์เลี้ยงหาย',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenHeight * 0.015),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Helppet()));
                      },
                      child: Card(
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        color: MyStyle().lightColor,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        shadowColor: MyStyle().primaryColor,
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(top: 1),
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                width: screenWidth * 0.24,
                                height: screenHeight * 0.11,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: AssetImage('images/helppet.png'),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'ช่วยเหลือสัตว์',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenHeight * 0.015),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PetIdentifier()));
                      },
                      child: Card(
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 5,
                          right: 5,
                          bottom: 30,
                        ),
                        color: Colors.white,
                        // clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        shadowColor: MyStyle().primaryColor,
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(top: 1),
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(50),
                                width: screenWidth * 0.19,
                                height: screenHeight * 0.08,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: AssetImage('images/dog.png'),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  ' ค้นหาสายพันธุ์สุนัขอัตโนมัติ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenHeight * 0.015),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //สัตว์ที่กดmatch
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.only(top: 10),
                ),
                Text(
                  'สัตว์ที่กด Match',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(bottom: 30),
                    width: 320,
                    height: 150,
                    decoration: BoxDecoration(
                        color: MyStyle().secondColor,
                        borderRadius: BorderRadius.circular(29)),
                    child: widgets2.length == 0
                        ? Center(
                            child:
                                // CircularProgressIndicator(),
                                Text('ไม่มีสัตว์ที่กด Match'))
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(bottom: 5, left: 15),
                            child: Row(
                              children: widgets2,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }

  //ดึงข้อมูล
  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('missingpet')
          .orderBy('petname')
          .snapshots()
          .listen((event) {
        // print('snapshot=${event.docs}');
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          // print('map=$map');
          PetModel model = PetModel.fromMap(map);
          petmodels.add(model);
          // print('Name = ${model.petname}');
          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
        init();
      });
    });
  }

  // ดึงข้อมูลสัตว์ที่กด match
  Future<Null> matchpet() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUserId)
          .collection('matchpet')
          .orderBy('petname')
          .snapshots()
          .listen((event) {
        // print('snapshot=${event.docs}');
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          // print('map=$map');
          MatchModel mmodel = MatchModel.fromMap(map);
          matchpetmodels.add(mmodel);
          // print('Name = ${mmodel.petname}');
          setState(() {
            widgets2.add(createWidget2(mmodel, index));
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
                  builder: (context) => MissingpetDetail(
                        petModel: petmodels[index],
                      )));
        },
        child: Card(
          margin: EdgeInsets.only(
            top: screenHeight * 0.107,
            right: 10,
            bottom: screenHeight * 0.02,
          ),
          color: MyStyle().secondColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.214,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(model.PathImage),
                      fit: BoxFit.cover,
                    )),
                child: Card(
                  margin: EdgeInsets.only(
                    top: 98,
                  ),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          'สัตว์เลี้ยงหาย',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ชื่อ: ${model.petname}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text('สายพันธุ์ : ${model.breed}',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'เพศ: ${model.petgender}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text('สี : ${model.petcolor}',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            )
                          ],
                        )
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Text(
                        //       'ชื่อ: ${model.petname}',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     Text(
                        //       'เพศ: ${model.petgender}',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Text('สายพันธุ์ : ${model.breed}',
                        //         style: TextStyle(color: Colors.white)),
                        //     Text('สี : ${model.petcolor}',
                        //         style: TextStyle(color: Colors.white)),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget createWidget2(MatchModel matchModel, int index) => GestureDetector(
      onTap: () {
        print('Clicked from index = $index');
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => MissingpetDetail(
        //               petModel: petmodels[index],
        //             )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              // ignore: unnecessary_null_comparison
              backgroundImage: matchModel.Image == null
                  ? NetworkImage(
                      'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg')
                  : NetworkImage(matchModel.Image),
              radius: 30,
            ),
            Text(matchModel.petname),
            Container(
              margin: EdgeInsets.only(top: 5),
              width: screenWidth * 0.21,
              height: screenHeight * 0.025,
              decoration: BoxDecoration(
                  color: matchModel.status == 'กำลังเจรจา'
                      ? Colors.yellow
                      : Colors.green,
                  borderRadius: BorderRadius.circular(29)),
              child: Align(
                alignment: Alignment.center,
                child: Text(matchModel.status),
              ),
            )
          ],
        ),
      ));

//เอา deviceToken ใช้สำหรับแจ้งเตือน
  Future getDeviceToken() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    // await _firebaseMessaging.requestPermission();
    String? deviceToken = await _firebaseMessaging.getToken();
    return (deviceToken == null) ? "" : deviceToken;
  }
}
