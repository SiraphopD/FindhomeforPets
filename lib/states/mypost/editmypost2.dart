import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findhomeforpets/models/pet_model.dart';
import 'package:findhomeforpets/states/mypost/mypost.dart';
import 'package:findhomeforpets/utility/dialog.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite_v2/tflite_v2.dart';

class Editmypost2 extends StatefulWidget {
  final PetModel petModel;
  const Editmypost2({Key? key, required this.petModel}) : super(key: key);

  @override
  State<Editmypost2> createState() => _Editmypost1State();
}

class _Editmypost1State extends State<Editmypost2> {
  late PetModel model;
  late double screenWidth, screenHeight;

  String? pettype,
      petname,
      petgender,
      petcolor,
      breed,
      more_info,
      PathImage,
      petID,
      province,
      newpettype,
      newpetname,
      newpetgender,
      newpetcolor,
      newbreed,
      newmoreinfo,
      newprovince,
      newPathImage,
      urlPicture,
      dogselected = '--โปรดเลือกสายพันธุ์--',
      catselected = '--โปรดเลือกสายพันธุ์--',
      provinceselected,
      label = '--โปรดเลือกสายพันธุ์--';

  final pettypecoltroller = TextEditingController();
  final petnamecontroller = TextEditingController();
  final petgendercontroller = TextEditingController();
  final provincecontroller = TextEditingController();
  final petcolorcontroller = TextEditingController();
  final breedcontroller = TextEditingController();
  final more_infocontroller = TextEditingController();
  File? file, file1;
  List items = ['สุนัข', 'แมว', 'อื่นๆ'];
  List items2 = ['ผู้', 'เมีย'];
  int current = 0, current2 = 0;
  late double edgeall, high;
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
      provinceall = [
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
    model = widget.petModel;
    pettype = model.pettype;
    PathImage = model.PathImage;
    petname = model.petname;
    petgender = model.petgender;
    petcolor = model.petcolor;
    breed = model.breed;
    province = model.province;
    more_info = model.more_info;
    petID = model.petID;
    pettypecoltroller.text = model.pettype;
    petnamecontroller.text = model.petname;
    petgendercontroller.text = model.petgender;
    provincecontroller.text = model.province;
    petcolorcontroller.text = model.petcolor;
    breedcontroller.text = model.breed;
    more_infocontroller.text = model.more_info;
    for (int i = 0; i < items.length; i++) {
      if (items[i] == pettype) {
        setState(() {
          current = i;
        });
        break;
      }
    }

    for (int i = 0; i < items.length; i++) {
      if (items2[i] == petgender) {
        setState(() {
          current2 = i;
        });
        break;
      }
    }
    for (int i = 0; i < Catbreedlist.length; i++) {
      setState(() {
        if (breed == Catbreedlist[i]) {
          catselected = breed;
        }
      });
    }

    for (int i = 0; i < Dogbreedlist.length; i++) {
      setState(() {
        if (breed == Dogbreedlist[i]) {
          dogselected = breed;
        }
      });
    }

    for (int i = 0; i < provinceall.length; i++) {
      if (province == provinceall[i]) {
        setState(() {
          provinceselected = province;
          print(provinceselected);
        });
      }
    }
    chooseImageinitial(model.PathImage);
    _tfLteInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    if (pettype == 'สุนัข' || pettype == 'แมว') {
      high = 0.17;
      edgeall = 25;
    } else {
      high = 0.18;
      edgeall = 18;
    }
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('แก้ไขโพสต์'),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(right: 15, left: 15, top: 20),
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.15,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [buildTitle1(), buildPettype()],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(right: 15, left: 15, top: 20),
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.18,
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
                      children: [buildPetName()],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(right: 15, left: 15, top: 20),
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.15,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [buildTitle3(), buildPetGender()],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(right: 15, left: 15, top: 20),
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.18,
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
                      children: [buildPetColor()],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(edgeall),
                    margin: EdgeInsets.only(right: 15, left: 15, top: 20),
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.18,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildTitle5(),
                        if (pettype == 'สุนัข') buildDogBreed(),
                        if (pettype == 'แมว') buildCatBreed(),
                        if (pettype == 'อื่นๆ') buildBreedOther(),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(25),
                    margin: EdgeInsets.only(right: 15, left: 15, top: 20),
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.18,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [buildTitle9(), buildProvince()],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.only(right: 15, left: 15, top: 20),
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.25,
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
                      children: [buildMoreinfo()],
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
                        margin: EdgeInsets.only(left: 15, right: 5),
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

  Container buildPetGender() {
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
                          margin: EdgeInsets.only(left: 15, right: 5),
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

  Column buildPetName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTitle2(),
        Container(
          width: screenWidth * 0.78,
          height: screenHeight * 0.09,
          child: TextFormField(
            maxLines: 1,
            controller: petnamecontroller,
            keyboardType: TextInputType.name,
            onChanged: (value) => newpetname = value.trim(),
            decoration: InputDecoration(
              labelStyle: MyStyle().darkStyle(),
              hintText: '$petname',
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
        ),
      ],
    );
  }

  Column buildPetColor() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildTitle4(),
        Container(
          width: screenWidth * 0.78,
          height: screenHeight * 0.09,
          child: TextFormField(
            maxLines: 1,
            controller: petcolorcontroller,
            keyboardType: TextInputType.name,
            onChanged: (value) => newpetcolor = value.trim(),
            decoration: InputDecoration(
              labelStyle: MyStyle().darkStyle(),
              hintText: '$petcolor',
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
        ),
      ],
    );
  }

  Container buildDogBreed() {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            width: screenWidth * 0.55,
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
                            print(label);
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
                    '1.บีเกิล\n2.บูลด็อก\n3.ชิวาวา\n4.คอร์กี้\n5.โดเบอร์แมน\n6.โกลเด้น รีทริฟเวอร์\n7.ชิสุ\n8.ไซบีเรียนฮัสกี้\n9.ไทยหลังอาน\n10.ไทยบางแก้ว',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.perm_media_outlined,
              size: 30,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Container buildCatBreed() {
    return Container(
      margin: EdgeInsets.only(left: 13, right: 13),
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
      width: screenWidth * 0.78,
      height: screenHeight * 0.09,
      child: TextField(
        maxLines: 1,
        controller: breedcontroller,
        onChanged: (value) =>
            breed == null ? breed = value.trim() : breed = value,
        decoration: InputDecoration(
          hintText: '$breed',
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

  Container buildProvince() {
    return Container(
      margin: EdgeInsets.only(left: 13, right: 13),
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
          items: provinceall.map(
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
                province = provinceselected;
              },
            );
          },
        ),
      ),
    );
  }

  Column buildMoreinfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildTitle6(),
        Container(
          width: screenWidth * 0.78,
          height: screenHeight * 0.145,
          child: TextFormField(
            maxLines: 5,
            controller: more_infocontroller,
            keyboardType: TextInputType.text,
            onChanged: (value) => newmoreinfo = value.trim(),
            decoration: InputDecoration(
              labelStyle: MyStyle().darkStyle(),
              hintText: '$more_info',
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
        ),
      ],
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
                  : Image.network(model.PathImage)
              : Image.file(file!)),
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
        file = File(object.path);
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

  Future<void> chooseImageinitial(String imageURL) async {
    try {
      final Directory tempDir = await getTemporaryDirectory();
      final String imagePath = '${tempDir.path}/temp_image.jpg';

      final http.Response response = await http.get(Uri.parse(imageURL));
      final File imageFile = File(imagePath);
      await imageFile.writeAsBytes(response.bodyBytes);

      final XFile? object = XFile(imagePath);
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
        asynch: true, // defaults to true
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
        firebaseStorage.ref().child('missingpet/mpets$i.jpg');
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
              if (newpettype?.isEmpty ?? true) {
                newpettype = pettype;
              }
              if (newpetname?.isEmpty ?? true) {
                newpetname = petname;
              }

              if (newpetgender?.isEmpty ?? true) {
                newpetgender = petgender;
              }
              if (newpetcolor?.isEmpty ?? true) {
                newpetcolor = petcolor;
              }
              // if (newbreed?.isEmpty ?? true) {
              //   newbreed = breed;
              // }
              if (newprovince?.isEmpty ?? true) {
                newprovince = province;
              }
              if (newmoreinfo?.isEmpty ?? true) {
                newmoreinfo = more_info;
              }
              if ((pettype == 'สุนัข' &&
                      (dogselected == '--โปรดเลือกสายพันธุ์--')) ||
                  (pettype == 'แมว' &&
                      (catselected == '--โปรดเลือกสายพันธุ์--')) ||
                  (pettype == 'อื่นๆ' && (breed?.isEmpty ?? true))) {
                print('Have Space');
                normailDialog(
                    context, 'กรอกข้อมูลไม่ครบ', 'กรุณาระบุสายพันธุ์');
              } else {
                updatepettype();
              }

              // Navigator.pushNamedAndRemoveUntil(
              //     context, '/Mypost;', ModalRoute.withName('/home'));
            },
            icon: Icon(Icons.cloud_upload),
            label: Text('บันทึก')));
  }

  Future<void> updatepettype() async {
    await FirebaseFirestore.instance
        .collection('missingpet')
        .doc(petID)
        .update({'pettype': newpettype}).then((value) {
      print('#########UPDATE SUCCESS :${pettype}');
      // Navigator.pop(context);
      updatepetname();
    });
  }

  Future<void> updatepetname() async {
    await FirebaseFirestore.instance
        .collection('missingpet')
        .doc(petID)
        .update({'petname': newpetname}).then((value) {
      print('#########UPDATE SUCCESS :${petname}');
      updatepetgender();
    });
  }

  Future<void> updatepetgender() async {
    await FirebaseFirestore.instance
        .collection('missingpet')
        .doc(petID)
        .update({'petgender': newpetgender}).then((value) {
      print('#########UPDATE SUCCESS :${petgender}');
      updatecolor();
    });
  }

  Future<void> updatecolor() async {
    await FirebaseFirestore.instance
        .collection('missingpet')
        .doc(petID)
        .update({'petcolor': newpetcolor}).then((value) {
      print('#########UPDATE SUCCESS :${petcolor}');
      updatebreed();
    });
  }

  Future<void> updatebreed() async {
    await FirebaseFirestore.instance
        .collection('missingpet')
        .doc(petID)
        .update({'breed': breed}).then((value) {
      print('#########UPDATE SUCCESS :${breed}');
      // setState(() {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => Editmypost(petModel: model)));
      // });
      updateprovince();
    });
  }

  Future<void> updateprovince() async {
    await FirebaseFirestore.instance
        .collection('missingpet')
        .doc(petID)
        .update({'province': newprovince}).then((value) {
      print('#########UPDATE SUCCESS :${province}');
      updatemoreinfo();
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => Editmypost(petModel: model)));
    });
  }

  Future<void> updatemoreinfo() async {
    await FirebaseFirestore.instance
        .collection('missingpet')
        .doc(petID)
        .update({'more_info': newmoreinfo}).then((value) {
      print('#########UPDATE SUCCESS :${more_info}');

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyPost()));
    });
  }

  Future<void> updatepathimage() async {
    await FirebaseFirestore.instance
        .collection('missingpet')
        .doc(petID)
        .update({'PathImage': urlPicture}).then((value) {
      print('#########UPDATE SUCCESS :${PathImage}');
      Navigator.pop(context);
    });
  }

  Container buildTitle1() {
    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.019,
      child: Text(
        'ประเภทสัตว์',
        style: TextStyle(
          color: MyStyle().darkColor,
          fontSize: 12,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Container buildTitle2() {
    return Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.02,
        child: Text(
          'ชื่อ',
          style: TextStyle(color: MyStyle().darkColor, fontSize: 12),
          textAlign: TextAlign.left,
        ));
  }

  Container buildTitle3() {
    return Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.019,
        child: Text('เพศ',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12),
            textAlign: TextAlign.left));
  }

  Container buildTitle4() {
    return Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.02,
        child: Text('สี',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12),
            textAlign: TextAlign.left));
  }

  Container buildTitle5() {
    return Container(
        margin: EdgeInsets.only(bottom: 5),
        width: screenWidth * 0.8,
        height: screenHeight * 0.02,
        child: Text('สายพันธุ์',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12),
            textAlign: TextAlign.left));
  }

  Container buildTitle6() {
    return Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.02,
        child: Text('รายละเอียดเพิ่มเติม',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12),
            textAlign: TextAlign.center));
  }

  Container buildTitle7() {
    return Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.035,
        child: Text('อายุ',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12),
            textAlign: TextAlign.left));
  }

  Container buildTitle8() {
    return Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.02,
        child: Text('ประวัติการฉีดวัคซีน',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12),
            textAlign: TextAlign.left));
  }

  Container buildTitle9() {
    return Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.02,
        child: Text('จังหวัด',
            style: TextStyle(color: MyStyle().darkColor, fontSize: 12),
            textAlign: TextAlign.left));
  }
}
