import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/customButtonContainer.dart';
import '../../widgets/customButtonIconContainer.dart';
import 'pomodoroProgressIndicator.dart';
import '../../styles.dart';

class PomodoroScreen extends StatefulWidget{
  int pomodoroLength;
  PomodoroScreen({this.pomodoroLength:25});
  @override
  State<StatefulWidget> createState() => _PomodoroScreenState(pomodoroLength: pomodoroLength);
}

class _PomodoroScreenState extends State<PomodoroScreen>{
  
  int pomodoroLength;
  int breakLength = 5;

  Timer _timer;
  int minutes = 25;
  int seconds = 0;

  int valueSec;
  double pomodoroProgress = 0.0;

  String zero1 = "";
  String zero2 = "0";
  String currentTask = "Pomodoro";

  bool condition = false;

  _PomodoroScreenState({this.pomodoroLength}){
    switch (pomodoroLength){
      case 50:
        minutes = 50;
        breakLength = 10;
        break;
      case 25:
        minutes = 25;
        breakLength = 5;
        break;
    }
  }

  void _startStopPomodoro(){
    if(condition == false){
      condition = true;
      currentTask = "Pomodoro";
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          
          valueSec = minutes * 60 + seconds;
          pomodoroProgress = 1 - (valueSec / (pomodoroLength * 60));
          if(minutes == 0 && seconds == 0){
            zero1 = "0";
            zero2 = "0";
            condition = false;
            _timer.cancel();
            _startStopBreak();
          }
          else if(seconds == 0){
            minutes--;
            zero2 = "";
            seconds = 59;
          }
          else{
            seconds--;
            if(minutes.toString().length == 1){zero1 = "0";}
              else if(minutes.toString().length >= 2){zero1 = "";}
            if(seconds.toString().length == 1){zero2 = "0";}
              else if (seconds.toString().length >= 2){zero2 = "";}
            }
        });
      });
      }
    else{
      condition = false;
      _timer.cancel();
      }
  }

  void _resetPomodoro(){
      _timer.cancel();
      setState((){
        minutes = pomodoroLength;
        seconds = 0;
        zero1 = "";
        zero2 = "0";
        condition = false;
        pomodoroProgress = 0.0;
      });
    }

  void _startStopBreak(){
    if(condition == false){
      condition = true;
      currentTask = "Break";
      minutes = breakLength;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          
          valueSec = minutes * 60 + seconds;
          pomodoroProgress = 1 - (valueSec / (breakLength * 60));

          if(minutes == 0 && seconds == 0){
            zero1 = "0";
            zero2 = "0";
            condition = false;
            _timer.cancel();
          }
          else if(seconds == 0){
            minutes--;
            zero2 = "";
            seconds = 59;
          }
          else{
            seconds--;
            if(minutes.toString().length == 1){zero1 = "0";}
              else if(minutes.toString().length >= 2){zero1 = "";}
            if(seconds.toString().length == 1){zero2 = "0";}
              else if (seconds.toString().length >= 2){zero2 = "";}
            }
        });
      });
      }
    else{
      condition = false;
      _timer.cancel();
      }
  }
  @override
  build(BuildContext context){
    return Scaffold(
      body: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                CustomButtonIconContainer(
                  widget: FlatButton(
                    onPressed:() => Navigator.pushNamed(context, '/'),
                    child:Icon(Icons.arrow_back,color: Theme.of(context).primaryColor),
                    padding: EdgeInsets.all(0),
                    shape:(CircleBorder())
                  )
                ),
                CustomButtonIconContainer(
                  widget: FlatButton(
                    onPressed: () => Navigator.pushNamed(context,"/settings",),
                    child:Icon(Icons.settings,color: Theme.of(context).primaryColor),
                    padding: EdgeInsets.all(0),
                    shape: CircleBorder()
                  )
                )
              ]
            ),
            Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomButtonContainer(
                      widget: SizedBox.expand(
                        child: FlatButton(
                          onPressed:_startStopPomodoro,
                          child:Text("Start / Stop",style: Theme.of(context).textTheme.body1)
                      ),
                      )
                    ),
                    CustomButtonContainer(
                      widget:SizedBox.expand(
                        child:FlatButton(
                        onPressed:_resetPomodoro,
                          child:Text("Reset current",style: Theme.of(context).textTheme.body1),
                        )
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height:25
                ),
                PomodoroProgressIndicator(
                  value: pomodoroProgress,
                  timerClock: Text("$zero1$minutes : $zero2$seconds", style: Theme.of(context).textTheme.caption),
                  upperText: Text(currentTask),
                  lowerText: Text(""),),
                SizedBox(height:20)
                ]
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Container(
                  height: 50,
                  child: Center(child:Text("New features coming soon!")),
                  color:Theme.of(context).backgroundColor
                ),
                SizedBox(height:40)
              ]
            ),
          ],
        ),
    );
  }
}