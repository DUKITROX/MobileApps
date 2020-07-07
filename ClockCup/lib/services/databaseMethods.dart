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
  createChatRoom(String chatroomCreator, String chatroomName, BuildContext context){
    Firestore.instance.collection("chatrooms").where("chatroomName", isEqualTo: chatroomName).getDocuments().then((snapshot){
      if (snapshot.documents.isEmpty){
        Map<String,dynamic> chatroomMap = {
          "chatroomCreator": chatroomCreator,
          "chatroomName" : chatroomName,
          "users":[chatroomCreator]
        };
        Firestore.instance.collection("chatrooms").document(chatroomName).setData(chatroomMap).catchError((e)=>print("CREATE CHATROOM ERROR: $e"));
      }else{
        Toast.show("Theres already an existing chatroom with that same name", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    });
  }
}