import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/constant/Firebasae_constant.dart';
import 'package:findhomeforpets/api/access_firebase_token.dart';
import 'package:findhomeforpets/constant/mediaquery.dart';
import 'package:findhomeforpets/models/message.dart';
import 'package:findhomeforpets/states/chat/chat.dart';
import 'package:findhomeforpets/states/profile2.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:findhomeforpets/widgets/chatBubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class Chat_Screen extends StatefulWidget {
  final String uid;
  Chat_Screen({Key? key, required this.uid}) : super(key: key);

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  String groupChatId = "";
  String currentUserId = "";
  String peerId = "";
  String? toname = "", toPathImage = "";
  String? toname2 = "", toPathImage2 = "", lastmessage = " ", type = " ";
  File? file;
  String? lasttime = DateTime.now().millisecondsSinceEpoch.toString();
//สร้างห้องแชท
  generateGroupId() {
    currentUserId = FirebaseAuth.instance.currentUser!.uid;
    peerId = widget.uid;

    if (currentUserId.hashCode <= peerId.hashCode) {
      groupChatId = '$currentUserId-$peerId';
    } else {
      groupChatId = '$peerId-$currentUserId';
    }
    pushIDToFirestore();
    pushIDToFirestore2();
  }

  Future<void> pushIDToFirestore() async {
    await Firebase.initializeApp().then((value) async {
      Map<String, dynamic> map = Map();
      map['chatID'] = groupChatId;
      map['peerID'] = peerId;
      map['toname'] = toname;
      map['toPathImage'] = toPathImage;
      map['lasttime'] = lasttime;
      map['lastmessage'] = lastmessage;
      map['type'] = type;
      await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUserId)
          .collection('chatWith')
          .doc(groupChatId)
          .set(map);
    });
  }

  Future<void> pushIDToFirestore2() async {
    await Firebase.initializeApp().then((value) async {
      Map<String, dynamic> map2 = Map();
      map2['chatID'] = groupChatId;
      map2['peerID'] = currentUserId;
      map2['toname'] = toname2;
      map2['toPathImage'] = toPathImage2;
      map2['lasttime'] = lasttime;
      map2['lastmessage'] = lastmessage;
      map2['type'] = type;
      await FirebaseFirestore.instance
          .collection('user')
          .doc(peerId)
          .collection('chatWith')
          .doc(groupChatId)
          .set(map2);
    });
  }

  Future<void> showProfile() async {
    await Firebase.initializeApp().then((value) async {
      String peeruid = peerId;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(peeruid)
          .get();

      setState(() {
        toname = userDoc.get('name');
        toPathImage = userDoc.get('PathImage');
      });
      Map<String, dynamic> map = Map();
      map['toname'] = toname;
      map['toPathImage'] = toPathImage;
      await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUserId)
          .collection('chatWith')
          .doc(groupChatId)
          .update(map);
    });
  }

  Future<void> showProfile2() async {
    await Firebase.initializeApp().then((value) async {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUserId)
          .get();

      setState(() {
        toname2 = userDoc.get('name');
        toPathImage2 = userDoc.get('PathImage');
      });
      Map<String, dynamic> map2 = Map();
      map2['toname'] = toname2;
      map2['toPathImage'] = toPathImage2;
      await FirebaseFirestore.instance
          .collection('user')
          .doc(peerId)
          .collection('chatWith')
          .doc(groupChatId)
          .update(map2);
    });
  }

  Future<void> updateLastmessage(String message, String type) async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("user")
        .doc(currentUserId)
        .collection("chatWith")
        .doc(groupChatId)
        .get();
    setState(() {
      lastmessage = userDoc.get('lastmessage');
    });
    Map<String, dynamic> map = Map();
    map['lastmessage'] = message;
    map['type'] = type;
    await FirebaseFirestore.instance
        .collection("user")
        .doc(currentUserId)
        .collection("chatWith")
        .doc(groupChatId)
        .update(map);
    await FirebaseFirestore.instance
        .collection("user")
        .doc(peerId)
        .collection("chatWith")
        .doc(groupChatId)
        .update(map);
    print('##########UPDATE SUCCESS');
  }

  sendChat({required String message, required String type}) async {
    MessageChat chat = MessageChat(
        content: message,
        idFrom: currentUserId,
        idTo: peerId,
        timestamp: Timestamp.now().toString(),
        type: type);
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance
        .collection("chat")
        .doc(groupChatId)
        .collection("messages")
        .add(chat.toJson())
        .then((value) => sendPushNotification(
            chat, type == 'text' ? message : 'ส่งรูปแล้ว'));
    ;
    Map<String, dynamic> map = Map();
    map['lasttime'] = time;
    await FirebaseFirestore.instance
        .collection("user")
        .doc(currentUserId)
        .collection("chatWith")
        .doc(groupChatId)
        .update(map);

    if (chat.content != null) {
      updateLastmessage(chat.content, chat.type);
      print('############### $toname');
    }
  }

  Future<void> sendPushNotification(MessageChat chat, String msg) async {
    await Firebase.initializeApp().then((value) async {
      String uid = chat.idTo;
      String currentUID = chat.idFrom;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('user').doc(uid).get();

      String pushToken = userDoc.get('pushToken');
      DocumentSnapshot userDoc2 = await FirebaseFirestore.instance
          .collection('user')
          .doc(currentUID)
          .get();
      String name = userDoc2.get('name');
      AccessFirebaseToken accessToken = AccessFirebaseToken();
      String bearerToken = await accessToken.getAccessToken();

      final body = {
        "message": {
          "token": pushToken.toString(),
          "notification": {"title": name, "body": msg},
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

  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
  }

  Container showImage() {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      // ignore: unnecessary_null_comparison
      child:
          file == null ? Image.asset('images/profile.png') : Image.file(file!),
    );
  }

  Future<void> uploadPictureTostorage() async {
    Random random = Random();
    int i = random.nextInt(100000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference storagereference =
        firebaseStorage.ref().child('chat/images$i.jpg');
    UploadTask storageUploadtask = storagereference.putFile(file!);
    final urlPicture = await (await storageUploadtask.whenComplete(() => null))
        .ref
        .getDownloadURL();
    print('urlPicture = $urlPicture');
    sendChat(message: urlPicture.toString(), type: 'image');
    setState(() {
      file = null;
    });
  }

  @override
  void initState() {
    super.initState();
    generateGroupId();
    showProfile();
    showProfile2();
    // _scrollDown();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _controller = ScrollController();

  void _scrollDown() {
    if (_controller.hasClients) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    }
  }

  Future<bool> onBackPress() {
    Navigator.pop(context);
    return Future.value(false);
  }

  late double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
          bottomNavigationBar: SafeArea(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: MyStyle().lightColor,
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              height: 60,
              width: media(context).width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        chooseImage(ImageSource.gallery);
                      },
                      icon: Icon(Icons.image)),
                  IconButton(
                      onPressed: () {
                        chooseImage(ImageSource.camera);
                      },
                      icon: Icon(Icons.camera_alt_rounded)),
                  Container(
                      width: media(context).width / 2,
                      child: file == null
                          ? TextField(
                              decoration:
                                  InputDecoration(label: Text("ข้อความ")),
                              controller: _messageController)
                          : showImage()),
                  IconButton(
                      onPressed: () {
                        if (file == null) {
                          sendChat(
                              message: _messageController.text, type: 'text');
                          _messageController.text = "";
                          _scrollDown();
                          FocusManager.instance.primaryFocus?.unfocus();
                        } else {
                          uploadPictureTostorage();
                          _messageController.text = "";
                          _scrollDown();
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            ),
          ),
          backgroundColor: MyStyle().primaryColor,
          body: Container(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40, left: 2, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_outlined),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Chat()),
                          );
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile2(uid: peerId)));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: toPathImage == null
                                  ? NetworkImage(
                                      'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg')
                                  : NetworkImage(toPathImage!),
                              radius: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              ' $toname',
                              style: TextStyle(
                                  fontSize: 18, color: MyStyle().darkColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(top: 100),
                  padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                  width: screenWidth * 100,
                  height: screenHeight / 1.1,
                  decoration: BoxDecoration(
                      color: MyStyle().lightColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("chat")
                          .doc(groupChatId)
                          .collection("messages")
                          .orderBy(FirestoreConstants.timestamp,
                              descending: true)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          controller: _controller,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            MessageChat chat = MessageChat.fromDocument(
                                snapshot.data!.docs[index]);

                            return ChatBubble(
                              text: chat.content,
                              isCurrentUser:
                                  chat.idFrom == currentUserId ? true : false,
                              type: chat.type,
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          )),
    );
  }
}
