import 'package:ClockCup/screens/logInScreen.dart/logInScreen.dart';
import 'package:ClockCup/screens/searchScreen/searchScreen.dart';
import 'package:ClockCup/services/authentication.dart';
import 'package:ClockCup/services/databaseMethods.dart';
import 'package:ClockCup/services/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatRoomsScreen extends StatefulWidget {
  @override
  _ChatRoomsScreenState createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {

  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  _signOut(){
    authenticationMethods.signOut();
    SharedPreferencesMethods.setIsLoggedIn(false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(12),
              child:Icon(Icons.search)
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()))
          ),
          GestureDetector(
            child:Container(
              padding: EdgeInsets.all(12),
              child:Icon(Icons.arrow_back),
            ),
            onTap: ()=>_signOut(),
          )
        ],
      ),
      body: Center(child:Icon(Icons.attach_money,size: 100.0,color: Colors.green[800],)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>showDialog(
          context:context,
          builder: (context)=>CreateChatroomDialog(),
          barrierDismissible: true,
        ),
      ),
    );
  }
}
class CreateChatroomDialog extends StatelessWidget{

  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController chatroomNameController = TextEditingController();

  @override
  Widget build(context) {
    return Dialog(
      child:Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: chatroomNameController,
              decoration: InputDecoration(
                hintText: "Chatroom name"
              ),
              maxLength: 20,
            ),
            SizedBox(height: 15,),
            RaisedButton(
              onPressed: (){
                SharedPreferencesMethods.getUsername().then((value){
                  databaseMethods.createChatRoom(value, chatroomNameController.text, context, chatroomNameController);
                });
              },
              child: Text("Create chatroom"),
            )
          ],
        ),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal:25)
    );
  }
}