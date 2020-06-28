import 'package:ClockCup/services/databaseMethods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  QuerySnapshot qsnapshot;

  final formKey = GlobalKey<FormState>();

  register(){
    if(formKey.currentState.validate()){
      DatabaseMethods.saveUserData(usernameController.text, emailController.text, passwordController.text);
      setState(() {
        usernameController.text = "";
        emailController.text = "";
        passwordController.text = "";
      });
    }else{
      setState(() {
        passwordController.text = "no va lmao";
      });
    }
  }

  bool checkIfUsernameAlreadyExists(String username){
    DatabaseMethods.getUserDataFromUsername(username).then((snapshot){
      qsnapshot = snapshot;
      return qsnapshot.documents[0].data["username"]==username?true:false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.all(15),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: usernameController,
                    validator: (val){
                      if(val.toString().length < 6){
                        return "Username must have over 6 letters";
                      }else if (checkIfUsernameAlreadyExists(val)){
                        return "Username already exists";
                      }else{return null;}
                    },
                    decoration:InputDecoration(
                      hintText: "username",
                    )
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (val){

                    },
                    decoration:InputDecoration(
                      hintText: "email",
                    )
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (val){

                    },
                    decoration:InputDecoration(
                      hintText: "password",
                    )
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: ()=>register(),
              child: Text("Register"),
            )
          ],
        )
      )
    );
  }
}