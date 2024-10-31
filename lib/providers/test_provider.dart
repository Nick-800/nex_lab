import 'dart:convert';
import 'package:nex_lab/models/test_model.dart';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/providers/base_provider.dart';

class TestProvider extends BaseProvider {
  List<TestModel> tests = [];
  TestModel? testById;

  Future<void> getTests() async {
    setIsLoading(true);
    try {
      var response = await api.get("$baseUrl/api/tests");

      if (response.statusCode == 200) {
        setIsFailed(false);
        var decodedData = jsonDecode(response.body)["data"];
        tests =
            List<TestModel>.from(decodedData.map((x) => TestModel.fromJson(x)));
        notifyListeners();
      } else {
        setIsFailed(true);
      }
    } catch (e) {
      setIsFailed(true);
    }
    setIsLoading(false);
  }

  Future<void> availableTests() async {
    setIsLoading(true);
    try {
      var response = await api.get("$baseUrl/api/tests/available");

      if (response.statusCode == 200) {
        setIsFailed(false);
        var decodedData = jsonDecode(response.body);
        tests =
            List<TestModel>.from(decodedData.map((x) => TestModel.fromJson(x)));
        notifyListeners();
      } else {
        setIsFailed(true);
      }
    } catch (e) {
      setIsFailed(true);
    }
    setIsLoading(false);
  }

  Future<void> unavailableTests() async {
    setIsLoading(true);
    try {
      var response = await api.get("$baseUrl/api/tests/not-available");

      if (response.statusCode == 200) {
        setIsFailed(false);
        var decodedData = jsonDecode(response.body);
        tests =
            List<TestModel>.from(decodedData.map((x) => TestModel.fromJson(x)));
        notifyListeners();
      } else {
        setIsFailed(true);
      }
    } catch (e) {
      setIsFailed(true);
    }
    setIsLoading(false);
  }

  Future<void> getTestById(int id) async {
    setIsLoading(true);
    try {
      var response = await api.get("$baseUrl/api/test/$id");

      if (response.statusCode == 200) {
        setIsFailed(false);
        var decodedData = jsonDecode(response.body);
        testById = TestModel.fromJson(decodedData);
        notifyListeners();
      } else {
        setIsFailed(true);
      }
    } catch (e) {
      setIsFailed(true);
    }
    setIsLoading(false);
  }
}
