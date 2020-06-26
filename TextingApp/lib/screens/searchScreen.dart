import 'package:TextingApp/helper/constants.dart';
import 'package:TextingApp/screens/chatScreen.dart';
import 'package:TextingApp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/widget.dart';
import '../widgets/widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchTextEditingController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  QuerySnapshot searchSnapshot;

  void initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text).then((val){
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index){
        return SearchTile(
          userName: searchSnapshot.documents[index].data["name"],
          userEmail: searchSnapshot.documents[index].data["email"]);
      },
      itemCount: searchSnapshot.documents.length,
    ):Container();
  }
  
  void createChatRoomAndStartConversation({String username}){
    if(username != Constants.myName){
    String chatRoomId = getChatRoomId(username, Constants.myName);
    List<String> users = [username, Constants.myName];
    Map<String,dynamic> chatRoomMap = {
      "users":users,
      "chatroomId": chatRoomId
    };
    DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(chatRoomId)));
  }else{
    print("you cannot message yourself");
  }
}

  Widget SearchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
      child:Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(userName, style:simpleTextStyle()),
              Text(userEmail, style: simpleTextStyle())
            ]
          ),
          Spacer(),
          GestureDetector(
            onTap: ()=>createChatRoomAndStartConversation(username: userName),
            child: Container(
              child:Text("Message",style: simpleTextStyle(),),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:Colors.blue,
                borderRadius: BorderRadius.circular(30)
              ),),
          )
        ],
      )
    );
  }

  @override
  void initState() {
    super.initState();
    initiateSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              color: Color(0x53FFFFFF),
              child: Row(
                children:[
                  Expanded(
                    child: TextField(
                      style: TextStyle(color:Colors.white),
                      controller: searchTextEditingController,
                      decoration: InputDecoration(
                        hintText: "Search for user...",
                        hintStyle: TextStyle(color:Colors.white54),
                        border: InputBorder.none
                      )
                    )
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Container(
                      child: Icon(Icons.search,size: 30.0,color:Colors.white54),
                      padding: EdgeInsets.all(5),))
                ]
              ),
            ),
            searchList() 
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }else{
    return "$a\_$b";
  }
}