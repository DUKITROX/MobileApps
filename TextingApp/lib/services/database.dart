import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUsername(String username)async{
    return await Firestore.instance.collection("users").where("name",isEqualTo: username).getDocuments();  
  }
  getUserByUserEmail(String userEmail)async{
    return await Firestore.instance.collection("users").where("email",isEqualTo: userEmail).getDocuments();  
  }
  uploadUserInfo(userMap){
    Firestore.instance.collection("users").add(userMap);
  }
  createChatRoom(String chatRoomId,chatRoomMap){
    Firestore.instance.collection("chatroom").document(chatRoomId).setData(chatRoomMap).catchError((e)=>print(e.toSring()));
  }
  addConversationMessage(String chatRoomId, messageMap){
    Firestore.instance.collection("chatroom").document(chatRoomId).collection("chats").add(messageMap).catchError((e)=>print(e.toString()));
  }
  getConversationMessage(String chatRoomId)async{
    return await Firestore.instance.collection("chatroom").document("chatroomId").collection("chats").orderBy("time",descending:false).snapshots();
  }
  getChatRooms(String username)async{
    return await Firestore.instance.collection("chatroom").where("users",arrayContains: username).snapshots();
  }
}