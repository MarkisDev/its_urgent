import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:hexcolor/hexcolor.dart';

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
        title: const Text("Recent"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 120),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  display,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontSize: 30,
                      color: HexColor('#12b562'),
                      fontWeight: FontWeight.bold),
                ),
              ),
              trailing: SizedBox(
                width: 26,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
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
                            size: 24,
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
            const SizedBox(height: 5),
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
                height: 43,
                width: 95,
                decoration: BoxDecoration(
                  color: HexColor('#12b562'),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Center(
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
              onTap: () async {
                launchUrlString('tel: $display');
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
              color: HexColor('#ffffff'),
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
                fontSize: 35,
                fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}
