import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var inputHeight = <TextEditingController>[].obs;
  var inputLength = <TextEditingController>[].obs;
  var inputWidth = <TextEditingController>[].obs;
  var inputType = <TextEditingController>[].obs;
  var typeSuitcase = <RxInt>[].obs;
  var typeBackpack = <RxInt>[].obs;
  var typeDuffel = <RxInt>[].obs;
  var numberOfItems = 1.obs; // jumlah barang
  var isLoading = true.obs;
  var volume = 0.obs;
  var data = [].obs;

  Future<void> predictWeight(List<Map<String, dynamic>> items) async {
    final url = Uri.parse('http://127.0.0.1:5000/predict_weight');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode(items);
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      debugPrint("Hasil : $result");
      data.value = result;
      isLoading.value = false;
    } else {
      debugPrint("Response : ${response.statusCode}");
    }
  }

  void addItem() {
    numberOfItems.value++;
    inputLength.add(TextEditingController());
    inputWidth.add(TextEditingController());
    inputHeight.add(TextEditingController());
    inputType.add(TextEditingController());
    typeBackpack.add(0.obs);
    typeDuffel.add(0.obs);
    typeSuitcase.add(0.obs);
    numberOfItems.value = inputLength.length;
  }

  @override
  void onInit() {
    super.onInit();
    addItem();
  }
}
