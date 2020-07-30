import 'package:ClockCup/services/databaseMethods.dart';
import 'package:ClockCup/services/sharedPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  int chatroomId;
  ChatScreen(this.chatroomId);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream<QuerySnapshot> messages;
  String username;

  TextEditingController messageController = TextEditingController();

  Widget _messagesList(){
    return StreamBuilder(
      stream: messages,
      builder: (context, snapshot){
        return snapshot.hasData?ListView.builder(
          reverse: true,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return MessageTile(
              message: snapshot.data.documents[index].data["message"],
              sentByMe: snapshot.data.documents[index].data["username"] == username,
              username: snapshot.data.documents[index].data["username"]
            );
          },
        ):Container();
      }
    );
  }
  _sendMessage(String message){
    if(message != ""){
      databaseMethods.setMessages(
        widget.chatroomId,
        message: messageController.text,
        username: username,
        timeStamp: DateTime.now().millisecondsSinceEpoch
      );
      messageController.clear();
    }    
  }

  @override
  void initState() {
    SharedPreferencesMethods.getUsername().then((value) => username = value);
    databaseMethods.getMessages(widget.chatroomId).then((value){
      setState(() {
        messages = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Column(
        children: <Widget>[
          Expanded(
            child:_messagesList()
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              color: Colors.green[100],
              child:Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                        controller: messageController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration.collapsed(
                          hintText: "Message..."
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: FlatButton(
                        child: Text("SEND"),
                        onPressed: ()=>_sendMessage(messageController.text),
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              )
            )
        ],
      )
      
    );
  }
}
class MessageTile extends StatelessWidget{

  String message;
  String username;
  bool sentByMe;
  MessageTile({@required this.message,@required this.sentByMe,@required this.username});

  @override
  Widget build(BuildContext context){
    return Container(
      margin: sentByMe ? EdgeInsets.fromLTRB(80, 10, 10, 10) : EdgeInsets.fromLTRB(10, 10, 80, 10),
      padding: EdgeInsets.all(5),
      alignment: sentByMe?Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children:[
            Text(username,textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
            Text(message, textAlign: TextAlign.start,)
          ]
        ),
      ),
      color: (sentByMe)?Colors.blue[400]:Colors.grey[400],
    );
  }
}