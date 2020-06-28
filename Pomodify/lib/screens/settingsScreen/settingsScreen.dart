import 'package:flutter/material.dart';
import '../../widgets/customButtonIconContainer.dart';

class SettingsScreen extends StatefulWidget{
  @override
  createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<StatefulWidget>{
  int pomodoroLength = 25;
  @override
  build(BuildContext context){
    return Scaffold(
      body:Column(
        children:[
          Row(
            children: <Widget>[
              CustomButtonIconContainer(
                  widget: FlatButton(
                    onPressed: () => Navigator.pushNamed(context, '/pomodoro',arguments: {'pomodoroLength':pomodoroLength}),
                    child:Icon(Icons.arrow_back,color: Theme.of(context).primaryColor),
                    padding: EdgeInsets.all(0),
                    shape:(CircleBorder())
                  )
                )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ExpansionTile(
                title: Text("Pomodoro Length",style: Theme.of(context).textTheme.body1,),
                backgroundColor: Theme.of(context).backgroundColor,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () => pomodoroLength = 25,
                        child: Text("25 / 5 min",style:Theme.of(context).textTheme.body2),
                      ),
                      FlatButton(
                        onPressed: () => pomodoroLength = 50,
                        child: Text("50 / 10 min",style:Theme.of(context).textTheme.body2),
                      )
                    ],
                  )
                ],
              )
            ],
          )
        ]
      )
    );
  }
}