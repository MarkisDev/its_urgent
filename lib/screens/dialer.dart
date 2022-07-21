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
            const SizedBox(height: 150),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  display,
                  textScaleFactor: 1.0,
                  style: const TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              trailing: SizedBox(
                width: 35,
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
                        child: Icon(
                          Icons.backspace,
                          size: 35,
                          color: HexColor('#ec4055'),
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
            const SizedBox(height: 50),
            Row(
              children: [
                dialPadButton(size, '1'),
                dialPadButton(size, '2'),
                dialPadButton(size, '3')
              ],
            ),
            Row(
              children: [
                dialPadButton(size, '4'),
                dialPadButton(size, '5'),
                dialPadButton(size, '6')
              ],
            ),
            Row(
              children: [
                dialPadButton(size, '7'),
                dialPadButton(size, '8'),
                dialPadButton(size, '9')
              ],
            ),
            Row(
              children: [
                dialPadButton(size, '*', color: HexColor('#999999')),
                dialPadButton(size, '0'),
                dialPadButton(size, '#', color: HexColor('#999999'))
              ],
            ),
            InkWell(
              child: Container(
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                  color: HexColor('#ec4055'),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Center(
                  child: Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 40,
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
      highlightColor: Colors.black45,
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
              color: HexColor('#f1a3ac'),
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
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
