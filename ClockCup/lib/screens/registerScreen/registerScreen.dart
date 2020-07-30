import 'package:ClockCup/screens/chatRoomsScreen/chatRoomsScreen.dart';
import 'package:ClockCup/screens/logInScreen.dart/logInScreen.dart';
import 'package:ClockCup/services/authentication.dart';
import 'package:ClockCup/services/databaseMethods.dart';
import 'package:ClockCup/services/sharedPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DatabaseMethods databaseMethods = DatabaseMethods();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  register()async{
    if(formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      _checkIfUsernameAlreadyExists().then((val){
        if(val==false){
          authenticationMethods.registerUserWithEmailAndPassword(emailController.text, passwordController.text, context).then((result){
            if(result!=null){
              databaseMethods.saveUserData(usernameController.text, emailController.text, passwordController.text);
              SharedPreferencesMethods.setEmail(emailController.text);
              SharedPreferencesMethods.setUsername(usernameController.text);
              SharedPreferencesMethods.setIsLoggedIn(true);
              Toast.show("Succesfully registered!", context, duration: Toast.LENGTH_SHORT,gravity: Toast.CENTER);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoomsScreen()));
            }else{
              setState(() {
                isLoading = false;
              });
            }
          });
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
      body:isLoading?Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),):
      Container(
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
                      }else{return null;}
                    },
                    decoration:InputDecoration(
                      hintText: "username",
                    )
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val){
                      if(!EmailValidator.validate(val)){
                        return "Please provide a valid email";
                      }else{return null;}
                    },
                    decoration:InputDecoration(
                      hintText: "email",
                    )
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (val)=>val.toString().length < 6?"Password must have over 6 characters":null,
                    decoration:InputDecoration(
                      hintText: "password",
                    ),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: ()=>register(),
              child: Text("Register"),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Already have an accound?"),
                GestureDetector(
                  child:Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text("LogIn Here",style: TextStyle(decoration: TextDecoration.underline),),
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
                  },
                )
              ],
            )
          ],
        )
      )
    );
  }
  Future<bool> _checkIfUsernameAlreadyExists()async{
    QuerySnapshot userSnapshot = await databaseMethods.getUserDataFromUsername(usernameController.text);
    if(userSnapshot.documents.isNotEmpty){
      Toast.show("Username already exists", context, duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
      return true;
    }else{return false;}
  }
}