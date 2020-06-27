import 'package:TextingApp/helper/constants.dart';
import 'package:TextingApp/helper/helperFunctions.dart';
import 'package:TextingApp/screens/chatScreen.dart';
import 'package:TextingApp/screens/searchScreen.dart';
import 'package:TextingApp/services/database.dart';
import 'package:TextingApp/widgets/widget.dart';
import 'package:flutter/material.dart';
import '../helper/authenticate.dart';
import '../services/auth.dart';

class ChatRoomsScreen extends StatefulWidget {
  @override
  _ChatRoomsScreenState createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  Stream chatRoomsStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot){
        return snapshot.hasData? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return ChatRoomsTile(snapshot.data.documents[index].data["chatroomId"].toString().replaceAll("_","").replaceAll(Constants.myName, ""),snapshot.data.documents[index].data["chatroomId"]);
          },
        ):Container();
      }
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo()async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getChatRooms(Constants.myName).then((value){
      setState((){
        chatRoomsStream = value;
      });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.send),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Authenticate()));
            },
            child: Container(child: Icon(Icons.exit_to_app), padding: EdgeInsets.all(10),),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
        },
        child: Icon(Icons.search)
        ),
      body: chatRoomList(),
    );
  }
}
class ChatRoomsTile extends StatelessWidget {

  final String username;
  final String chatRoomId;
  ChatRoomsTile(this.username,this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(chatRoomId)));
      },
      child: Container(
        color:Colors.black26,
        padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
        child:Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color:Colors.blue,
                borderRadius: BorderRadius.circular(40)
              ),
              child:Text("${username.substring(0,1).toUpperCase()}")
            ),
            SizedBox(width: 8,),
            Text(username,style:simpleTextStyle())
          ],
        )
      ),
    );
  }
}