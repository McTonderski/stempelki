import 'package:flutter/cupertino.dart';
import 'package:shopapp/Screens/home/home.dart';
import 'package:shopapp/Screens/login/login.dart';
import 'package:shopapp/Screens/register_user/register_user.dart';

class Navigate{
  static Map<String, Widget Function(BuildContext)> routes ={
    "/": (context) => LoginScreen(),
    "/register": (context) => RegisterUserPage(),
    "/home": (context) => HomeScreen(),
  };
}