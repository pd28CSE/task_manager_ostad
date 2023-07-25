import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import '../models/network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    try {
      final Response response = await get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: responseBody,
        );
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
}
