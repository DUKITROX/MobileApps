import 'package:ClockCup/screens/chatScreen/chatScreen.dart';
import 'package:ClockCup/screens/registerScreen/registerScreen.dart';
import 'package:ClockCup/services/sharedPreferences.dart';
import 'package:ClockCup/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}