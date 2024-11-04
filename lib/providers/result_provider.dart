import 'dart:convert';
import 'dart:io';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/models/user_result_model.dart';
import 'package:nex_lab/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:dio/dio.dart';

class ResultProvider extends BaseProvider {
  List<UserResultModel> results = [];

  getResults() async {
    setIsLoading(true);
    printDebug("Fetching results from the server");
    var data = await api.get("$baseUrl/api/user/results");
    printDebug("The data is: ${data.body}");

    if (data.statusCode == 200) {
      setIsFailed(false);
      var decodeData = jsonDecode(data.body)["data"];
      results = List<UserResultModel>.from(
          decodeData.map((e) => UserResultModel.fromJson(e)));
    } else {
      setIsFailed(true);
    }

    setIsLoading(false);
  }

  Future<void> fetchAndSavePdfReport(int resultId) async {
    setIsLoading(true);
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("token");
      if (token != null) {
        UserResultModel? result = results.firstWhere((r) => r.id == resultId);

        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/report_${result.filePath.substring(8)}.pdf';
        final file = File(filePath);

        if (!await file.exists()) {
          final response = await Dio().get(
            '$baseUrl/api/user/result/download/$resultId',
            options: Options(
              headers: {'Authorization': 'Bearer $token'},
              responseType: ResponseType.bytes,
            ),
          );
          await file.writeAsBytes(response.data);
        }

        await OpenFile.open(filePath);
        setIsFailed(false);
      } else {
        setIsFailed(true);
      }
    } catch (e) {
      setIsFailed(true);
    }
    setIsLoading(false);
  }
}
