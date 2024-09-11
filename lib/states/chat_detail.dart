// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:findhomeforpets/models/message.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:findhomeforpets/states/chat.dart';
// import 'package:findhomeforpets/utility/my_style.dart';

// // ignore: must_be_immutable
// class ChatDetail extends StatefulWidget {
//   String? petID;
//   String? friendUID;
//   ChatDetail({
//     Key? key,
//     required this.petID,
//     required this.friendUID,
//   }) : super(key: key);

//   @override
//   State<ChatDetail> createState() => _ChatDetailState(petID!, friendUID!);
// }

// class _ChatDetailState extends State<ChatDetail> {
//   CollectionReference chats = FirebaseFirestore.instance.collection('chats');
//   late String petID, friendUID;
//   final currentUserId = FirebaseAuth.instance.currentUser?.uid;
//   String? toname,
//       fromPathImage,
//       fromname,
//       fromuid,
//       toPathImage,
//       lastmsg = '-',
//       // lasttime = '-',
//       msg_num = '0',
//       PetID,
//       petImage;
//   var chatDocId;
//   String? friendName;
//   final DateTime lasttime = DateTime.now();
//   List<Message> messages = [];

//   _ChatDetailState(String petID, String friendUID);

//   @override
//   void initState() {
//     super.initState();
//     // chats.where(field)
//     petID = widget.petID!;
//     friendUID = widget.friendUID!;
//     // uploadInformationToChat();
//     showProfile();
//   }

// //ส่งค่าไปสร้าห้องแชท
//   Future<void> uploadInformationToChat() async {
//     await FirebaseAuth.instance.authStateChanges().listen((event) async {
//       fromuid = event!.uid;
//       final DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('user')
//           .doc(fromuid)
//           .get();

//       setState(() {
//         fromname = userDoc.get('name');
//         fromPathImage = userDoc.get('PathImage');
//       });
//       Map<String, dynamic> map = Map();
//       map['fromPathImage'] = fromPathImage;
//       map['from_name'] = fromname;
//       map['from_uid'] = fromuid;
//       map['last_msg'] = lastmsg;
//       map['last_time'] = lasttime;
//       map['to_PathImage'] = toPathImage;
//       map['to_name'] = toname;
//       map['to_uid'] = friendUID;
//       await FirebaseFirestore.instance
//           .collection('user')
//           .doc(fromuid)
//           .collection('chat')
//           .doc()
//           .set(map)
//           .then((value) {
//         print('#####INSERT SUCCESS $fromuid');
//       });
//     });
//   }

//   // เอาuid ไปเรียกข้อมูลเจ้าของโพสต์
//   Future<void> showProfile() async {
//     await Firebase.initializeApp().then((value) async {
//       String uid = friendUID;
//       final DocumentSnapshot userDoc =
//           await FirebaseFirestore.instance.collection('user').doc(uid).get();

//       setState(() {
//         toname = userDoc.get('name');
//         toPathImage = userDoc.get('PathImage');
//       });
//       showPet();
//       // uploadInformationToChat();
//     });
//   }

// //แสดงข้อมูลสัตว์
//   Future<void> showPet() async {
//     await Firebase.initializeApp().then((value) async {
//       String pid = petID;
//       final DocumentSnapshot petDoc =
//           await FirebaseFirestore.instance.collection('pets').doc(pid).get();
//       setState(() {
//         petImage = petDoc.get('PathImage');
//       });
//     });
//   }

//   late double screenWidth, screenHeight;
//   @override
//   Widget build(BuildContext context) {
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: MyStyle().primaryColor,
//       body: Container(
//         child: Stack(
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: 50, left: 2, right: 20),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.arrow_back_ios_new_outlined),
//                     onPressed: () {
//                       Navigator.popAndPushNamed(context, '/chat');
//                     },
//                   ),
//                   CircleAvatar(
//                     backgroundImage: toPathImage == null
//                         ? NetworkImage(
//                             'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg')
//                         : NetworkImage(toPathImage!),
//                     radius: 20,
//                   ),
//                   const SizedBox(width: 5),
//                   Text(
//                     ' $toname',
//                     style: TextStyle(fontSize: 18),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.only(left: 20, right: 20, top: 10),
//               margin: EdgeInsets.only(top: 100),
//               width: screenWidth * 100,
//               height: screenHeight / 1.1,
//               decoration: BoxDecoration(
//                   color: MyStyle().lightColor,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30))),
//               child: Column(
//                 children: [
//                   Container(
//                     // padding: EdgeInsets.only(
//                     //     left: 20, right: 20, top: 5, bottom: 20),
//                     margin: EdgeInsets.only(top: 1, bottom: 10),
//                     width: screenWidth * 0.98,
//                     height: screenHeight * 0.105,
//                     decoration: BoxDecoration(
//                         color: MyStyle().secondColor,
//                         borderRadius: BorderRadius.circular(30)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: petImage == null
//                               ? NetworkImage(
//                                   'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg')
//                               : NetworkImage(petImage!),
//                           radius: 20,
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(top: 2),
//                           child: Column(
//                             children: [
//                               Text('อนุมัติการรับเลี้ยงหรือไม่'),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   ButtonBar(
//                                     alignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       RawMaterialButton(
//                                         onPressed: () => {},
//                                         fillColor: Colors.green,
//                                         child: Text(
//                                           'อนุมัติ',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       ),
//                                       RawMaterialButton(
//                                         onPressed: () => {},
//                                         fillColor: Colors.red,
//                                         child: Text(
//                                           'ไม่อนุมัติ',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.only(
//                         left: MediaQuery.of(context).size.width / 2),
//                     alignment: Alignment.bottomRight,
//                     decoration: BoxDecoration(
//                         color: MyStyle().secondColor,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.circular(10),
//                             bottomLeft: Radius.circular(10))),
//                     child: Text(
//                       'Hello ',
//                       style: TextStyle(color: Colors.black, fontSize: 15),
//                     ),
//                   ),
                  // SizedBox(
                  //   height: 20,
                  // ),
//                   Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.only(
//                         right: MediaQuery.of(context).size.width / 2),
//                     alignment: Alignment.topLeft,
//                     decoration: BoxDecoration(
//                         color: Color.fromARGB(198, 207, 207, 206),
//                         borderRadius: BorderRadius.only(
//                             bottomRight: Radius.circular(10),
//                             topRight: Radius.circular(10),
//                             topLeft: Radius.circular(10))),
//                     child: Text(
//                       'Hi',
//                       style: TextStyle(color: Colors.black, fontSize: 15),
//                     ),
//                   ),
//                   Spacer(),
//                   buildChatInput()
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Container buildChatInput() {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       child: Material(
//         elevation: 5,
//         borderRadius: BorderRadius.circular(10),
//         child: Container(
//           padding: EdgeInsets.only(left: 10),
//           decoration: BoxDecoration(
//               color: MyStyle().lightColor,
//               borderRadius: BorderRadius.circular(10)),
//           child: Row(
//             children: [
//               IconButton(
//                   onPressed: () {},
//                   icon: const Icon(Icons.image, color: Colors.grey)),
//               IconButton(
//                   onPressed: () {},
//                   icon:
//                       const Icon(Icons.camera_alt_rounded, color: Colors.grey)),
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "ข้อความ",
//                       hintStyle: TextStyle(color: Colors.black45)),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                     color: Color(0xFFf3f3f3),
//                     borderRadius: BorderRadius.circular(60)),
//                 child: Icon(
//                   Icons.send,
//                   color: MyStyle().primaryColor,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
