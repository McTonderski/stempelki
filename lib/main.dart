import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/Screens/home/home.dart';
import 'package:shopapp/Screens/login/login.dart';
import 'package:shopapp/Screens/login/login_user_cubit.dart';
import 'package:shopapp/Screens/register_user/register_user.dart';
import 'package:shopapp/Screens/register_user/register_user_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopapp/navigate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<RegisterUserCubit>(
      create: (context) => RegisterUserCubit(RegisterUserState.initial),
    ),
    BlocProvider<LoginUserCubit>(
        create: (context) => LoginUserCubit(LoginUserState.initial)),
  ], child: AppRouter()));
}

class AppRouter extends StatefulWidget {
  AppRouter({Key? key}) : super(key: key);

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  bool isLoggedIn = false;
  @override
  void initState() {
    loadPrefs();
    print(isLoggedIn);
    super.initState();
  }

  void loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('uid')) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: isLoggedIn ? '/' : '/home',
      routes: Navigate.routes,
    );
  }
}
