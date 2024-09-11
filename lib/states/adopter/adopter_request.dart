import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/api/access_firebase_token.dart';
import 'package:findhomeforpets/models/request_model.dart';
import 'package:findhomeforpets/states/chat/chat.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AdopterRequest extends StatefulWidget {
  const AdopterRequest({super.key});

  @override
  State<AdopterRequest> createState() => _AdopterRequestState();
}

class _AdopterRequestState extends State<AdopterRequest> {
  late double screenWidth, screenHeight;
  RequestModel? model;
  String? uid;
  List<Widget> widgets = [];
  List<RequestModel> usermodels = [];
  bool isRefresh = false;
  String? newstatus = 'อนุมัติ';
  late Future<Null> getshowUser;
  @override
  void initState() {
    super.initState();
    getshowUser = showUser();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Chat()));
                  },
                  icon: Icon(Icons.arrow_back_outlined)),
              Text('คำขอรับเลี้ยง'),
            ],
          ),
        ]),
        backgroundColor: MyStyle().primaryColor,
      ),
      body: widgets.length == 0
          ? Center(
              child: Text('ไม่มีคำขอ'),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widgets,
              ),
            ),
    );
  }

  Future<Null> showUser() async {
    await Firebase.initializeApp().then((value) async {
      uid = FirebaseAuth.instance.currentUser!.uid;
      print('$uid');
      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .collection('request')
          .snapshots()
          .listen((event) {
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          RequestModel model = RequestModel.fromMap(map);
          usermodels.add(model);

          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

//  ลบคำขอ
  deletepost(id) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('request')
        .doc(id)
        .delete()
        .then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdopterRequest()));
    });
  }

  deletepost2(
    id,
    adopterID,
    petID,
    petImage,
    petname,
  ) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('request')
        .doc(id)
        .delete()
        .then((value) {});
    await FirebaseFirestore.instance
        .collection('user')
        .doc(adopterID)
        .collection('matchpet')
        .doc(petID)
        .update({'status': newstatus}).then((value) {
      print('#########UPDATE SUCCESS ');
    });
    await Firebase.initializeApp().then((value) async {
      Map<String, dynamic> map = Map();
      map['Image'] = petImage;
      map['petname'] = petname;

      await FirebaseFirestore.instance
          .collection('user')
          .doc(adopterID)
          .collection('adoption_history')
          .doc(petID)
          .set(map);
    });
    await FirebaseFirestore.instance
        .collection('pets')
        .doc(petID)
        .delete()
        .then((value) {});
    sendPushNotification(adopterID);
    deleteotherrequest(petID);
  }

  Future<void> sendPushNotification(adopterID) async {
    await Firebase.initializeApp().then((value) async {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(adopterID)
          .get();
      String pushToken = userDoc.get('pushToken');

      DocumentSnapshot userDoc2 =
          await FirebaseFirestore.instance.collection('user').doc(uid).get();
      String name = userDoc2.get('name');

      AccessFirebaseToken accessToken = AccessFirebaseToken();
      String bearerToken = await accessToken.getAccessToken();

      final body = {
        "message": {
          "token": pushToken.toString(),
          "notification": {
            "title": name,
            "body": '$name ได้อนุมัติให้คุณรับเลี้ยงแล้ว'
          },
        }
      };
      try {
        var res = await post(
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/findhomeforpets/messages:send'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $bearerToken'
          },
          body: jsonEncode(body),
        );
        print("Response statusCode: ${res.statusCode}");
        print("Response body: ${res.body}");
      } catch (e) {
        print("\nsendPushNotification: $e");
      }
    });
  }

//ลบคำขอที่เหลือ หลังจากกดอนุมัติแล้ว
  deleteotherrequest(petID) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    return FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('request')
        .where('petID', isEqualTo: petID)
        .get()
        .then((QuerySnapshot) {
      QuerySnapshot.docs.forEach((document) {
        batch.delete(document.reference);
        print('######delete####');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AdopterRequest()));
      });
      return batch.commit();
    });
  }
  // // อัปเดตstatus ในmatchpet
  // Future<void> updateMatchpet() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(model.adopterID)
  //       .collection('matchpet')
  //       .doc(model.petID)
  //       .update({'status': 'อนุมัติ'}).then((value) {
  //     print('#########UPDATE SUCCESS ');
  //     pushAdoptionHistory();
  //   });
  // }

  // // เพิ่มในประวัติการรับเลี้ยง
  // Future<void> pushAdoptionHistory() async {
  //   await Firebase.initializeApp().then((value) async {
  //     // currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //     Map<String, dynamic> map = Map();
  //     map['Image'] = model.petImage;
  //     map['status'] = model.petname;

  //     await FirebaseFirestore.instance
  //         .collection('user')
  //         .doc(model.adopterID)
  //         .collection('adoption_history')
  //         .doc(model.petID)
  //         .set(map);
  //     deletepet(model.petID);
  //   });
  // }

  // // ลบโพสต์หาบ้าน
  // deletepet(id) async {
  //   await FirebaseFirestore.instance
  //       .collection('pets')
  //       .doc(id)
  //       .delete()
  //       .then((value) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => AdopterRequest()));
  //   });
  // }

  Widget createWidget(RequestModel model, int index) => GestureDetector(
        onTap: () async {},
        child: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Card(
                margin: EdgeInsets.only(
                  top: 10,
                  left: 15,
                  right: 10,
                ),
                color: MyStyle().secondColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundImage: model.petImage == null
                                ? NetworkImage(
                                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg')
                                : NetworkImage(model.petImage),
                            radius: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text('${model.name}'),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('ต้องการรับเลี้ยง: ${model.petname}'),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('คุณต้องการอนุมัติหรือไม่'),
                                SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text(
                                                      "คุณต้องการลบคำขอนี้หรือไม่"),
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
                                                        deletepost(
                                                            model.requestID);
                                                      },
                                                      icon: const Icon(
                                                        Icons.done,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5),
                                        width: screenWidth * 0.2,
                                        height: screenHeight * 0.04,
                                        color: Colors.red,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text('ไม่อนุมัติ'),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text(
                                                      "คุณต้องการอนุมัติคำขอนี้หรือไม่"),
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
                                                        deletepost2(
                                                            model.requestID,
                                                            model.adopterID,
                                                            model.petID,
                                                            model.petImage,
                                                            model.petname);
                                                      },
                                                      icon: const Icon(
                                                        Icons.done,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(top: 5, left: 5),
                                        width: screenWidth * 0.2,
                                        height: screenHeight * 0.04,
                                        color: Colors.green,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text('อนุมัติ'),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      );
  // // อัปเดตstatus ในmatchpet
  // Future<void> updateMatchpet(adopterID, petID) async {
  //   await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(adopterID)
  //       .collection('matchpet')
  //       .doc(petID)
  //       .update({'status': newstatus}).then((value) {
  //     print('#########UPDATE SUCCESS ');
  //     // pushAdoptionHistory();
  //   });
  // }

  // // เพิ่มในประวัติการรับเลี้ยง
  // Future<void> pushAdoptionHistory(petImage, petname, petID) async {
  //   await Firebase.initializeApp().then((value) async {
  //     // currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //     Map<String, dynamic> map = Map();
  //     map['Image'] = petImage;
  //     map['status'] = petname;

  //     await FirebaseFirestore.instance
  //         .collection('user')
  //         .doc(model?.adopterID)
  //         .collection('adoption_history')
  //         .doc(model?.petID)
  //         .set(map);
  //     // deletepet(petID);
  //   });
  // }

  // // ลบโพสต์หาบ้าน
  // deletepet(id) async {
  //   await FirebaseFirestore.instance
  //       .collection('pets')
  //       .doc(id)
  //       .delete()
  //       .then((value) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => AdopterRequest()));
  //   });
  // }
}
