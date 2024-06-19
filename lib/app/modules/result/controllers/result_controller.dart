import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ResultController extends GetxController {
  var argument = Get.arguments["data"];
  var volume = Get.arguments["volume"];
  var data = <dynamic>[].obs;
  var isLoading = true.obs;

  Future<void> predictWeight(List<Map<String, dynamic>> items) async {
    final url = Uri.parse('http://127.0.0.1:5000/predict_weight');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode(items);
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final List result = [jsonDecode(response.body)];
      data.value = result;
      debugPrint("Hasil : $result");
      isLoading.value = false;
    } else {
      debugPrint("Response : ${response.statusCode}");
    }
  }

  @override
  void onInit() {
    predictWeight(argument);
    super.onInit();
  }
}
