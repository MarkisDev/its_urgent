import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final kPrimaryColor = HexColor('#12b562');
final kPrimaryLightColor = HexColor('#5de890');
final kDarkColor = HexColor('#008436');
final kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kPrimaryLightColor, kPrimaryColor],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);
