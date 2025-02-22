import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/core/di/init_dependencies.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/entities/response_api.dart';
import 'package:sims_ppob_richard_albert_salendah/core/usecase/usecase.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/domain/usecases/user_logout.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/domain/usecases/user_session.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/domain/usecases/user_sign_up.dart';

import '../../domain/entities/auth_tokens.dart';
import '../../domain/usecases/user_login.dart';

enum AuthStatus {
  initial,
  loading,
  loginSuccess,
  logout,
  signupSuccess,
  unauthenticated,
  error
}

class AuthProvider with ChangeNotifier {
  final UserLogin userLogin;
  final UserSignUp userSignUp;
  final UserLogout userLogout;
  final UserSession userSession;

  AuthStatus _status = AuthStatus.initial;
  String? _message;
  ResponseApi<AuthTokens>? _auth;

  AuthProvider({
    required this.userLogin,
    required this.userSignUp,
    required this.userLogout,
    required this.userSession,
  });

  AuthStatus get status => _status;
  String? get message => _message;
  ResponseApi<AuthTokens>? get auth => _auth;

  // bool get isAuthenticated => _status == AuthStatus.loginSuccess;

  Future<void> login(String email, String password) async {
    _setStatus(AuthStatus.loading);

    final result =
        await userLogin(UserLoginParams(email: email, password: password));

    result.fold(
      (failure) {
        _auth = auth;
        _setStatus(AuthStatus.error, message: failure.message);
      },
      (auth) {
        if (auth.status == 0 && auth.data?.token != null) {
          _auth = auth;
          navigationRefreshNotifier.value = !navigationRefreshNotifier.value;
          _setStatus(AuthStatus.loginSuccess, message: auth.message);
        } else {
          _auth = auth;
          _setStatus(AuthStatus.unauthenticated, message: auth.message);
        }
      },
    );
  }

  Future<void> signUp(
      String email, String firstName, String lastName, String password) async {
    _setStatus(AuthStatus.loading);

    final result = await userSignUp(UserSignUpParams(
      email: email,
      firstName: firstName,
      lastName: lastName,
      password: password,
    ));

    result.fold(
      (failure) {
        _auth = auth;
        print('Here Failed${failure.message}');
        _setStatus(AuthStatus.error, message: failure.message);
      },
      (res) {
        _auth = auth;
        if (res.status == 0) {
          print('Here Ok Aauthenticate,${res.message}');
          _setStatus(AuthStatus.signupSuccess, message: res.message);
        } else {
          print('Here No Unauthenticate,${res.message}');
          _setStatus(AuthStatus.unauthenticated, message: res.message);
        }
        notifyListeners();
      },
    );
  }

  Future<void> logout() async {
    _setStatus(AuthStatus.loading);
    try {
      await userLogout(NoParams());
      _auth = null;
      _setStatus(AuthStatus.logout);
    } catch (e) {
      _setStatus(AuthStatus.error, message: "Logout failed: $e");
    }
    resetState();
  }

  String? getToken() {
    return userSession.getToken();
  }

  bool isTokenExpired(String token) {
    return userSession.isTokenExpired(token);
  }

  void _setStatus(AuthStatus status, {String? message}) {
    _status = status;
    _message = message;
    // notifyListeners();
  }

  void resetState() {
    _auth = null;
    _setStatus(AuthStatus.initial);
  }
}
