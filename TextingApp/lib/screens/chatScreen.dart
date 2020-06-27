import 'package:TextingApp/helper/constants.dart';
import 'package:TextingApp/services/database.dart';
import 'package:TextingApp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {

  final String chatRoomId;
  ChatScreen(this.chatRoomId);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  TextEditingController messageController = TextEditingController();

  Stream<QuerySnapshot> chatMessagesStream;

  Widget chatMessageList(){
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot){
        return snapshot.hasData?ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return MessageTile(snapshot.data.documents[index].data["message"],snapshot.data.documents[index].data["sentBy"] == Constants.myName);
          },
        ):Container();
      },
    );
  }
  sendMessage(){
    if (messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
      "message": messageController.text,
      "sentBy": Constants.myName,
      "time": DateTime.now().millisecondsSinceEpoch
      };  
      DatabaseMethods().addConversationMessage(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    DatabaseMethods().getConversationMessage(widget.chatRoomId).then((value){
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: <Widget>[
            chatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(15),
                color: Color(0x53FFFFFF),
                child: Row(
                  children:[
                    Expanded(
                      child: TextField(
                        style: TextStyle(color:Colors.white),
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: "Message...",
                          hintStyle: TextStyle(color:Colors.white54),
                          border: InputBorder.none
                        )
                      )
                    ),
                    GestureDetector(
                      onTap: (){
                        sendMessage();
                      },
                      child: Container(
                        child: Icon(Icons.send,size: 30.0,color:Colors.white54),
                        padding: EdgeInsets.all(5),))
                  ]
                ),
              ),
            ),
        ],
      ),),
    );
  }
}

class MessageTile extends StatelessWidget {

  final String message;
  final bool isSentByMe;
  MessageTile(this.message,this.isSentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
      padding: EdgeInsets.only(left: isSentByMe?50:0, right: isSentByMe?0:40),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe?Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:20,vertical:16),
        decoration: BoxDecoration(
          color:isSentByMe?Colors.blue:Colors.black26,
          borderRadius: isSentByMe?
            BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomLeft: Radius.circular(23)
            ):
            BorderRadius.only(
              topLeft: Radius.circular(23),
              topRight:Radius.circular(23),
              bottomRight:Radius.circular(23)
            )
        ),
        child:Text(message, style:simpleTextStyle())
      ),
    );
  }
}