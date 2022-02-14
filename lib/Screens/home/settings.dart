import 'package:flutter/material.dart';
import 'package:shopapp/data.auth/repo/auth_repo.dart';

class UserSettings extends StatefulWidget {
  UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      TextButton(
        child: const Text('Wyloguj'),
        onPressed: () {
          final auth = AuthRepository();
          auth.signOut();
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        },
      ),
    ],);
  }
}