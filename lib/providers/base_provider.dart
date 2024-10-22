import 'package:flutter/material.dart';
import 'package:nex_lab/services/api.dart';

class BaseProvider with ChangeNotifier {
  Api api = Api();

  bool isLoading = true;
  bool isFailed = false;

  setIsLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  setIsFailed(bool loading) {
    isFailed = loading;
    notifyListeners();
  }
}
