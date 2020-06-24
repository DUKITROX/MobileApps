import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../../widgets/widget.dart';
import '../../services/auth.dart';
import'../../screens/chatRoomsScreen/chatRoomsScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool isLoading = false;

  AuthMethods authMethods = AuthMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

    register(){
    if(formKey.currentState.validate()){
      setState((){
        isLoading = true;
      });

      authMethods.registerWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
        print(val.userId);});

      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>ChatRoomsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarMain(context),
      body:isLoading? Container(
        child: Center(child:CircularProgressIndicator()),
      ):SingleChildScrollView(
        child:Container(
          padding:EdgeInsets.symmetric(horizontal:24),
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height - 50,
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: formKey,
                child:Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: textFieldInputDecoration("username"),
                      style:simpleTextStyle(),
                      controller: userNameTextEditingController,
                      validator:(val)=>val.isEmpty || val.length < 2? "Please provide a valid username":null
                    ),
                    SizedBox(height:8),
                    TextFormField(
                      decoration:textFieldInputDecoration("email"),
                      style:simpleTextStyle(),
                      controller: emailTextEditingController,
                      validator:(val)=>EmailValidator.validate(val)?null:"Please provide a valid email adress"
                    ),
                    TextFormField(
                      decoration: textFieldInputDecoration("password"),
                      style:simpleTextStyle(),
                      controller: passwordTextEditingController,
                      validator: (val)=>val.length>6?null:"Please provide a password with more than 6 characters",
                    ),
                  ],
                )
              ),
              SizedBox(height:8),
              Container(
                child:Text("Forgot password?",style:simpleTextStyle()),
                padding: EdgeInsets.symmetric(horizontal:16,vertical:8),
                alignment: Alignment.centerRight,
              ),
              SizedBox(height:8),
              GestureDetector(
                onTap: () => register(),
                child: Container(
                  child: Text("Register", style: TextStyle(color:Colors.white,fontSize:18)),
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
                child: Text("Register with Google", style: TextStyle(color:Colors.black87,fontSize:18)),
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
                  Text("Already have an account? ", style: simpleTextStyle()),
                  Text("Log In now",style: TextStyle(color:Colors.white, decoration: TextDecoration.underline, fontSize:16))
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