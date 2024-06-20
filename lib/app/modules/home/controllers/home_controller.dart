import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var inputHeight = <TextEditingController>[].obs;
  var inputLength = <TextEditingController>[].obs;
  var inputWidth = <TextEditingController>[].obs;
  List<Map<String, dynamic>> items = [];
  var isHiddenPredictButton = true.obs;
  var key = GlobalKey<FormState>();
  var typeSuitcase = <RxInt>[].obs;
  var typeBackpack = <RxInt>[].obs;
  var typeDuffel = <RxInt>[].obs;
  var numberOfItems = 0.obs;
  var volume = <RxInt>[];

  void inputBarang(int i) {
    volume[i].value = int.parse(inputLength[i].text) *
        int.parse(inputWidth[i].text) *
        int.parse(inputHeight[i].text);
    items.add({
      'length': int.parse(inputLength[i].text),
      'width': int.parse(inputWidth[i].text),
      'height': int.parse(inputHeight[i].text),
      'type_backpack': typeBackpack[i].value,
      'type_duffel': typeDuffel[i].value,
      'type_suitcase': typeSuitcase[i].value,
      'volume': volume[i].value,
    });
  }

  void penambahanBarang() {
    inputLength.add(TextEditingController());
    inputWidth.add(TextEditingController());
    inputHeight.add(TextEditingController());
    typeBackpack.add(0.obs);
    typeDuffel.add(0.obs);
    typeSuitcase.add(0.obs);
    volume.add(0.obs);
    isHiddenPredictButton.value = false;
    numberOfItems.value++;
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

  void resetInput() {
    for (int i = 0; i < inputLength.length; i++) {
      inputLength[i].dispose();
      inputWidth[i].dispose();
      inputHeight[i].dispose();
    }
    items.clear();
    volume.clear();
    inputLength.clear();
    inputWidth.clear();
    inputHeight.clear();
    numberOfItems.value = 0;
    isHiddenPredictButton.value = true;
  }
}
