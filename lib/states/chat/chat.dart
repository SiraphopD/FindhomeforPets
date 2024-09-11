// import 'dart:ffi';
// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/chat_mode.dart';
import 'package:findhomeforpets/states/adopter/adopter_request.dart';
// import 'package:findhomeforpets/models/user_model.dart';
import 'package:findhomeforpets/states/chat/chat_screen.dart';
import 'package:findhomeforpets/states/home.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Widget> widgets = [];
  List<ChatModel> usermodels = [];
  late double screenWidth, screenHeight;
  String? uid;
  bool isRefresh = false;
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      icon: Icon(Icons.arrow_back_outlined)),
                  Text('แชท'),
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdopterRequest()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    width: 100,
                    height: 26,
                    decoration: BoxDecoration(
                        color: MyStyle().primaryColor,
                        borderRadius: BorderRadius.circular(5),
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
                          'คำขอรับเลี้ยง',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
          backgroundColor: MyStyle().primaryColor,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(uid)
                .collection('chatWith')
                .orderBy('lasttime', descending: true)
                .snapshots(),
            builder: ((context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  ChatModel user =
                      ChatModel.fromJson(snapshot.data!.docs[index]);

                  return InkWell(
                    autofocus: true,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Chat_Screen(uid: user.peerID),
                          ));
                    },
                    child: Card(
                      margin: EdgeInsets.only(
                        top: 10,
                        left: 15,
                        right: 15,
                      ),
                      color: MyStyle().secondColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: ListTile(
                        title: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: user.toPathImage == null
                                  ? NetworkImage(
                                      'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg')
                                  : NetworkImage(user.toPathImage),
                              radius: 25,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.toname),
                                user.type == 'image'
                                    ? Text('ส่งรูปภาพแล้ว')
                                    : Text(user.lastmessage)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            })));
  }

  Future<Null> showUser() async {
    await Firebase.initializeApp().then((value) async {
      uid = FirebaseAuth.instance.currentUser!.uid;
      print('$uid');
      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .collection('chatWith')
          .orderBy('lasttime', descending: true)
          .snapshots()
          .listen((event) {
        int index = 0;
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          ChatModel model = ChatModel.fromMap(map);
          usermodels.add(model);

          setState(() {
            widgets.add(createWidget(model, index));
          });
          index++;
        }
      });
    });
  }

  Widget createWidget(ChatModel model, int index) => GestureDetector(
        onTap: () async {
          print('Clicked from index = $index');
          String refresh = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chat_Screen(
                        uid: usermodels[index].peerID,
                      )));
          if (refresh == 'refresh') {
            setState(() {
              isRefresh = true;
            });
          }
        },
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundImage: model.toPathImage == null
                                ? NetworkImage(
                                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg')
                                : NetworkImage(model.toPathImage),
                            radius: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${model.toname}'),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('${model.lastmessage}'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      );
}
