import 'dart:convert';

import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/models/user_model.dart';
import 'package:nex_lab/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends BaseProvider {
  bool isAuthed = false;
  UserModel? user;

  initializeAuthProvider() async {
    setIsLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    printDebug("The Token is: $token");
    isAuthed = (token != null);
    setIsFailed(false);
  }

  Future<bool> register(Map body) async {
    setIsLoading(true);
    final response = await api.post("$baseUrl/api/register", body);

    if (response.statusCode == 200) {
      setIsFailed(false);
      return true;
    } else {
      setIsFailed(true);
      printDebug(response.body);
      setIsLoading(false);
      return false;
    }
  }

  Future<bool> login(Map body) async {
    setIsLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await api.post("$baseUrl/api/login", body);
    if (response.statusCode == 200) {
      printDebug("Response code decoded data: ${jsonDecode(response.body)}");
      setIsFailed(false);
      var data = jsonDecode(response.body);
      pref.setString("token", data['access_token']);
      isAuthed = true;
      setIsLoading(false);
      printDebug("TOKEN ISS:   ${data['access_token']}");
      return true;
    } else {
      printDebug(
          "Response code decoded data ELSE : ${jsonDecode(response.body)}");

      setIsFailed(true);
      printDebug(response.body);
      setIsLoading(false);
      return false;
    }
  }

  Future<bool> logout() async {
    final res = await api.post("$baseUrl/api/logout", {});
    printDebug(res.body);
    printDebug(res.headers.toString());
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();

    return true;
  }
}
