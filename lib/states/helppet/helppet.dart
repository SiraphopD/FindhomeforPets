import 'package:findhomeforpets/states/helppet/helppet_all.dart';
import 'package:findhomeforpets/states/helppet/helppet_cat.dart';
import 'package:findhomeforpets/states/helppet/helppet_dog.dart';
import 'package:findhomeforpets/states/helppet/helppet_other.dart';
import 'package:findhomeforpets/utility/my_style.dart';
import 'package:flutter/material.dart';

class Helppet extends StatefulWidget {
  const Helppet({super.key});

  @override
  State<Helppet> createState() => _HelppetState();
}

class _HelppetState extends State<Helppet> {
  double? screenWidth, screenHeight;
  List<String> items = ['ทั้งหมด', 'สุนัข', 'แมว', 'อื่นๆ'];
  int current = 0;

  void initState() {
    super.initState();
    // readData();
  }

  late int currentIndex = 0;
  List widgetOptions = [
    HelpPet_all(),
    HelpPet_dog(),
    HelpPet_cat(),
    HelpPet_other(),
  ];
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('ช่วยเหลือสัตว์'),
          backgroundColor: MyStyle().primaryColor,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () => Navigator.pushNamed(context, '/posthelppet'))
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(2),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight! * 0.075,
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
                                // if (current == 0) {
                                //   readAdopterData();
                                // }
                                // if (current == 1) {
                                //   readMissingpetData();
                                // }
                                // if (current == 2) {
                                //   readHelppetData();
                                // }
                              });
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.only(top: 10, right: 4),
                              width: screenWidth! * 0.3,
                              height: screenHeight! * 0.06,
                              decoration: BoxDecoration(
                                color: current == index
                                    ? MyStyle().primaryColor
                                    : MyStyle().secondColor,
                                borderRadius: current == index
                                    ? BorderRadius.circular(25)
                                    : BorderRadius.circular(20),
                              ),
                              duration: Duration(milliseconds: 300),
                              child: Center(
                                child: Text(
                                  items[index],
                                  style: TextStyle(
                                      color: current == index
                                          ? Colors.black
                                          : const Color.fromARGB(
                                              255, 77, 76, 76)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1),
                width: double.infinity,
                height: screenHeight! * 0.79,
                child: widgetOptions[currentIndex = current],
              )
            ],
          ),
        ));
  }
}
