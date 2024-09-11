import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/utility/dialog.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class PostMissingPet extends StatefulWidget {
  const PostMissingPet({super.key});

  @override
  State<PostMissingPet> createState() => _PostMissingPetState();
}

class _PostMissingPetState extends State<PostMissingPet> {
  File? file1;
  late double screenWidth, screenHeight;
  // TextEditingController _labelcontroller = TextEditingController();
  String? pettype = 'สุนัข',
      petname,
      petgender = 'ผู้',
      petcolor,
      breed,
      age = '-',
      vaccine = '-',
      more_info,
      province,
      PathImage,
      urlPicture,
      petID,
      label = '--โปรดเลือกสายพันธุ์--',
      uid,
      provinceselected = '--โปรดระบุจังหวัด--',
      dogselected = '--โปรดเลือกสายพันธุ์--',
      catselected = '--โปรดเลือกสายพันธุ์--';
  List<String> items = ['สุนัข', 'แมว', 'อื่นๆ'];
  List<String> items2 = ['ผู้', 'เมีย'];
  int current = 0, current2 = 0;
  final Dogbreedlist = [
        '--โปรดเลือกสายพันธุ์--',
        'บีเกิล',
        'บูลด็อก',
        'ชิวาวา',
        'คอร์กี้',
        'โดเบอร์แมน',
        'โกลเด้น รีทริฟเวอร์',
        'ชิสุ',
        'ไซบีเรียนฮัสกี้',
        'ไทยหลังอาน',
        'ไทยบางแก้ว',
        'อื่นๆ'
      ],
      Catbreedlist = [
        '--โปรดเลือกสายพันธุ์--',
        'วิเชียรมาศ',
        'สีสวาด',
        'เปอร์เซีย',
        'อเมริกัน ชอร์ตแฮร์',
        'สก็อตติช โฟลด์',
        'ชาวมณีหรือขาวปลอด',
        'บริติส ชอร์ตแฮร์',
        'เอ็กโซติก ชอร์ตแฮร์',
        'แร็กดอลล์',
        'สฟิงซ์',
        'อื่นๆ'
      ],
      Provincelist = [
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
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('ประกาศสัตว์เลี้ยงหาย'),
        backgroundColor: MyStyle().primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  showImage(),
                  showButton(),
                ]),
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(right: 20, left: 20),
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.15,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildTitle1(),
                      buildPettype(),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.145,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildTitle2(),
                      buildName(),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.145,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildTitle3(),
                      buildGender(),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.145,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildTitle4(),
                      buildColor(),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.145,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildTitle5(),
                      BreedandBtn(),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.145,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildTitle7(),
                      buildprovince(),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(18),
                  margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                      color: MyStyle().secondColor,
                      borderRadius: BorderRadius.circular(29)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildTitle6(),
                      buildMoreinfo(),
                    ],
                  )),
              buildCreatePost(context),
            ],
          ),
        ),
      ),
    );
  }

  Container buildCreatePost(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8),
        width: screenWidth * 0.8,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: MyStyle().primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            onPressed: () {
              if ((pettype?.isEmpty ?? true) ||
                  (petname?.isEmpty ?? true) ||
                  (file1 == null) ||
                  (petgender?.isEmpty ?? true) ||
                  (petcolor?.isEmpty ?? true) ||
                  (more_info?.isEmpty ?? true) ||
                  (provinceselected == '--โปรดระบุจังหวัด--') ||
                  (pettype == 'สุนัข' &&
                      (dogselected == '--โปรดเลือกสายพันธุ์--')) ||
                  (pettype == 'แมว' &&
                      (catselected == '--โปรดเลือกสายพันธุ์--')) ||
                  (pettype == 'อื่นๆ' && (breed?.isEmpty ?? true))) {
                print('Have Space');
                normailDialog(
                    context, 'กรอกข้อมูลไม่ครบ', 'โปรดกรอกข้อมูลให้ครบทุกช่อง');
                print(breed);
                print(pettype);
              } else {
                // createAccountAndInsertInformation();
                uploadPictureTostorage();
              }
            },
            icon: Icon(Icons.post_add),
            label: Text('Post')));
  }

  Container showImage() {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      // ignore: unnecessary_null_comparison
      child:
          file1 == null ? Image.asset('images/image.png') : Image.file(file1!),
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

  Future<void> _tfLteInit() async {
    String? res = await Tflite.loadModel(
        model: "assets/RMSwithMobilenetV2.tflite",
        labels: "assets/labelst.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate:
            false // defaults to false, set to true to use GPU delegate
        );
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      final XFile? object = await ImagePicker().pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      if (object == null) return;
      setState(() {
        file1 = File(object.path);
      });
      var recognitions = await Tflite.runModelOnImage(
          path: object.path, // required
          imageMean: 0.0, // defaults to 117.0
          imageStd: 255.0, // defaults to 1.0
          numResults: 2, // defaults to 5
          threshold: 0.2, // defaults to 0.1
          asynch: true // defaults to true
          );

      if (recognitions == null) {
        print("recognitions is Null");
        return;
      }
      print(recognitions.toString());
      setState(() {
        label = recognitions[0]['label'].toString();
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tfLteInit();
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

  Future<void> uploadPictureTostorage() async {
    Random random = Random();
    int i = random.nextInt(100000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference storagereference =
        firebaseStorage.ref().child('missingpet/mpets$i.jpg');
    UploadTask storageUploadtask = storagereference.putFile(file1!);
    urlPicture = await (await storageUploadtask.whenComplete(() => null))
        .ref
        .getDownloadURL();
    print('urlPicture = $urlPicture');
    insertValueToFirestore();
  }

  Future<void> insertValueToFirestore() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uid = event!.uid;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final docID = firebaseFirestore.collection('missingpet').doc();
      petID = docID.id;
      Map<String, dynamic> map = Map();
      map['pettype'] = pettype;
      map['petname'] = petname;
      map['petgender'] = petgender;
      map['petcolor'] = petcolor;
      map['breed'] = breed;
      map['province'] = province;
      map['more_info'] = more_info;
      map['PathImage'] = urlPicture;
      map['uid'] = uid;
      map['age'] = age;
      map['vaccine'] = vaccine;
      map['petID'] = petID;
      await firebaseFirestore
          .collection('missingpet')
          .doc(petID)
          .set(map)
          .then((value) {
        print('#####INSERT SUCCESS $petID');
        Navigator.pop(context);
        // Navigator.pushNamedAndRemoveUntil(
        //     context, '/missingpet', (route) => false);
      });
    });
  }

  Container buildPettype() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.075,
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
                          pettype = items[current];
                          print(pettype);
                        });
                      },
                      child: AnimatedContainer(
                        margin: EdgeInsets.all(5),
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          color: current == index
                              ? MyStyle().primaryColor
                              : MyStyle().secondColor,
                          borderRadius: current == index
                              ? BorderRadius.circular(25)
                              : BorderRadius.circular(20),
                          border: current == index
                              ? Border.all(color: MyStyle().secondColor)
                              : Border.all(color: Colors.white, width: 2),
                        ),
                        duration: Duration(milliseconds: 300),
                        child: Center(
                          child: Text(
                            items[index],
                            style: TextStyle(
                              color: current == index
                                  ? Colors.black
                                  : const Color.fromARGB(255, 77, 76, 76),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: screenWidth * 0.78,
      height: screenHeight * 0.0659,
      child: TextField(
        onChanged: (value) => petname = value.trim(),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: MyStyle().lightColor)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Container buildGender() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.075,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items2.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            current2 = index;
                            petgender = items2[current2];
                            print(petgender);
                          });
                        },
                        child: AnimatedContainer(
                          margin: EdgeInsets.all(5),
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                              color: current2 == index
                                  ? MyStyle().primaryColor
                                  : MyStyle().secondColor,
                              borderRadius: current2 == index
                                  ? BorderRadius.circular(25)
                                  : BorderRadius.circular(20),
                              border: current2 == index
                                  ? Border.all(color: MyStyle().secondColor)
                                  : Border.all(color: Colors.white, width: 2)),
                          duration: Duration(milliseconds: 300),
                          child: Center(
                            child: Text(
                              items2[index],
                              style: TextStyle(
                                  color: current2 == index
                                      ? Colors.black
                                      : const Color.fromARGB(255, 77, 76, 76)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  Container buildColor() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: screenWidth * 0.78,
      height: screenHeight * 0.0659,
      child: TextField(
        onChanged: (value) => petcolor = value.trim(),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: MyStyle().lightColor)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Container buildprovince() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      width: screenWidth * 0.78,
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

  Container BreedandBtn() {
    return Container(
      child: Row(
        children: [
          if (pettype == 'สุนัข') buildDogBreed(),
          if (pettype == 'แมว') buildCatBreed(),
          if (pettype == 'อื่นๆ') buildBreedOther(),
        ],
      ),
    );
  }

  Container buildDogBreed() {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            width: screenWidth * 0.7,
            height: screenHeight * 0.0659,
            child: SingleChildScrollView(
              child: DropdownButtonFormField<String>(
                menuMaxHeight: 300,
                value: dogselected,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                items: Dogbreedlist.map(
                  (e) {
                    return DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    dogselected = value;
                    breed = value;
                    print(breed);
                  });
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(
                          () {
                            Navigator.pop(context);
                          },
                        );
                        print(breed);
                      },
                      child: Text('ยกเลิก'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(
                          () {
                            dogselected = label;
                            breed = dogselected;
                            Navigator.pop(context);
                          },
                        );
                        print(breed);
                      },
                      child: Text('ตกลง'),
                    ),
                  ],
                  title: const Text(
                    'ต้องการกรอกสายพันธุ์สุนัขอัตโนมัติหรือไม่?',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  content: Text(
                    '1.บีเกิล\n2.บูลด็อก\n3.ชิวาวา\n4.คอร์กี้\n5.โดเบอร์แมน\n6.โกลเด้น รีทริฟเวอร์\n7.ชิสุ\n8.ไซบีเรียนฮัสกี้\n9.ไทยหลังอาน\n10.ไทยบางแก้ว\n\n***กรุณา upload รูปก่อนค้นหา***',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.perm_media_outlined,
              size: 28,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Container buildCatBreed() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      width: screenWidth * 0.78,
      height: screenHeight * 0.0659,
      child: SingleChildScrollView(
        child: DropdownButtonFormField(
          menuMaxHeight: 300,
          value: catselected,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          items: Catbreedlist.map(
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
                catselected = value;
                breed = value;
              },
            );
          },
        ),
      ),
    );
  }

  Container buildBreedOther() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      width: screenWidth * 0.78,
      height: screenHeight * 0.0659,
      child: TextField(
        onChanged: (value) =>
            breed == null ? breed = value.trim() : breed = value,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: MyStyle().lightColor)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Container buildMoreinfo() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: screenWidth * 0.78,
      height: screenHeight * 0.11,
      child: TextField(
        maxLines: 3,
        onChanged: (value) => more_info = value.trim(),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: MyStyle().lightColor)),
        ),
      ),
    );
  }

  Container buildTitle1() {
    return Container(
        width: screenWidth * 0.8,
        child: Text('ประเภทสัตว์',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12)));
  }

  Container buildTitle2() {
    return Container(
        width: screenWidth * 0.8,
        child: Text('ชื่อ',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12)));
  }

  Container buildTitle3() {
    return Container(
        width: screenWidth * 0.8,
        child: Text('เพศ',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12)));
  }

  Container buildTitle4() {
    return Container(
        width: screenWidth * 0.8,
        child: Text('สี',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12)));
  }

  Container buildTitle5() {
    return Container(
        margin: EdgeInsets.only(bottom: 5),
        width: screenWidth * 0.8,
        child: Text('สายพันธุ์',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12)));
  }

  Container buildTitle6() {
    return Container(
        width: screenWidth * 0.8,
        child: Text('รายละเอียดเพิ่มเติม',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12)));
  }

  Container buildTitle7() {
    return Container(
        width: screenWidth * 0.8,
        child: Text('จังหวัด',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12)));
  }
}
