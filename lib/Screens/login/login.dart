import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Screens/login/login_user_cubit.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Login screen");
    return BlocConsumer<LoginUserCubit, LoginUserState>(
      listener: (context, state) {
        switch (state) {
          case LoginUserState.success:
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
            break;
          case LoginUserState.failed:
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Login Failed')));
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 229, 111, 57),
                    Color.fromARGB(199, 229, 111, 57),
                    Color.fromARGB(149, 229, 111, 57),
                    Color.fromARGB(99, 229, 111, 57),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                )),
              ),
              Container(
                height: double.infinity,
                padding: const EdgeInsets.all(32),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 120.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TODO replace with logo
                        const SizedBox(
                          height: 100,
                        ),
                        // const SizedBox(
                        //   height: 100,
                        // ),
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: _emailController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            onPressed: () {
                              context.read<LoginUserCubit>().loginUser(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            },
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Column(
                          children: const <Widget>[
                            Text(
                              '- OR -',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Sign in with',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<LoginUserCubit>()
                                      .loginUserWithGoogle();
                                },
                                child: Container(
                                  height: 60.0,
                                  width: 60.0,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0, 2),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                      image: DecorationImage(
                                          fit: BoxFit.scaleDown,
                                          scale: 13,
                                          image: AssetImage(
                                              'assets/pictures/google_logo.png',
                                              ))
                                      // image: DecorationImage(
                                      //   image: logo,
                                      // ),
                                      ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => {},
                                child: Container(
                                  height: 60.0,
                                  width: 60.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                    // image: DecorationImage(
                                    //   image: logo,
                                    // ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/register');
                          },
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Don\'t have an Account? ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

                        // TextButton(
                        //     onPressed: () {
                        //       Navigator.of(context)
                        //           .pushNamed('/register');
                        //     },
                        //     child: const Text('Register'))
                      ],
                    )),
              ),
            ]),
          ),
        ));
      },
    );
  }
}
