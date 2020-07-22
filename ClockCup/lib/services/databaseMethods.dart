import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

class DatabaseMethods{
  saveUserData(String username, String email, String password){
    Map<String,String> userMap = {
      "username":username,
      "email":email,
      "password":password
    };
    Firestore.instance.collection("users").add(userMap).catchError((e)=>print(e.toString()));
  }
  getUserDataFromUsername(String username)async{
    return await Firestore.instance.collection("users").where("username",isEqualTo: username).getDocuments().catchError((e)=>print("GET USERDATA FROM USER: ${e.toString()}"));
  }
  getUserDataFromEmail(String email)async{
    return await Firestore.instance.collection("users").where("email",isEqualTo: email).getDocuments().catchError((e)=>print("GET USERDATA FROM EMAIL ${e.toString()}"));
  }
  createChatRoom(String chatroomCreator, String chatroomName, BuildContext context, TextEditingController chatroomNameController)async{
    Firestore.instance.collection("chatrooms").where("chatroomName", isEqualTo: chatroomName.toUpperCase()).getDocuments().then((snapshot){
      if (snapshot.documents.isEmpty){
        if(chatroomName == ""){
          Toast.show("The chatroom must have a name", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        }else{
          _createChatRoomId().then((value){
            Map<String,dynamic> chatroomMap = {
              "chatroomCreator": chatroomCreator,
              "chatroomName" : chatroomName.toUpperCase(),
              "chatroomId":value,
              "users":[chatroomCreator],
            };
            Firestore.instance.collection("chatrooms").document(value.toString()).setData(chatroomMap).catchError((e)=>print("CREATE CHATROOM ERROR: $e"));
            Toast.show("$chatroomName chatroom was succesfully created", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            Navigator.pop(context);
          });
        }
      }else{
        Toast.show("Theres already an existing chatroom with that same name", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      }
    });
  }
  Future<int> _createChatRoomId()async{
    QuerySnapshot querySnapshot = await Firestore.instance.collection("chatrooms").getDocuments();
    return querySnapshot.documents.length + 1;
  }
  findChatroom(String chatroomName)async{
    return await Firestore.instance.collection("chatrooms").where("chatroomName",isEqualTo: chatroomName.toUpperCase()).getDocuments().catchError((e)=>print("SEARCH CHATROOM $e"));
  }
  getMessages(int chatroomId)async{
    return Firestore.instance.collection("chatrooms").document(chatroomId.toString()).collection("chats").orderBy("timeStamp",descending: true).snapshots();
  }
  setMessages(int chatroomId, {String message, String username, int timeStamp}){
    Map<String,dynamic> messageMap = {
      "message" : message,
      "username" : username,
      "timeStamp" : timeStamp
    };
    Firestore.instance.collection("chatrooms").document(chatroomId.toString()).collection("chats").add(messageMap);
  }
}