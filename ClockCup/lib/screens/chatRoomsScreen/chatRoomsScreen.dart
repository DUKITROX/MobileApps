import 'package:ClockCup/screens/chatScreen/chatScreen.dart';
import 'package:ClockCup/screens/logInScreen.dart/logInScreen.dart';
import 'package:ClockCup/screens/searchScreen/searchScreen.dart';
import 'package:ClockCup/services/authentication.dart';
import 'package:ClockCup/services/databaseMethods.dart';
import 'package:ClockCup/services/sharedPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatRoomsScreen extends StatefulWidget {
  @override
  _ChatRoomsScreenState createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {

  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  String username;

  _signOut(){
    authenticationMethods.signOut();
    SharedPreferencesMethods.setIsLoggedIn(false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
  }
  @override
  void initState() {
    SharedPreferencesMethods.getUsername().then((value){
      setState(() {
        username = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
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
      body:Container(child: _chatroomsList(),),
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
  _chatroomsList(){
    Stream<QuerySnapshot> chatrooms = databaseMethods.getChatrooms(username); 
    return StreamBuilder(
      stream: chatrooms,
      builder: (context, snapshot){
        return snapshot.hasData? ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: 70,
              color: Colors.blueGrey[600],
              padding: EdgeInsets.all(10),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Text(snapshot.data.documents[index].data["chatroomName"]),
                    Spacer(),
                    FlatButton(
                      child: Text("Enter Chatroom",),
                      onPressed: (){
                        databaseMethods.enterChatRoom(username, snapshot.data.documents[index].data["chatroomId"]);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(snapshot.data.documents[index].data["chatroomId"])));
                        },
                      color: Colors.blue[200],
                    )
                  ],
                ),
              ),
            );
          },
        ):Container();
      },
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