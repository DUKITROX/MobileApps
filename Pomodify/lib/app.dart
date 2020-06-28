import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'screens/homeScreen/homeScreen.dart';
import 'screens/pomodoroScreen/pomodoroScreen.dart';
import 'screens/settingsScreen/settingsScreen.dart';
import 'styles.dart';

  const HomeRoute = "/";
  const PomodoroRoute = "/pomodoro";
  const SettingsRoute = "/settings";

class App extends StatelessWidget{

  @override
  build(BuildContext context){
    return MaterialApp(
      theme: _themeData(),
      onGenerateRoute: _routes(),
      initialRoute: '/',
    );
  }
}

RouteFactory _routes(){
    return(settings){
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch(settings.name){
        case(HomeRoute):
          screen = HomeScreen();
          break;
        case(PomodoroRoute):
          screen = PomodoroScreen(pomodoroLength: arguments['pomodoroLength'],);
          break;
        case(SettingsRoute):
          screen = SettingsScreen();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

ThemeData _themeData(){
  return ThemeData(
    backgroundColor: Color(hexColor("#ede1cb")),
    scaffoldBackgroundColor: Color(hexColor("#fff9e3")),
    primaryColor: brown,
    accentColor: blue,
    splashColor: Colors.transparent,

    textTheme: TextTheme(
      title: TitleTextStyle,
      body1: NormalBoldTextStyle,
      body2: NormalTextStyle,
      caption: TimerTextStyle
    ),
    iconTheme: IconThemeData(color: brown,size: 30)
  );
}