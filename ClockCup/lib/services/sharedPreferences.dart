import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesMethods{
  static setUsername(String username)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("USERNAME", username);
  }
  static setEmail(String email)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("EMAIL", email);
  }
  static setIsLoggedIn(bool isLoggedIn)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("ISLOGGEDIN", isLoggedIn);
  }

  static Future<String> getUsername()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("USERNAME");
  }
  static Future<String> getEmail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("EMAIL");
  }
  static Future<bool> getIsLoggedIn()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("ISLOGGEDIN");
  }
}