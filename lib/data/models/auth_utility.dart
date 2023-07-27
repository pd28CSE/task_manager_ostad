import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import './user_model.dart';

class AuthUtility {
  AuthUtility._();

  static AuthUserModel userModel = AuthUserModel();

  static Future<void> saveUserInfo(AuthUserModel authUserModel) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString('user-auth', authUserModel.toJson().toString());
    userModel = authUserModel;
  }

  static Future<AuthUserModel> getUserInfo() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String userAuthData = sharedPrefs.getString('user-auth')!;
    return AuthUserModel.fromJson(jsonDecode(userAuthData));
  }

  static Future<void> clearUserInfo() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.remove('user-auth');
  }
}
