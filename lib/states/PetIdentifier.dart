import 'dart:io';
import 'package:findhomeforpets/states/BreedDetail.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class PetIdentifier extends StatefulWidget {
  const PetIdentifier({super.key});

  @override
  State<PetIdentifier> createState() => _PetIdentifierState();
}

class _PetIdentifierState extends State<PetIdentifier> {
  File? filePath;
  String label = '';
  double confidence = 0.0, customheight = 318;
  late double screenWidth, screenHeight;
  Future<void> _tfLteInit() async {
    String? res = await Tflite.loadModel(
        //run model
        model: "assets/RMSwithMobilenetV2.tflite",
        labels: "assets/labelst.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  pickImageGallery() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800.0,
      maxHeight: 800.0,
    );

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
      // setขนาดรูปภาพใน model
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 1,
      threshold: 0.2,
      asynch: true,
    );

    if (recognitions == null) {
      print("recognitions is Null");
      return;
    }
    print(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100); // ค่าความแม่นยำ
      label = recognitions[0]['label'].toString();
    });
  }

  pickImageCamera() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 800.0,
      maxHeight: 800.0,
    );

    if (image == null) return;

    var imageMap = File(image.path);

    setState(() {
      filePath = imageMap;
    });

    var recognitions = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 10, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    if (recognitions == null) {
      print("recognitions is Null");
      return;
    }
    print(recognitions.toString());
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
    });
  }

  @override
  void dispose() {
    super.dispose(); //หน่วยความจำ
    Tflite.close();
  }

  @override
  void initState() {
    //เปิดmodelขึ้นมาตอนเริ่ม
    super.initState();
    _tfLteInit();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    if (label.isEmpty) {
      customheight = 318;
    } else {
      customheight = 400;
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("ค้นหาสายพันธุ์สุนัขอัตโนมัติ"),
          ],
        ),
        backgroundColor: MyStyle().primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              buildcontent(),
              buildselectfromcamera(),
              buildselectfromgallery(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildcontent() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        elevation: 20,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: 300,
          height: customheight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 18)),
                Container(
                  height: 280,
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/upload.jpg'),
                    ),
                  ),
                  child: filePath == null
                      ? const Text('')
                      : Image.file(
                          filePath!,
                          fit: BoxFit.fill,
                        ),
                ),
                if (label.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BreedDetail(label: label),
                              ),
                            );
                          },
                          child: Text('รายละเอียด'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildselectfromcamera() {
    return Container(
      padding: EdgeInsets.only(top: 8, left: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.5,
            height: screenHeight * 0.07,
            child: ElevatedButton(
              onPressed: () {
                pickImageCamera();
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(left: 25, right: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: MyStyle().secondColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt_outlined),
                  Text(
                    "  ถ่ายรูป",
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  contentPadding: const EdgeInsets.all(18),
                  title: Text('สามารถสแกนได้ 10 สายพันธุ์'),
                  content: Container(
                    height: screenHeight * 0.38,
                    child: Text(
                      '1.บีเกิล\n2.บูลด็อก\n3.ชิวาวา\n4.คอร์กี้\n5.โดเบอร์แมน\n6.โกลเด้น รีทริฟเวอร์\n7.ชิสุ\n8.ไซบีเรียนฮัสกี้\n9.ไทยหลังอาน\n10.ไทยบางแก้ว',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              );
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }

  Container buildselectfromgallery() {
    return Container(
      width: screenWidth * 0.5,
      height: screenHeight * 0.08,
      padding: EdgeInsets.only(top: 8),
      child: ElevatedButton(
        onPressed: () {
          pickImageGallery();
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(left: 12, right: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            foregroundColor: Colors.black,
            backgroundColor: MyStyle().secondColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_outlined),
            const Text(
              "  เลือกรูปจาก Gallery",
            ),
          ],
        ),
      ),
    );
  }
}
