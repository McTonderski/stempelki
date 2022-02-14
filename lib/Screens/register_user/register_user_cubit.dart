import 'package:shopapp/data.auth/listeners/auth_registration_listener.dart';
import 'package:shopapp/data.auth/repo/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum RegisterUserState { success, user_exists, weak_password, failed, initial }

class RegisterUserCubit extends Cubit<RegisterUserState>
    implements AuthRegistrationListener {
  final _authRepository = AuthRepository();

  RegisterUserCubit(RegisterUserState initialState) : super(initialState);

  void registerUser({required String email, required String password}) {
    _authRepository.registerUser(
        email: email, password: password, authRegistrationListener: this);
  }

  @override
  void failed() {
    emit(RegisterUserState.initial);
    emit(RegisterUserState.failed);
  }

  @override
  void success() {
    emit(RegisterUserState.success);
  }

  @override
  void userExists() {
    emit(RegisterUserState.initial);
    emit(RegisterUserState.user_exists);
  }

  @override
  void weakPassword() {
    emit(RegisterUserState.initial);
    emit(RegisterUserState.weak_password);
  }
}
