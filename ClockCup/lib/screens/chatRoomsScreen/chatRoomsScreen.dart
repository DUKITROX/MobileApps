import 'package:ClockCup/screens/logInScreen.dart/logInScreen.dart';
import 'package:ClockCup/services/authentication.dart';
import 'package:ClockCup/services/sharedPreferences.dart';
import 'package:flutter/material.dart';

class ChatRoomsScreen extends StatefulWidget {
  @override
  _ChatRoomsScreenState createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {

  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  _signOut(){
    authenticationMethods.signOut();
    SharedPreferencesMethods.setIsLoggedIn(false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
  }
  _createChatroom(){
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            child:Container(
              padding: EdgeInsets.all(12),
              child:Icon(Icons.arrow_back),
            ),
            onTap: ()=>_signOut(),
          )
        ],
      ),
      body: Center(child:Icon(Icons.attach_money)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}