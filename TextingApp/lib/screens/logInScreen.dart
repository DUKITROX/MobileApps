import 'package:TextingApp/helper/helperFunctions.dart';
import 'package:TextingApp/services/auth.dart';
import 'package:TextingApp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../widgets/widget.dart';
import 'chatRoomsScreen.dart';

class LogInScreen extends StatefulWidget{

  final Function toggle;
  LogInScreen(this.toggle);

  @override
  createState() => _LogInScreenState();
}
class _LogInScreenState extends State<LogInScreen>{
  
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool isLoading  = false;
  QuerySnapshot snapshotUserInfo;

  logIn(){
    if(formKey.currentState.validate()){

      //HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);

      setState(() {
        isLoading = true;
      });

      databaseMethods.getUserByUserEmail(emailTextEditingController.text).then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.documents[0].data["name"]);
      });

      authMethods.logInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((value) {
         if(value != null){
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>ChatRoomsScreen()));
        }
      });

    }
  }

  @override
  build(BuildContext context){
    return Scaffold(
      appBar: appBarMain(context),
      body:SingleChildScrollView(
        child:Container(
          padding:EdgeInsets.symmetric(horizontal:24),
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height - 50,
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val)=>EmailValidator.validate(val)?null:"Please provide a valid email adress",
                      controller: emailTextEditingController,
                      decoration:textFieldInputDecoration("email"),
                      style:simpleTextStyle()
                    ),
                    TextFormField(
                      validator: (val)=>val.length < 6?"Password must have over 6 character":null,
                      controller: passwordTextEditingController,
                      decoration: textFieldInputDecoration("password"),
                      style:simpleTextStyle(),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height:8),
              Container(
                child:Text("Forgot password?",style:simpleTextStyle()),
                padding: EdgeInsets.symmetric(horizontal:16,vertical:8),
                alignment: Alignment.centerRight,
              ),
              SizedBox(height:8),
              GestureDetector(
                onTap: ()=>logIn(),
                child: Container(
                  child: Text("Log In", style: TextStyle(color:Colors.white,fontSize:18)),
                  decoration:BoxDecoration(
                    gradient:LinearGradient(
                      colors:[
                        Color(0xff007EF4),
                        Color(0xff2A75BC)
                      ]
                    ),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  padding:EdgeInsets.symmetric(vertical:20),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center
                ),
              ),
              SizedBox(height:16),
              Container(
                child: Text("Log In with Google", style: TextStyle(color:Colors.black87,fontSize:18)),
                decoration:BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
                padding:EdgeInsets.symmetric(vertical:20),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text("Dont have an account? ", style: simpleTextStyle()),
                  GestureDetector(
                    onTap: (){
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical:8),
                      child: Text("Register now",style: TextStyle(color:Colors.white, decoration: TextDecoration.underline, fontSize:16))))
                ]
              ),
              SizedBox(height:50)
            ],
          )
        )
      )
    );
  }
}