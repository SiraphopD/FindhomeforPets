import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final displaynamecoltroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final gendercontroller = TextEditingController();
  final provincecontroller = TextEditingController();
  final introducecontroller = TextEditingController();
  File? file;
  String? displayName,
      uid,
      gender,
      phonenumber,
      province,
      introduce,
      PathImage,
      urlPicture,
      newdisplayName,
      newgender,
      newphonenumber,
      newprovince,
      newintroduce,
      newPathImage,
      provinceselected;

  late double screenWidth, screenHeight;
  final Provincelist = [
    'กรุงเทพมหานคร',
    'กระบี่',
    'กาญจนบุรี',
    'กาฬสินธุ์',
    'กำแพงเพชร',
    'ขอนแก่น',
    'จันทบุรี',
    'ฉะเชิงเทรา',
    'ชลบุรี',
    'ชัยนาท',
    'ชัยภูมิ',
    'ชุมพร',
    'เชียงใหม่',
    'เชียงราย',
    'ตรัง',
    'ตราด',
    'ตาก',
    'นครนายก',
    'นครปฐม',
    'นครพนม',
    'นครราชสีมา',
    'นครศรีธรรมราช',
    'นครสวรรค์',
    'นนทบุรี',
    'นราธิวาส',
    'น่าน',
    'บึงกาฬ',
    'บุรีรัมย์',
    'ปทุมธานี',
    'ประจวบคีรีขันธ์',
    'ปราจีนบุรี',
    'ปัตตานี',
    'พระนครศรีอยุธยา',
    'พะเยา',
    'พังงา',
    'พัทลุง',
    'พิจิตร',
    'พิษณุโลก',
    'เพชรบุรี',
    'เพชรบูรณ์',
    'แพร่',
    'ภูเก็ต',
    'มหาสารคาม',
    'มุกดาหาร',
    'แม่ฮ่องสอน',
    'ยโสธร',
    'ยะลา',
    'ร้อยเอ็ด',
    'ระนอง',
    'ระยอง',
    'ราชบุรี',
    'ลพบุรี',
    'ลำปาง',
    'ลำพูน',
    'เลย',
    'ศรีสะเกษ',
    'สกลนคร',
    'สงขลา',
    'สตูล',
    'สมุทรปราการ',
    'สมุทรสงคราม',
    'สมุทรสาคร',
    'สระแก้ว',
    'สระบุรี',
    'สิงห์บุรี',
    'สุโขทัย',
    'สุพรรณบุรี',
    'สุราษฎร์ธานี',
    'สุรินทร์',
    'หนองคาย',
    'หนองบัวลำภู',
    'อ่างทอง',
    'อำนาจเจริญ',
    'อุดรธานี',
    'อุตรดิตถ์',
    'อุทัยธานี',
    'อุบลราชธานี',
  ];
  @override
  void initState() {
    showProfile();
    super.initState();
  }

  Future<void> showProfile() async {
    await Firebase.initializeApp().then((value) async {
      // .listen ถ้าloginจะมีข้อมูลถ้าไม่loginไม่มีข้อมูล //
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
          introducecontroller.text = userDoc.get('introduce');
          displaynamecoltroller.text = userDoc.get('name');
          phonecontroller.text = userDoc.get('phonenum');
          gendercontroller.text = userDoc.get('gender');
          provincecontroller.text = userDoc.get('province');
        });
        for (int i = 0; i < Provincelist.length; i++) {
          if (province == Provincelist[i]) {
            setState(() {
              provinceselected = province;
            });
          }
        }
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
                  Text('    '),
                ]),
              ),
            ),
            title: Row(
              children: [
                Text('แก้ไขโปรไฟล์'),
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
                      child: Column(
                        children: [
                          Text('แนะนำตัว'),
                          buildIntroduce(),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.09,
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
                      children: [buildName()],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.09,
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
                      children: [buildPhonenum()],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.09,
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
                      children: [buildGender()],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 18),
                    margin: EdgeInsets.only(
                        right: 20, left: 20, top: 20, bottom: 20),
                    width: screenWidth * 0.95,
                    height: screenHeight * 0.09,
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
                      children: [
                        Icon(Icons.pin_drop),
                        buildaddress(),
                      ],
                    ),
                  ),
                  buildSave(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildaddress() {
    return Container(
      margin: EdgeInsets.only(left: 13),
      width: screenWidth * 0.65,
      height: screenHeight * 0.0659,
      child: SingleChildScrollView(
        child: DropdownButtonFormField(
          menuMaxHeight: 300,
          value: provinceselected,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          items: Provincelist.map(
            (e) {
              return DropdownMenuItem(
                child: Text(e),
                value: e,
              );
            },
          ).toList(),
          onChanged: (value) {
            setState(
              () {
                provinceselected = value;
                province = value;
              },
            );
          },
        ),
      ),
    );
  }

  Row buildPhonenum() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screenWidth * 0.65,
          height: screenHeight * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.phone),
              Text('$phonenumber'),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 2),
          child: IconButton(
              onPressed: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("แก้ไขเบอร์โทรศัพท์"),
                        content: TextFormField(
                          controller: phonecontroller,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => newphonenumber = value.trim(),
                          decoration: InputDecoration(
                            labelStyle: MyStyle().darkStyle(),
                            hintText: '$phonenumber',
                            hintStyle: TextStyle(
                              fontSize: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: MyStyle().darkColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: MyStyle().primaryColor)),
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              newphonenumber = phonenumber;
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (newphonenumber?.isEmpty ?? true) {
                                newphonenumber = phonenumber;
                                Navigator.pop(context);
                              } else {
                                updatephone();
                              }
                              // updatephone();
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.edit)),
        )
      ],
    );
  }

  Row buildGender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: screenWidth * 0.65,
          height: screenHeight * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.attribution_sharp),
              Text('$gender'),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 2),
          child: IconButton(
              onPressed: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("แก้ไขเพศ"),
                        content: TextFormField(
                          controller: gendercontroller,
                          keyboardType: TextInputType.name,
                          onChanged: (value) => newgender = value.trim(),
                          decoration: InputDecoration(
                            labelStyle: MyStyle().darkStyle(),
                            hintText: '$gender',
                            hintStyle: TextStyle(
                              fontSize: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: MyStyle().darkColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: MyStyle().primaryColor)),
                            prefixIcon: Icon(Icons.account_circle_rounded),
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              newgender = gender;
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (newgender?.isEmpty ?? true) {
                                newgender = gender;
                                Navigator.pop(context);
                              } else {
                                updategender();
                              }
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.edit)),
        )
      ],
    );
  }

  Row buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: screenWidth * 0.65,
          height: screenHeight * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.account_circle_rounded),
              Text('$displayName'),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 2),
          child: IconButton(
              onPressed: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("แก้ไขชื่อ-นามสกุล"),
                        content: TextFormField(
                          controller: displaynamecoltroller,
                          keyboardType: TextInputType.name,
                          onChanged: (value) => newdisplayName = value.trim(),
                          decoration: InputDecoration(
                            labelStyle: MyStyle().darkStyle(),
                            hintText: '$displayName',
                            hintStyle: TextStyle(
                              fontSize: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: MyStyle().darkColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: MyStyle().primaryColor)),
                            prefixIcon: Icon(Icons.account_circle_rounded),
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              newdisplayName = displayName;
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (newdisplayName?.isEmpty ?? true) {
                                newdisplayName = displayName;
                                Navigator.pop(context);
                              } else {
                                updatename();
                              }
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.edit)),
        )
      ],
    );
  }

  Container buildIntroduce() {
    return Container(
      width: screenWidth * 0.78,
      height: screenHeight * 0.125,
      child: TextFormField(
        controller: introducecontroller,
        keyboardType: TextInputType.name,
        maxLines: 3,
        onChanged: (value) => newintroduce = value.trim(),
        decoration: InputDecoration(
          labelStyle: MyStyle().darkStyle(),
          hintText: '$introduce',
          hintStyle: TextStyle(
            fontSize: 10,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: MyStyle().primaryColor)),
        ),
      ),
    );
  }

  showImage() {
    return GestureDetector(
      onTap: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("อัพโหลดรูปโปรไฟล์"),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      showButton(),
                    ],
                  ),
                ),
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
                      uploadPictureTostorage();
                    },
                    icon: const Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                  ),
                ],
              );
            });
      },
      child: Container(
          margin: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: file == null
              ? PathImage == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CircleAvatar(
                      backgroundImage: PathImage == null
                          ? NetworkImage(
                              'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg')
                          : NetworkImage(PathImage!),
                      radius: 50,
                    )
              : CircleAvatar(
                  backgroundImage: FileImage(file!),
                  radius: 50,
                )),
    );
  }

  Widget cameraButton() {
    return GestureDetector(
      onTap: () {
        chooseImage(ImageSource.camera);
      },
      child: Container(
        margin: EdgeInsets.only(top: 2),
        width: screenWidth * 0.9,
        height: screenHeight * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyStyle().lightColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_a_photo,
              size: 24,
              color: MyStyle().primaryColor,
            ),
            Text('  ถ่ายภาพ'),
          ],
        ),
      ),
    );
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

  Widget galleryButton() {
    return GestureDetector(
      onTap: () {
        chooseImage(ImageSource.gallery);
      },
      child: Container(
        margin: EdgeInsets.only(top: 5),
        width: screenWidth * 0.9,
        height: screenHeight * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyStyle().lightColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate,
              size: 26,
              color: Colors.green,
            ),
            Text('เลือกจากรูปถ่าย')
          ],
        ),
      ),
    );
  }

  Widget showButton() {
    return Column(
      children: [cameraButton(), galleryButton()],
    );
  }

  Future<void> uploadPictureTostorage() async {
    Random random = Random();
    int i = random.nextInt(100000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference storagereference =
        firebaseStorage.ref().child('Userprofile/profile$i.jpg');
    UploadTask storageUploadtask = storagereference.putFile(file!);
    urlPicture = await (await storageUploadtask.whenComplete(() => null))
        .ref
        .getDownloadURL();
    print('urlPicture = $urlPicture');
    updatepathimage();
  }

  Container buildSave(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 5),
        width: screenWidth * 0.8,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: MyStyle().primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29),
                )),
            onPressed: () {
              if (newintroduce?.isEmpty ?? true) {
                newintroduce = introduce;
                Navigator.pop(context);
              }
              if (newprovince?.isEmpty ?? true) {
                newprovince = province;
                updateprovince();
              } else {
                updateintroduce();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/profile', ModalRoute.withName('/home'));
              }
              Navigator.pushNamedAndRemoveUntil(
                  context, '/profile', ModalRoute.withName('/home'));
            },
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.white,
            ),
            label: Text(
              'บันทึก',
              style: TextStyle(color: Colors.white),
            )));
  }

  Future<void> updatephone() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update({'phonenum': newphonenumber}).then((value) {
      print('#########UPDATE SUCCESS :${phonenumber}');
      Navigator.popAndPushNamed(context, '/editprofile');
    });
  }

  Future<void> updategender() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update({'gender': newgender}).then((value) {
      print('#########UPDATE SUCCESS :${gender}');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EditProfile()));
    });
  }

  Future<void> updatename() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update({'name': newdisplayName}).then((value) {
      print('#########UPDATE SUCCESS :${displayName}');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EditProfile()));
    });
  }

  Future<void> updateintroduce() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update({'introduce': newintroduce}).then((value) {
      print('#########UPDATE SUCCESS :${introduce}');
      Navigator.pushNamedAndRemoveUntil(
          context, '/profile', ModalRoute.withName('/home'));
    });
  }

  Future<void> updateprovince() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update({'province': newprovince}).then((value) {
      print('#########UPDATE SUCCESS :${province}');
      Navigator.pushNamedAndRemoveUntil(
          context, '/profile', ModalRoute.withName('/home'));
    });
  }

  Future<void> updatepathimage() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update({'PathImage': urlPicture}).then((value) {
      print('#########UPDATE SUCCESS :${PathImage}');
      Navigator.pop(context);
    });
  }
}
