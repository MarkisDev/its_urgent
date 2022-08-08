import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          // permanent fix for github actions
          // primary: kPrimaryColor, // 'primary' is deprecated and shouldn't be used
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(text),
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
