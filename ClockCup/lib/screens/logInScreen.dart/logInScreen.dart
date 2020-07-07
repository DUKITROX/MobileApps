import 'package:ClockCup/screens/chatRoomsScreen/chatRoomsScreen.dart';
import 'package:ClockCup/screens/registerScreen/registerScreen.dart';
import 'package:ClockCup/services/authentication.dart';
import 'package:ClockCup/services/databaseMethods.dart';
import 'package:ClockCup/services/sharedPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  bool isLoading = false;
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(){
    if(formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      authenticationMethods.logInUserWithEmailAndPassword(emailController.text, passwordController.text, context).then((result){
        if(result!=null){
          SharedPreferencesMethods.setEmail(emailController.text);
          databaseMethods.getUserDataFromEmail(emailController.text).then((snapshot){
            QuerySnapshot querySnapshot = snapshot;
            SharedPreferencesMethods.setUsername(querySnapshot.documents[0].data["email"]);
          });
          SharedPreferencesMethods.setIsLoggedIn(true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoomsScreen()));
        }else{
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading?Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),):
      Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(hintText: "email"),
                      validator: (val){
                        if(EmailValidator.validate(val)){
                          return null;
                        }else{return "Please provide a valid email";}
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(hintText: "password"),
                      obscureText: true,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text("Log In"),
                onPressed: ()=>login(),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account?"),
                  GestureDetector(
                    child:Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text("Register Here",style: TextStyle(decoration: TextDecoration.underline),),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}