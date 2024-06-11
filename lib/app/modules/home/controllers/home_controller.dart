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
  List<Map<String, dynamic>> items = [];

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

  void validasiDanInputBarang(int i) {
    if (inputLength[i].text.isEmpty &&
        inputWidth[i].text.isEmpty &&
        inputHeight[i].text.isEmpty &&
        inputType[i].text.isEmpty) {
      Get.snackbar("Error", "Semua field wajib diisi!");
    } else {
      inputBarang(i);
    }
  }

  void inputBarang(int i) {
    items.add({
      'length': int.parse(inputLength[i].text),
      'width': int.parse(inputWidth[i].text),
      'height': int.parse(inputHeight[i].text),
      'type_backpack': typeBackpack[i].value,
      'type_duffel': typeDuffel[i].value,
      'type_suitcase': typeSuitcase[i].value,
      'volume': int.parse(inputLength[i].text) *
          int.parse(inputWidth[i].text) *
          int.parse(inputHeight[i].text),
    });
  }

  void penambahanBarang() {
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

  void validasiTipeBarang(String value, int index) {
    if (value.toLowerCase() == "backpack") {
      typeBackpack[index].value = 1;
      typeDuffel[index].value = 0;
      typeSuitcase[index].value = 0;
    } else if (value.toLowerCase() == "duffel") {
      typeBackpack[index].value = 0;
      typeDuffel[index].value = 1;
      typeSuitcase[index].value = 0;
    } else if (value.toLowerCase() == "suitcase") {
      typeBackpack[index].value = 0;
      typeDuffel[index].value = 0;
      typeSuitcase[index].value = 1;
    } else {
      typeBackpack[index].value = 0;
      typeDuffel[index].value = 0;
      typeSuitcase[index].value = 0;
    }
  }

  @override
  void onInit() {
    super.onInit();
    penambahanBarang();
  }
}
