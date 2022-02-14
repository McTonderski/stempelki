import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Screens/register_user/register_user_cubit.dart';

class RegisterUserPage extends StatefulWidget {
  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterUserCubit(RegisterUserState.initial),
      child: RegisterUserWidget(),
    );
  }
}

class RegisterUserWidget extends StatefulWidget {
  @override
  _RegisterUserWidgetState createState() => _RegisterUserWidgetState();
}

class _RegisterUserWidgetState extends State<RegisterUserWidget> {
  final _emailController = TextEditingController();
  final _passwordRepeatController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastController = TextEditingController();
  // TODO there might be a need of date controller

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterUserCubit, RegisterUserState>(
      listener: (context, state) {
        switch (state) {
          case RegisterUserState.success:
            // TODO: Handle this case.
            break;
          case RegisterUserState.user_exists:
            // TODO: Handle this case.
            break;
          case RegisterUserState.weak_password:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please use a stronger password'),
              ),
            );
            break;
          case RegisterUserState.failed:
            // TODO: Handle this case.
            break;
          case RegisterUserState.initial:
            // TODO: Handle this case.
            break;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: [
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
                    TextButton(
                      child: const Text('Register'),
                      onPressed: () {
                        context.read<RegisterUserCubit>().registerUser(
                            email: _emailController.text,
                            password: _passwordController.text);
                      },
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
