import 'package:flutter/material.dart';
import '../styles.dart';

class CustomButtonContainer extends StatefulWidget{
  Widget widget;
  CustomButtonContainer({this.widget});
  createState () => _CustomButtonContainerState();
}
class _CustomButtonContainerState extends State<CustomButtonContainer>{
  @override
  build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: yellow,
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      height:40,
      width: 150,
      margin:EdgeInsets.all(10),
      child: Center(
        child:widget.widget,
      )
    );
  }
}