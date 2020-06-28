import 'package:flutter/material.dart';

hexColor(String hexColorCode){
  String hexColor = "0xff$hexColorCode";
  hexColor = hexColor.replaceAll("#","");
  int colorInt = int.parse(hexColor);
  return colorInt;
}

const double fontSize = 15.0;
const double titleSize = 36.0;
const double timerSize = 36.0;

const Color brown = Color.fromRGBO(125, 113, 87, 1.0);
const Color yellow = Color.fromRGBO(253, 237, 160, 1.0);
const Color blue = Color.fromRGBO(61, 175, 164, 1.0);

const TitleTextStyle = TextStyle(
  fontFamily: "Comfortaa",
  fontSize: titleSize,
  fontWeight: FontWeight.w600,
  color: brown
);

const TimerTextStyle = TextStyle(
  fontFamily: "Comfortaa",
  fontSize: timerSize,
  fontWeight: FontWeight.w600,
  color: brown
);

const NormalTextStyle = TextStyle(
  fontFamily: "Comfortaa",
  fontSize: fontSize,
  fontWeight: FontWeight.w300,
  color: brown
);

const NormalBoldTextStyle = TextStyle(
  fontFamily: "Comfortaa",
  fontSize: fontSize,
  fontWeight: FontWeight.w600,
  color: brown
);