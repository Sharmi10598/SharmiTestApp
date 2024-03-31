import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Model/TestModelsClass.dart';

class TestAppApi {
  static Future<TestAppModel> getData() async {
    int ressCode = 500;

    try {
      final response = await http.get(
        Uri.parse('https://bycuat.fatneedle.com/api/general_api/get_Particular_Category_Products?cat_id=1'),
        headers: {
          "content-type": "application/json",
        },
      );
      ressCode = response.statusCode;
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        // log("AccBal Res${json.decode(response.body)}");

        return TestAppModel.fromJson(json.decode(response.body), response.statusCode);
      } else {
        log("Error AccBal: ${json.decode(response.body)}");
        throw Exception("Error");
        // return TestAppModel.exception('Error', ressCode);
      }
    } catch (e) {
      log("Exception AB: $e");
      throw Exception(e.toString());
      // return TestAppModel.exception(e.toString(), ressCode);
    }
  }
}
