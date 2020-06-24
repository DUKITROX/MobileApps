import 'package:flutter/material.dart';
import '../../widgets/customButtonIconContainer.dart';
import '../../widgets/customButtonContainer.dart';

class HomeScreen extends StatelessWidget{
  @override
  build(BuildContext context){
    return Scaffold(
      body: Column(
        children:[Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
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
            SizedBox(height:25),
            Text("Pomodoify",style:Theme.of(context).textTheme.title),
            SizedBox(height:30),
            Text("Welcom back User! Ready to get to work?",),
            SizedBox(height:50),
            CustomButtonContainer(
              widget: SizedBox.expand(
                        child: FlatButton(
                          onPressed:()=>Navigator.pushNamed(context, '/pomodoro',arguments:{'pomodoroLength':25}),
                          child:Text("Start a timer",style: Theme.of(context).textTheme.body1)
                      ),
                      )
            )
        ]
      )
    );
  }
}