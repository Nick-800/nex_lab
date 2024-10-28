import 'dart:convert';
import 'dart:io';
import 'package:nex_lab/helpers/consts.dart';
import 'package:nex_lab/helpers/functions_helper.dart';
import 'package:nex_lab/models/user_result_model.dart';
import 'package:nex_lab/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

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

  Future<void> fetchPdfReport(int resultId) async {
    setIsLoading(true);
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("token");
      if (token != null) {
        UserResultModel? result = results.firstWhere((r) => r.id == resultId);

        final response =
            await api.get("$baseUrl/api/user/result/download/$resultId");
        printDebug("Fetched file from:  =======  $baseUrl/${result.filePath}");

        if (response.statusCode == 200) {
          final bytes = response.bodyBytes;
          final path = (await getExternalStorageDirectory())!.path;
          final fileName = result.filePath.substring(8);
          final file = File('$path/report_$fileName.pdf');
          await file.writeAsBytes(bytes, flush: true);
          OpenFile.open('$path/report_$fileName.pdf');
          setIsFailed(false);
        } else {
          setIsFailed(true);
        }
      } else {
        setIsFailed(true);
      }
    } catch (e) {
      setIsFailed(true);
    }
    setIsLoading(false);
  }
}
