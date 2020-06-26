import 'package:TextingApp/helper/helperFunctions.dart';
import 'package:TextingApp/screens/chatRoomsScreen.dart';
import 'package:flutter/material.dart';
import 'helper/authenticate.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState()async{
    await HelperFunctions.getUserLoggedInsInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: _themes(),
      home: userIsLoggedIn? ChatRoomsScreen() : Authenticate()
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