import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

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
      padding: EdgeInsets.symmetric(
        horizontal: 3.h,
        vertical: 2.h,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor,
          padding: EdgeInsets.all(16.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.sp),
          ),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              width: 17.sp,
            ),
            SizedBox(width: 2.3.h),
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
