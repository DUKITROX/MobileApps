import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';


class AuthenticationMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  registerUserWithEmailAndPassword(String email, String password, BuildContext context)async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    }catch(e){
      Toast.show(e.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      print("[REGISTER ERROR]$e");
      return null;
    }
  }
  logInUserWithEmailAndPassword(String email, String password, BuildContext context)async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }catch(e){
      Toast.show(e.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      print("[LOGIN ERROR]$e");
      return null;
    }
  }
  signOut(){
    _auth.signOut();
  }
}