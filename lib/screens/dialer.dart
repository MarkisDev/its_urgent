import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../widgets/rating.dart';

class DialerPage extends StatefulWidget {
  const DialerPage({Key? key}) : super(key: key);
  @override
  DialerPageState createState() => DialerPageState();
}

class DialerPageState extends State<DialerPage> {
  String display = '';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dialer"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15.h),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  display,
                  textScaleFactor: 0.9.sp,
                  style: TextStyle(
                      fontSize: 23.sp,
                      color: HexColor('#12b562'),
                      fontWeight: FontWeight.bold),
                ),
              ),
              trailing: SizedBox(
                width: 7.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onLongPress: () {
                          if (display.isNotEmpty) {
                            setState(() {
                              display = display.substring(
                                  0, display.length - display.length);
                            });
                          }
                        },
                        onTap: () {
                          if (display.isNotEmpty) {
                            setState(() {
                              display =
                                  display.substring(0, display.length - 1);
                            });
                          }
                        },
                        child: Center(
                          child: Icon(
                            Icons.backspace,
                            size: 7.w,
                            color: HexColor('#bfbfbf'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(height: 0.8.h),
            Row(
              children: [
                dialPadButton(size, '1', color: HexColor('#000000')),
                dialPadButton(size, '2', color: HexColor('#000000')),
                dialPadButton(size, '3', color: HexColor('#000000'))
              ],
            ),
            Row(
              children: [
                dialPadButton(size, '4', color: HexColor('#000000')),
                dialPadButton(size, '5', color: HexColor('#000000')),
                dialPadButton(size, '6', color: HexColor('#000000'))
              ],
            ),
            Row(
              children: [
                dialPadButton(size, '7', color: HexColor('#000000')),
                dialPadButton(size, '8', color: HexColor('#000000')),
                dialPadButton(size, '9', color: HexColor('#000000'))
              ],
            ),
            Row(
              children: [
                dialPadButton(size, '*', color: HexColor('#000000')),
                dialPadButton(size, '0', color: HexColor('#000000')),
                dialPadButton(size, '#', color: HexColor('#000000'))
              ],
            ),
            InkWell(
              child: Container(
                height: 6.9.h,
                width: 13.h,
                decoration: BoxDecoration(
                  color: HexColor('#12b562'),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ),
              ),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (_) =>
                      RatingDialog(name: "the number", number: display),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget dialPadButton(Size size, String value, {Color? color}) {
    return InkWell(
      highlightColor: HexColor('#d8d8d8'),
      onTap: () {
        setState(() {
          display = display + value;
        });
      },
      child: Container(
        height: size.height * 0.1,
        width: size.width * 0.33,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: HexColor('#000000').withOpacity(0.1),
              spreadRadius: -10,
            ),
          ],
        ),
        child: Center(
          child: Text(
            value,
            textScaleFactor: 1.0,
            style: TextStyle(
                color: color ?? HexColor('#999999'),
                fontSize: 25.sp,
                fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}
