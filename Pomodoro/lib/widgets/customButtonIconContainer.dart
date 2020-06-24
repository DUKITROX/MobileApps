import 'package:flutter/material.dart';

class CustomButtonIconContainer extends StatelessWidget{

  Widget widget;
  Icons icon;

  CustomButtonIconContainer({this.widget, this.icon});

  @override
  Widget build(BuildContext context) {
   return(Container(
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
       color: Theme.of(context).primaryColor,
       shape: BoxShape.circle,
     ),
    height: 45,
    width:45,
    child: Center(
       child:Container(
         decoration:BoxDecoration(
           color:Theme.of(context).backgroundColor,
           shape: BoxShape.circle
         ),
         height: 40,
         width:40,
         child:SizedBox(
           child: widget,
           height: 40,
           width: 40
         )
       )
     ),
   )
   ); 
  }
}