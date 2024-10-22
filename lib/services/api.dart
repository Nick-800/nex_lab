import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<Response> get(String url) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = jsonDecode(pref.getString("token") ?? "");

    final response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer ${token['access_token']}",
      "Accept": "application/json"
    });

    if (response.statusCode == 401) {
      refreshToken().then((refreshed) {
        if (refreshed) {
          get(url);
        }
      });
    }
    return response;
  }

  Future<Response> post(String url, Map body) async {
    printDebug(body.toString());
    SharedPreferences pref = await SharedPreferences.getInstance();

    var token = pref.getString("token");
    final response = await http.post(Uri.parse(url),
        body: body,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        });
    if (response.statusCode == 401) {
      refreshToken().then((refreshed) {
        if (refreshed) {
          post(url, body);
        }
      });
    }

    return response;
  }

  Future<Response> put(String url, Map body) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var token = jsonDecode(pref.getString("token") ?? "");
    final response = await http.put(Uri.parse(url), body: body, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 401) {
      refreshToken().then((refreshed) {
        if (refreshed) {
          put(url, body);
        }
      });
    }
    return response;
  }

//Noice
  Future<bool> refreshToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var oldToken = pref.getString('token');
    final response = await http.post(Uri.parse("$baseUrl/refresh"), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $oldToken",
    });
    if (response.statusCode == 200) {
      pref.setString('token', jsonDecode(response.body)['access_token']);
      return true;
    } else {
      printDebug(response.statusCode.toString());
      return false;
    }
  }

  Future<Response> upload(File file, String url) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    var decodedToken = jsonDecode(token!);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({
      "Accept": 'application/json',
      'Content-Type': 'application/json',
      "Authorization": "Bearer $decodedToken"
    });
    request.files.add(await http.MultipartFile.fromPath('img', file.path));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    printDebug("UPLOAD URL : $url");
    printDebug("UPLOAD STATUS CODE : ${response.statusCode}");
    printDebug("UPLOAD RESPONSE : ${response.body}");

    if (response.statusCode == 401) {}

    return response;
  }
}
