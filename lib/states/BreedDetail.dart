import 'package:findhomeforpets/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BreedDetail extends StatefulWidget {
  final String label;
  const BreedDetail({super.key, required this.label});

  @override
  State<BreedDetail> createState() => _BreedDetailState();
}

class _BreedDetailState extends State<BreedDetail> {
  late double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    print(widget.label);
    return Scaffold(
      appBar: AppBar(
          //backgroundColor: MyStyle().primaryColor,
          ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.label == 'บีเกิล')
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/Breedpic/Beagle.jpg'),
                          ),
                        ),
                      ),
                      buildbeagle()
                    ],
                  ),
                ),
              if (widget.label == 'บูลด็อก')
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/Breedpic/Bulldog1.jpg'),
                          ),
                        ),
                      ),
                      buildbulldog(),
                    ],
                  ),
                ),
              if (widget.label == 'ชิวาวา')
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/Breedpic/chihuahua.jpg'),
                          ),
                        ),
                      ),
                      buildchihuahua(),
                    ],
                  ),
                ),
              if (widget.label == 'คอร์กี้')
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/Breedpic/Corgi.jpg'),
                          ),
                        ),
                      ),
                      buildcorgi(),
                    ],
                  ),
                ),
              if (widget.label == 'โดเบอร์แมน')
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/Breedpic/Doberman.jpg'),
                          ),
                        ),
                      ),
                      builddoberman(),
                    ],
                  ),
                ),
              if (widget.label == 'โกลเด้น รีทริฟเวอร์')
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/Breedpic/Retriever.jpg'),
                          ),
                        ),
                      ),
                      buildretriever(),
                    ],
                  ),
                ),
              if (widget.label == 'ชิสุ')
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/Breedpic/Shihtzu.jpeg'),
                          ),
                        ),
                      ),
                      buildshihtzu()
                    ],
                  ),
                ),
              if (widget.label == 'ไซบีเรียนฮัสกี้')
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/Breedpic/Husky.jpg'),
                          ),
                        ),
                      ),
                      buildhusky(),
                    ],
                  ),
                ),
              if (widget.label == 'ไทยหลังอาน')
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/Breedpic/Ridgeback.jpg'),
                          ),
                        ),
                      ),
                      buildridgeback(),
                    ],
                  ),
                ),
              if (widget.label == 'ไทยบางแก้ว')
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.8,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/Breedpic/Bangkaew.jpg'),
                          ),
                        ),
                      ),
                      buildbangkaew(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildchihuahua() {
    return Container(
      child: Card(
        color: MyStyle().secondColor,
        child: SizedBox(
          width: screenWidth * 0.85,
          height: screenHeight * 0.65,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(
                      'สายพันธุ์ : ${widget.label}',
                      style: const TextStyle(
                        fontSize: 30,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'รายละเอียด :ชิวาวาพบได้ทั้งพันธุ์ขนสั้นและขนยาว หัวกลมคล้ายลูกแอปเปิ้ล ขนบริเวณศีรษะและหูนุ่มละเอียด ตากลมและโต ใบหูใหญ่ตั้งตรง หางยาว',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ลักษณะนิสัย : ชอบเป็นจุดสนใจ และจงรักภักดีต่อเจ้าของมาก เป็นสุนัขตัวเล็กแต่ใจใหญ่ กล้าหาญ ในขณะเดียวกันก็ชอบใกล้ชิดกับผู้คน มีชีวิตชีวา และแอบซุกซน แต่บางตัวก็ขี้อายและชอบเก็บตัวเช่นเดียวกับสุนัขพันธุ์อื่นควรฝึกให้พวกเค้าทำความรู้จักกับผู้คน สภาพแวดล้อมใหม่ ๆ ชิวาวามักจะรู้สึกไม่ปลอดภัยเมื่อเจอคนแปลกหน้า ซึ่งอาจนำไปสู่การขู่และกัดได้',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'อายุ : 12 – 20 ปี',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'น้ำหนัก : โดยเฉลี่ย 1.8 – 4.1 กก.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ความสูง : 15 – 30 ซม.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildbeagle() {
    return Container(
      child: Card(
        color: MyStyle().secondColor,
        child: SizedBox(
          width: screenWidth * 0.85,
          height: screenHeight * 0.65,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(
                      'สายพันธุ์ : ${widget.label}',
                      style: const TextStyle(
                        fontSize: 30,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'รายละเอียด : เป็นสุนัขสายพันธุ์กลาง ขึ้นชื่อเรื่องความเฉลียวฉลาด จุดเด่นของบีเกิ้ลคือใบหูที่พับลงมาชิดกับหัว และดวงตากลมโตที่พร้อมจะละลายใจทุกคนที่เผลอมาสบตา ถึงแม้พวกเค้าจะมีขนสั้น ไม่หนา แต่มีขนร่วงบ่อย',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ลักษณะนิสัย : อุปนิสัยที่โดดเด่นเลยคือ ความร่าเริง สดใส และซุกซน พวกเค้าเป็นเพื่อนเล่นที่ดีทั้งกับเด็กและผู้ใหญ่ พวกเค้าไม่ชอบอยู่ตามลำพังเป็นเวลานานๆและอีกหนึ่งพฤติกรรมที่พบได้ของบีเกิ้ลคือเห่าเก่งเพราะพวกเค้ามีนิสัยตื่นตัวและมีประสาทการรับรู้ที่ไวมาก',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'อายุขัย : 12 – 15 ปี',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'น้ำหนัก : โดยเฉลี่ย 10 – 11.3 กก.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ความสูง : 33 - 38 ซม.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildbulldog() {
    return Container(
      child: Card(
        color: MyStyle().secondColor,
        child: SizedBox(
          width: screenWidth * 0.85,
          height: screenHeight * 0.6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(
                      'สายพันธุ์ : ${widget.label}',
                      style: const TextStyle(
                        fontSize: 30,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'รายละเอียด : ขึ้นชื่อเรื่องรูปร่างกำยำ ขาสั้น กล้ามเนื้อแน่น แต่อาจมีน้ำหนักเกินเล็กน้อยเมื่อเทียบกับส่วนสูง บูลด็อกมีขนสั้น เรียบและเงางาม',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ลักษณะนิสัย : คนส่วนใหญ่มักจะเข้าใจผิดว่าสุนัขพันธุ์บูลด็อกมีอารมณ์ร้ายและเมินเฉย แต่ความจริงนั้น พวกเค้าน่ารัก อ่อนโยน และว่านอนสอนง่าย แม้จะเชื่อฟังแต่ก็ไม่ได้หัวอ่อน พวกเค้ามีความกล้าหาญและแอบดื้อรั้นในบางครั้ง',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'อายุขัย : 8 – 10 ปี',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'น้ำหนัก : โดยเฉลี่ย 18 – 30 กก.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ความสูง : 40 ซม. ขึ้นไป',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildcorgi() {
    return Container(
      child: Card(
        color: MyStyle().secondColor,
        child: SizedBox(
          width: screenWidth * 0.85,
          height: screenHeight * 0.65,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(
                      'สายพันธุ์ : ${widget.label}',
                      style: const TextStyle(
                        fontSize: 30,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'รายละเอียด : เป็นสุนัขพันธุ์เล็ก ใบหน้าคล้ายสุนัขจิ้งจอก หูตั้งขึ้น มี 2 สายพันธุ์ คือ พ็อมโบรค เวล์ช(หางสั้น) และ คาร์ดิแกน เวล์ช(หางยาว)',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ลักษณะนิสัย : นิสัยของคอร์กี้ที่เด่นชัดคือมีความฉลาด กล้าหาญ กระตือรือร้น ร่าเริง มีพลังงานสูง ไม่ชอบอยู่นิ่งๆ มักชอบคิดว่าตัวเองเป็นหมาร่างใหญ่อยู่เสมอ และอาจมีพฤติกรรมก้าวร้าวได้หากถูกปล่อยไว้ให้อยู่ตามลำพังมากเกินไปหรือไม่ได้รับการออกกำลังกายเพื่อปลดปล่อยพลังมากที่เพียงพอ มักแสดงออกด้วยการเห่า ขุด หรือกัดแทะสิ่งของ',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'อายุขัย : 17 ปี',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'น้ำหนัก : โดยเฉลี่ย 10 – 12 กก.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ความสูง : พ็อมโบรคจะมีความสูงเฉลี่ยอยู่ที่ 26 -31 ซม. และคาร์ดิแกนจะมีความสูงเฉลี่ยอยู่ที่ 30 ซม.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container builddoberman() {
    return Container(
      child: Card(
        color: MyStyle().secondColor,
        child: SizedBox(
          width: screenWidth * 0.85,
          height: screenHeight * 0.6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(
                      'สายพันธุ์ : ${widget.label}',
                      style: const TextStyle(
                        fontSize: 30,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'รายละเอียด : โดเบอร์แมนมีขนสั้นและเรียบ พวกเค้ามีรูปร่างผอมเพรียว มีแต้มสีน้ำตาลที่หู ปาก ขา และเท้า ส่วนที่เหลือถูกปกคลุมไปด้วยสีดำเข้ม ทั้งนี้เราอาจพบโดเบอร์แมนในเฉดสีอื่นได้เช่นกัน',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ลักษณะนิสัย : โดเบอร์แมนมีความจงรักภักดี กล้าหาญ และเฉลียวฉลาด แต่ผู้เลี้ยงต้องมีความอดทน มีเวลา และมีความเอาใจใส่สูง',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'อายุขัย : 10 – 12 ปี',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'น้ำหนัก : โดยเฉลี่ย 27 – 46 กก.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ความสูง : 61 - 71 ซม.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildretriever() {
    return Container(
      child: Card(
        color: MyStyle().secondColor,
        child: SizedBox(
          width: screenWidth * 0.85,
          height: screenHeight * 0.65,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(
                      'สายพันธุ์ : ${widget.label}',
                      style: const TextStyle(
                        fontSize: 25,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'รายละเอียด : พวกเค้ามีขนาดหัวใหญ่และกว้าง ใบหูห้อยยาวลงไปถึงบริเวณสันกราม ขนหนาเงางาม มีโครงสร้างร่างกายที่แข็งแรง บึกบึน และมีสีขนถึง 3 เฉดสีด้วยกัน(สีน้ำตาลทองเข้ม สีน้ำตาลทอง สีน้ำตาลทองอ่อน)',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ลักษณะนิสัย : นิสัยเป็นมิตร เราสามารถปล่อยให้โกลเด้น รีทรีฟเวอร์อยู่ร่วมกับเด็ก ๆ ได้โดยไร้กังวลฝึกได้ง่าย และชอบเอาใจเจ้าของด้วยการเรียนรู้ทริคต่าง ๆ อย่างรวดเร็ว สุนัขพันธุ์นี้มีแนวโน้มที่จะกัดแทะสิ่งของ โกลเด้นจะเห่าเมื่อจำเป็นเท่านั้น',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'อายุขัย : 10 – 12 ปี',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'น้ำหนัก : โดยเฉลี่ย 24.9 – 34 กก.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ความสูง : 54 - 61 ซม.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildshihtzu() {
    return Container(
      child: Card(
        color: MyStyle().secondColor,
        child: SizedBox(
          width: screenWidth * 0.85,
          height: screenHeight * 0.65,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(
                      'สายพันธุ์ : ${widget.label}',
                      style: const TextStyle(
                        fontSize: 30,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'รายละเอียด : สุนัขขนาดเล็ก ขนยาวจรดพื้น โครงสร้างมีลักษณะเป็นรูปสี่เหลี่ยมผืนผ้า มีความยาวลำตัวมากกว่าความสูง กว้างและลึก เส้นกลางหลังตรงไม่โค้ง ศีรษะมีลักษณะกว้างกลม',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ลักษณะนิสัย : อุปนิสัยที่โดดเด่นที่สุดคือความเป็นมิตร และน้อยครั้งที่พวกเค้าจะแสดงอาการหงุดหงิดออกมา ชิสุขึ้นชื่อเรื่องความอ่อนโยนต้องการความรัก ชอบกอดและคลอเคลียมากซึ่งทำให้พวกเค้าเป็นเพื่อนแก้เหงาที่ดี นอกจากนี้ชิสุห์ยังไม่ค่อยน้ำลายไหล แต่อาจเห่าบ่อยครั้งเพื่อเรียกร้องความสนใจ',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'อายุ : 10 - 18 ปี',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'น้ำหนัก : โดยเฉลี่ย 4.5 – 8.1 กก.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ความสูง : 20 - 28 ซม.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildhusky() {
    return Container(
      child: Card(
        color: MyStyle().secondColor,
        child: SizedBox(
          width: screenWidth * 0.85,
          height: screenHeight * 0.65,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(
                      'สายพันธุ์ : ${widget.label}',
                      style: const TextStyle(
                        fontSize: 30,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'รายละเอียด : ไซบีเรียน ฮัสกี้เป็นสุนัขพันธุ์กลางที่มีขนหนาสองชั้น ขนตรงมีความยาวปานกลาง หูตั้งตลอดเวลา ใบหูเป็นทรงสามเหลี่ยมดวงตาโดดเด่นอาจมีสีฟ้าหรือสีน้ำตาล',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ลักษณะนิสัย : อ่อนโยน เป็นมิตร และจงรักภักดีกับครอบครัวมาก พวกเค้าขี้เล่น ร่าเริง พลังงานสูง และมักมีอารมณ์ดีอยู่เสมอ น้องหมาพันธุ์นี้ยังเข้ากับเด็กและสัตว์เลี้ยงในบ้านได้ดีอีกด้วย ไซบีเรียน ฮัสกี้ไม่ค่อยเห่า แต่ส่วนใหญ่จะใช้เสียงหอนในการสื่อสาร พวกเค้าอาจมีน้ำลายไหลบ้าง เมื่อรู้สึกหิว วิตกกังวล หรือร้อน',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'อายุขัย : 12 – 15 ปี',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'น้ำหนัก : โดยเฉลี่ย 5.5 – 7 กก.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ความสูง : 50 – 58 ซม.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildridgeback() {
    return Container(
      child: Card(
        color: MyStyle().secondColor,
        child: SizedBox(
          width: screenWidth * 0.85,
          height: screenHeight * 0.65,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(
                      'สายพันธุ์ : ${widget.label}',
                      style: const TextStyle(
                        fontSize: 30,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'รายละเอียด : มีขนาดกลางขนสั้นหูตั้งเป็นรูปสามเหลี่ยมปลายจมูกสีดำและปากรูปลิ่มหางเรียวยาวเป็นรูปดาบ ลักษณะเด่นคือมีอานซึ่งเกิดจากขนขึ้นในแนวย้อนกับแนวขนปกติอยู่บนหลัง',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ลักษณะนิสัย : ซื่อสัตย์ จงรักดี นอกจากนี้ยังมีความเฉลียวฉลาด มั่นใจในตัวเองสูง มีความเป็นผู้นำ รักอิสระ กล้าหาญ พวกเขามีสัญชาตญาณของการระมัดระวังคอยเตือนภัยสิ่งแปลกปลอมได้อย่างดีเยี่ยมจึงเหมาะไว้ดูเฝ้าแลครอบครัว บ้าน และทรัพย์สิน',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'อายุขัย : 10-12 ปี',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'น้ำหนัก : โดยเฉลี่ย 16 - 34 กก.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ความสูง : 51 - 61 ซม.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildbangkaew() {
    return Container(
      child: Card(
        color: MyStyle().secondColor,
        child: SizedBox(
          width: screenWidth * 0.85,
          height: screenHeight * 0.65,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text(
                      'สายพันธุ์ : ${widget.label}',
                      style: const TextStyle(
                        fontSize: 30,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'รายละเอียด : มีขนปุยยาว มีความสง่างาม ว่องไวและแข็งแรง เวลายืนมักเชิดหน้าและโก่งคอคล้ายม้า เป็นสุนัขขนาดกลาง รูปทรงตั้งแต่ช่วงขาหน้าถึงขาหลังเป็นสี่เหลี่ยมจัตุรัส อกกว้างและลึกได้ระดับกับข้อศอก ไหล่กว้าง ท้องไม่คอดกิ่ว หน้าแหลม หูเล็ก หางพวง ขนมีสองชั้น',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ลักษณะนิสัย : ค่อนข้างตื่นตัว หวงสิ่งของและหวงเจ้าของ ร่าเริง กล้าหาญ เชื่อมั่นในตัวเอง ไม่ขี้กลัวหรือตื่นตกใจง่าย ซื่อสัตย์ ฉลาด',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'อายุขัย : 10 - 12 ปี',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'น้ำหนัก : โดยเฉลี่ย 16 - 20 กก.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'ความสูง : 38 - 53 ซม.',
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
