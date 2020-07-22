import 'package:ClockCup/screens/chatScreen/chatScreen.dart';
import 'package:ClockCup/services/databaseMethods.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  bool foundChatroom = false;
  String chatroomName;
  int chatroomId;

  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController chatroomNameController = TextEditingController();

  _searchChatroom(){
    databaseMethods.findChatroom(chatroomNameController.text).then((snapshot){
      if(snapshot.documents.isNotEmpty){
        setState(() {
          foundChatroom = true;
          chatroomName = snapshot.documents[0].data["chatroomName"];
          chatroomNameController.clear();
          chatroomId = snapshot.documents[0].data["chatroomId"];
        });
      }else{
        Toast.show("Chatroom doesn't exist", context,duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        chatroomNameController.clear();
        setState(() {
          foundChatroom = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: !foundChatroom? Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: chatroomNameController,
              decoration: InputDecoration(hintText: "Chatroom name..."),
              maxLength: 20,
            ),
            RaisedButton(
              child:Text("Seatch chatroom"),
              onPressed: ()=>_searchChatroom(),
            )
          ],
        ),
      ):
      Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: chatroomNameController,
              decoration: InputDecoration(hintText: "Chatroom name..."),
              maxLength: 20,
            ),
            RaisedButton(
              child:Text("Seatch chatroom"),
              onPressed: ()=>_searchChatroom(),
            ),
            Container(
              child:Row(
                children: <Widget>[
                  Text(chatroomName),
                  Spacer(),
                  FlatButton(
                    child:Text("Enter chatroom"),
                    onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatScreen(chatroomId))),
                    color: Colors.blue[700],
                  )
                ],
              ),
              padding: EdgeInsets.all(15),
            )
          ],
        ),
      )
    );
  }
}

/*Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children:[
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: <Widget>[
                  Container(height: 20,width: 20, color: Colors.red,),
                  TextField(
                    controller: chatroomNameController,
                    decoration: InputDecoration(
                      hintText: "Search chatroom..."
                    ),
                    maxLength: 20,
                  ),
                  IconButton(icon: Icon(Icons.search),onPressed:null)
                ],
              ),
            ),
          ]
        ),
      ),*/