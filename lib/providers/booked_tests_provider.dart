import 'dart:convert';

import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/models/booked_tests_model.dart';
import 'package:nex_lab/providers/base_provider.dart';

class BookedTestsProvider extends BaseProvider{

  List<BookedTestModel> bookedTests = [];

  getBookedTests()async {
    setIsLoading(true);
    printDebug("Fetching booked tests from the server");
    var data = await api.get("$baseUrl/api/user/tests");
    printDebug("The data is: ${data.body}");

    if (data.statusCode == 200) {
      setIsFailed(false);
      var decodeData = jsonDecode(data.body);
      bookedTests = List<BookedTestModel>.from(
          decodeData.map((e) => BookedTestModel.fromJson(e)));
    } else {
      setIsFailed(true);
    }

    setIsLoading(false);

  }

  Future<bool> addBookedTest(Map body) async {
    setIsLoading(true);
    final response = await api.post("$baseUrl/api/user/test/add", body);

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




}