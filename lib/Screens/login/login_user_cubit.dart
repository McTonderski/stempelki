import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/data.auth/listeners/auth_registration_listener.dart';
import 'package:shopapp/data.auth/repo/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data.auth/listeners/auth_login_listener.dart';

enum LoginUserState { success, failed, initial }

class LoginUserCubit extends Cubit<LoginUserState>
    implements AuthLoginListener {
  final _authRepository = AuthRepository();

  LoginUserCubit(LoginUserState initialState) : super(initialState);

  void loginUserWithGoogle(){
    _authRepository.loginUserWithGoogle(authLoginListener: this);
  }

  void loginUser({required String email, required String password}) {
    _authRepository.loginUser(
        email: email, password: password, authLoginListener: this);
  }

  @override
  void failed(String error) {
    print(error);
    emit(LoginUserState.initial);
    emit(LoginUserState.failed);
  }

  @override
  void success(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    print(uid);
    await prefs.setString('uid', uid);
    //TODO: add user id to sharedpreferences
    emit(LoginUserState.success);
  }
}
