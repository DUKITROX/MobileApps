import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  static saveUserData(String username, String email, String password){
    Map<String,String> userMap = {
      "username":username,
      "email":email,
      "password":password
    };
    Firestore.instance.collection("users").add(userMap).catchError((e)=>print(e.toString()));
  }
  static getUserDataFromUsername(String username)async{
    return await Firestore.instance.collection("users").where("username",isEqualTo: username).getDocuments();
  }

}