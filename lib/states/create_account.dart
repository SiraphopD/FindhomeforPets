import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/user_model.dart';
import 'package:findhomeforpets/utility/dialog.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  File? file;

  late double screenWidth, screenHeight;
  String? name,
      picture,
      gender,
      phonenumber,
      district,
      subdistrict,
      province,
      introduce,
      user,
      password,
      PathImage,
      urlPicture,
      provinceselected = '--โปรดระบุจังหวัด--';
  final Provincelist = [
    '--โปรดระบุจังหวัด--',
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
  Container buildDisplayName() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: screenWidth * 0.78,
      height: screenHeight * 0.07,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          labelStyle: MyStyle().darkStyle(),
          labelText: 'ชื่อ-นามสกุล',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().lightColor)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Container buildGender() {
    return Container(
        // margin: EdgeInsets.only(top: 16),
        width: screenWidth * 0.78,
        height: screenHeight * 0.07,
        child: TextField(
          onChanged: (value) => gender = value.trim(),
          decoration: InputDecoration(
            labelStyle: MyStyle().darkStyle(),
            labelText: 'เพศ',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(29),
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().lightColor),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ));
  }

  Container buildPhone() {
    return Container(
      // margin: EdgeInsets.only(top: ),
      width: screenWidth * 0.78, height: screenHeight * 0.07,
      child: TextField(
        onChanged: (value) => phonenumber = value.trim(),
        decoration: InputDecoration(
          labelStyle: MyStyle().darkStyle(),
          labelText: 'เบอร์โทร',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().lightColor)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Container buildDistrict() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.38,
      height: screenHeight * 0.07,
      child: TextField(
        onChanged: (value) => district = value.trim(),
        decoration: InputDecoration(
          labelStyle: MyStyle().darkStyle(),
          labelText: 'เขต',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().lightColor)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Container buildProvince() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      width: screenWidth * 0.7,
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

  Container buildintroduce() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: screenWidth * 0.78,
      height: screenHeight * 0.2,
      child: TextField(
        onChanged: (value) => introduce = value.trim(),
        decoration: InputDecoration(
          labelStyle: MyStyle().darkStyle(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
        style: TextStyle(),
        minLines: 30,
        maxLines: 50,
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screenWidth * 0.8,
      height: screenHeight * 0.07,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ),
          labelStyle: MyStyle().darkStyle(),
          labelText: 'อีเมล',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().lightColor)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.8,
      height: screenHeight * 0.07,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().darkColor,
          ),
          labelStyle: MyStyle().darkStyle(),
          labelText: 'รหัสผ่าน',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(29),
              borderSide: BorderSide(color: MyStyle().lightColor)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Container showImage() {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      // ignore: unnecessary_null_comparison
      child:
          file == null ? Image.asset('images/profile.png') : Image.file(file!),
    );
  }

  Widget cameraButton() {
    return IconButton(
        onPressed: () {
          chooseImage(ImageSource.camera);
        },
        icon: Icon(
          Icons.add_a_photo,
          size: 36,
          color: MyStyle().primaryColor,
        ));
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
    return IconButton(
        onPressed: () {
          chooseImage(ImageSource.gallery);
        },
        icon: Icon(
          Icons.add_photo_alternate,
          size: 38,
          color: Colors.green,
        ));
  }

  Widget showButton() {
    return Column(
      children: [cameraButton(), galleryButton()],
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('สร้างบัญชีผู้ใช้'),
        backgroundColor: MyStyle().primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 105),
                child: Row(children: [
                  showImage(),
                  showButton(),
                ]),
              ),
              Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.only(right: 20, left: 20),
                  width: screenWidth * 0.9,
                  height: 80,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Row(
                    children: [
                      buildDisplayName(),
                      // buildSName(),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  width: screenWidth * 0.9,
                  height: 80,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Row(
                    children: [
                      buildGender(),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  width: screenWidth * 0.9,
                  height: 80,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Row(
                    children: [
                      buildPhone(),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  // width: 360,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          buildProvince(),
                        ],
                      ),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Column(
                    children: [
                      buildTitle(),
                      buildintroduce(),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  width: screenWidth * 0.9,
                  height: 175,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Center(
                    child: Column(
                      children: [
                        buildUser(),
                        buildPassword(),
                      ],
                    ),
                  )),
              buildCreateAccount(context)
            ],
          ),
        ),
      ),
    );
  }

  Container buildCreateAccount(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8),
        width: screenWidth * 0.8,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: MyStyle().primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29),
                )),
            onPressed: () {
              if ((name?.isEmpty ?? true) ||
                  (gender?.isEmpty ?? true) ||
                  (phonenumber?.isEmpty ?? true) ||
                  (provinceselected == '--โปรดระบุจังหวัด--') ||
                  (introduce?.isEmpty ?? true) ||
                  (user?.isEmpty ?? true) ||
                  (password?.isEmpty ?? true)) {
                print('Have Space');
                normailDialog(
                    context, 'กรอกข้อมูลไม่ครบ', 'โปรดกรอกข้อมูลให้ครบทุกช่อง');
              } else {
                createAccountAndInsertInformation();
                uploadPictureTostorage();
              }
            },
            icon: Icon(Icons.cloud_upload),
            label: Text('สร้างบัญชี')));
  }

  Future<void> uploadPictureTostorage() async {
    Random random = Random();
    int i = random.nextInt(100000);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference storageReference =
        firebaseStorage.ref().child('Userprofile/profile$i.jpg');
    if (file != null) {
      UploadTask storageUploadTask = storageReference.putFile(file!);
      urlPicture = await (await storageUploadTask.whenComplete(() => null))
          .ref
          .getDownloadURL();
    } else {
      UploadTask storageUploadTask = storageReference.putData(
        (await DefaultAssetBundle.of(context).load('images/profile.png'))
            .buffer
            .asUint8List(),
      );
      urlPicture = await (await storageUploadTask.whenComplete(() => null))
          .ref
          .getDownloadURL();
    }

    print('urlPicture = $urlPicture');
  }

  Future<Null> createAccountAndInsertInformation() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user!, password: password!)
          .then((value) async {
        await value.user!
            .updateProfile(displayName: name!)
            .then((value2) async {
          String? uid = value.user!.uid;
          print('Update Profile Success and uid=$uid');

          UserModel model = UserModel(
              name: name!,
              gender: gender!,
              phonenum: phonenumber!,
              province: province!,
              introduce: introduce!,
              PathImage: urlPicture!,
              pushToken: ' ');
          Map<String, dynamic> data = model.toMap();

          await FirebaseFirestore.instance
              .collection('user')
              .doc(uid)
              .set(data)
              .then((value) {
            print('Insert Value To Firestore Success');
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          });
        });
      }).catchError((onError) =>
              normailDialog(context, onError.code, onError.message));
    });
  }

  Container buildTitle() {
    return Container(
        padding: EdgeInsets.all(5),
        width: screenWidth * 0.8,
        child: Text(
          'แนะนำตัวเอง',
          textAlign: TextAlign.center,
          style: MyStyle().darkStyle(),
        ));
  }
}
