import 'package:flutter/material.dart';

import '../screens/logInScreen.dart';
import '../screens/registerScreen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showLogIn = true;

  void toggleView(){
    setState(() {
      showLogIn = !showLogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogIn){
      return LogInScreen(toggleView);
    }else{
      return RegisterScreen(toggleView);
    }
  }
}