import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/adopter_model.dart';
import 'package:findhomeforpets/states/editprofile.dart';
import 'package:findhomeforpets/states/home.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Widget> widgets = [];
  List<AdopterModel> adoptpetmodels = [];
  String? displayName, uid, gender, phonenumber, province, introduce, PathImage;

  late double screenWidth, screenHeight;
  late Future<void> getshowProfile;
  @override
  void initState() {
    super.initState();
    getshowProfile = showProfile();
  }

  Future<void> showProfile() async {
    await Firebase.initializeApp().then((value) async {
      // .listen ถ้าloginจะมีข้อมูลถ้าไม่loginไม่มีข้อมูล
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        uid = event?.uid;
        final DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('user').doc(uid).get();

        setState(() {
          displayName = userDoc.get('name');
          phonenumber = userDoc.get('phonenum');
          gender = userDoc.get('gender');
          province = userDoc.get('province');
          introduce = userDoc.get('introduce');
          PathImage = userDoc.get('PathImage');
        });
        adoptpet();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: MyStyle().primaryColor,
            expandedHeight: screenHeight * 0.35,
            floating: false,
            pinned: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  showImage(),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [buildName()],
                  ),
                  Text('    '),
                ]),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                    Text('โปรไฟล์'),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()))
                          .then((value) {
                        setState(() {
                          getshowProfile = showProfile();
                        });
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 25,
                      decoration: BoxDecoration(
                          color: MyStyle().primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'แก้ไขโปรไฟล์',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(18),
                      margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                      width: screenWidth * 0.95,
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                          color: MyStyle().lightColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Text('แนะนำตัว'), buildIntroduce()],
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.08,
                    decoration: BoxDecoration(
                        color: MyStyle().lightColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Icon(Icons.phone), buildPhonenum()],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.08,
                    decoration: BoxDecoration(
                        color: MyStyle().lightColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Icon(Icons.attribution_sharp), buildGender()],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(
                        right: 20, left: 20, top: 20, bottom: 20),
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.08,
                    decoration: BoxDecoration(
                        color: MyStyle().lightColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.pin_drop_outlined),
                            Text("$province", style: TextStyle(fontSize: 17)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text('ประวัติการรับเลี้ยง'),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 20),
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                        color: MyStyle().lightColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: widgets.length == 0
                        ? Center(
                            child:
                                // CircularProgressIndicator(),
                                Text('ไม่มีสัตว์ที่รับเลี้ยง'))
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(bottom: 5, left: 15),
                            child: Row(
                              children: widgets,
                            ),
                          ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column buildaddress() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$province", style: TextStyle(fontSize: 17)),
          ],
        ),
      ],
    );
  }

  Row buildPhonenum() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$phonenumber',
          style: TextStyle(fontSize: 17),
        )
      ],
    );
  }

  Container buildIntroduce() {
    return Container(
      child: Column(
        children: [
          Text(
            '$introduce',
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }

  Row buildGender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$gender',
          style: TextStyle(fontSize: 17),
        )
      ],
    );
  }

  Row buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$displayName',
          style: TextStyle(fontSize: 17),
        )
      ],
    );
  }

  showImage() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          image: DecorationImage(
            image: PathImage == null
                ? NetworkImage(
                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg')
                : NetworkImage(PathImage!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

// ดึงข้อมูลสัตว์ที่รับเลี้ยง
  Future<Null> adoptpet() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        uid = event?.uid;
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .collection('adoption_history')
            .orderBy('petname')
            .snapshots()
            .listen((event) {
          // print('snapshot=${event.docs}');
          int index = 0;
          for (var snapshot in event.docs) {
            Map<String, dynamic> map = snapshot.data();
            print('map=$map');
            AdopterModel model = AdopterModel.fromMap(map);
            adoptpetmodels.add(model);
            print('Name = ${model.petname}');
            setState(() {
              widgets.add(createWidget(model, index));
            });
            index++;
          }
        });
      });
    });
  }

  Widget createWidget(AdopterModel matchModel, int index) => GestureDetector(
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
          ],
        ),
      ));
}
