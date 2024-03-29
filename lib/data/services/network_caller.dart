import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../app.dart';
import '../../ui/screens/auth_screens/login_screen.dart';
import '../models/auth_utility.dart';
import '../models/network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    final String token = AuthUtility.userModel.token.toString();
    try {
      final Response response = await get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': token,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: responseBody,
        );
      } else if (response.statusCode == 401) {
        log(response.statusCode.toString());
        log('Token is expired or invalid---');
        // goToLoginScreen();
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode, body: null);
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          body: null,
        );
      }
    } catch (error) {
      log(error.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        body: null,
      );
    }
  }

  Future<NetworkResponse> postRequest(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      final Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthUtility.userModel.token.toString(),
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: responseBody,
        );
      } else if (response.statusCode == 401) {
        log(response.statusCode.toString());
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode, body: null);
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          body: null,
        );
      }
    } catch (error) {
      log(error.toString());
      return NetworkResponse(isSuccess: false, statusCode: -1, body: null);
    }
  }

  Future<void> goToLoginScreen() async {
    await AuthUtility.clearUserInfo();
    Navigator.pushAndRemoveUntil(
      TaskManager.globalKey.currentContext!,
      MaterialPageRoute(
        builder: (cntxt) {
          return const LoginScreen();
        },
      ),
      (route) => false,
    );
  }
}
