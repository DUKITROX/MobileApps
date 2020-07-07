import 'package:ClockCup/screens/chatRoomsScreen/chatRoomsScreen.dart';
import 'package:ClockCup/screens/logInScreen.dart/logInScreen.dart';
import 'package:ClockCup/screens/registerScreen/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/sharedPreferences.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isLoggedIn;
  getLoggedInState()async{
    SharedPreferencesMethods.getIsLoggedIn().then((value) => setState(()=>isLoggedIn = value));
  }
  @override
  void initState() {
    getLoggedInState();
  }  

  @override
  Widget build(BuildContext context) {
    if(isLoggedIn != null){
      if(isLoggedIn == true){
        return ChatRoomsScreen();
      }else{
        return LogInScreen();
      }
    }else{
      return LogInScreen();
    }
  }
}