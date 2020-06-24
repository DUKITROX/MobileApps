import 'package:flutter/material.dart';
import 'screens/logInScreen/logInScreen.dart';
import 'screens/registerScreen/registerScreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: _themes(),
      home:RegisterScreen()
    );
  }
}
ThemeData _themes(){
  return ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Color(0xff1F1F1F),
  );
}