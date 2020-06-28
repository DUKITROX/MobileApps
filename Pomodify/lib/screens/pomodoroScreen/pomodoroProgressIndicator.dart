import 'package:flutter/material.dart';

class PomodoroProgressIndicator extends StatefulWidget{

  double value;
  Widget upperText;
  Widget timerClock;
  Widget lowerText;
  PomodoroProgressIndicator({this.timerClock, this.upperText, this.lowerText,@required this.value});

  createState() => _PomodoroProgressIndicatorState();
}
class _PomodoroProgressIndicatorState extends State<PomodoroProgressIndicator>{
  @override
  build(BuildContext context){
    return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SizedBox(
                  height: 200,
                  width: 200,
                  child: SizedBox.expand(
                    child:CircularProgressIndicator(
                      value: widget.value,
                      strokeWidth: 10.0,
                      backgroundColor: Theme.of(context).primaryColor,
                    )
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: SizedBox.expand(
                    child:Container(
                      decoration:BoxDecoration(
                        shape:BoxShape.circle,
                        color: Theme.of(context).backgroundColor
                      )
                    )
                  )
                ),
              Column(
                  children:[
                    widget.upperText,
                    SizedBox(height:7),
                    widget.timerClock,
                    SizedBox(height:7),
                    widget.lowerText
                  ]
                )
            ],
    );
  }
}