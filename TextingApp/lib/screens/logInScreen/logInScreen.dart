import 'package:flutter/material.dart';
import '../../widgets/widget.dart';

class LogInScreen extends StatefulWidget{
  @override
  createState() => _LogInScreenState();
}
class _LogInScreenState extends State<LogInScreen>{
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
              TextField(
                decoration:textFieldInputDecoration("email"),
                style:simpleTextStyle()
              ),
              TextField(
                decoration: textFieldInputDecoration("password"),
                style:simpleTextStyle()
              ),
              SizedBox(height:8),
              Container(
                child:Text("Forgot password?",style:simpleTextStyle()),
                padding: EdgeInsets.symmetric(horizontal:16,vertical:8),
                alignment: Alignment.centerRight,
              ),
              SizedBox(height:8),
              Container(
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
                  Text("Register now",style: TextStyle(color:Colors.white, decoration: TextDecoration.underline, fontSize:16))
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