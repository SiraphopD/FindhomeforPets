import 'package:findhomeforpets/states/adopter/adopter.dart';
import 'package:findhomeforpets/states/adopter/adopter2.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:findhomeforpets/widgets/dropdown_widget.dart';
import 'package:flutter/material.dart';

class AdopterFilter extends StatefulWidget {
  const AdopterFilter({super.key});

  @override
  State<AdopterFilter> createState() => _AdopterFilterState();
}

class _AdopterFilterState extends State<AdopterFilter> {
  late double screenWidth, screenHeight;
  String? pettypeitem, petgenderitem, provinceitem, breeditem;
  List dogbreed = [
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
  ];
  List catbreed = [
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
  ];
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Adopter()));
              },
            ),
            Text('ค้นหาสัตว์ที่ต้องการรับเลี้ยง'),
          ],
        ),
        backgroundColor: MyStyle().primaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: screenWidth * 0.78,
              child: DropdownWidgetQ(
                  items: ['สุนัข', 'แมว', 'อื่นๆ'],
                  onChanged: (value) {
                    print('--- position ---');
                    print(value);
                    setState(() {
                      pettypeitem = value;
                    });
                  },
                  hint: 'ประเภทของสัตว์',
                  value: pettypeitem),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: screenWidth * 0.78,
              child: DropdownWidgetQ(
                  items: ['ทั้งหมด', 'ผู้', 'เมีย'],
                  onChanged: (value) {
                    print('--- position ---');
                    print(value);

                    setState(() {
                      petgenderitem = value;
                    });
                  },
                  hint: 'เพศ',
                  value: petgenderitem),
            ),
            SizedBox(
              height: 20,
            ),
            pettypeitem == 'สุนัข'
                ? Container(
                    width: screenWidth * 0.78,
                    child: DropdownWidgetQ(
                        items: dogbreed,
                        onChanged: (value) {
                          print('--- position ---');
                          print(value);
                          setState(() {
                            breeditem = value.toString();
                          });
                        },
                        hint: 'สายพันธุ์',
                        value: breeditem),
                  )
                : pettypeitem == 'แมว'
                    ? Container(
                        width: screenWidth * 0.78,
                        child: DropdownWidgetQ(
                            items: catbreed,
                            onChanged: (value) {
                              print('--- position ---');
                              print(value);
                              setState(() {
                                breeditem = value.toString();
                              });
                            },
                            hint: 'สายพันธุ์',
                            value: breeditem),
                      )
                    : SizedBox(
                        height: 1,
                      ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: screenWidth * 0.78,
              child: DropdownWidgetQ(
                  items: [
                    'ทั้งหมด',
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
                  ],
                  onChanged: (value) {
                    print('--- position ---');
                    print(value);
                    setState(() {
                      provinceitem = value;
                    });
                  },
                  hint: 'จังหวัด',
                  value: provinceitem),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                  color: MyStyle().primaryColor,
                  borderRadius: BorderRadius.circular(180)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Adopter2(
                                  pettypeitem: pettypeitem.toString(),
                                  petgenderitem: petgenderitem.toString(),
                                  provinceitem: provinceitem.toString(),
                                  breeditem: breeditem.toString())));
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    label: Text('ค้นหา', style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
