import 'package:flutter/material.dart';
import 'package:flutter_ml_luggage/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediksi Berat Koper'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.numberOfItems.value,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: controller.inputLength[index],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Input Length"),
                            hintText: "Masukkan Panjang Koper",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: controller.inputWidth[index],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Input Width"),
                            hintText: "Masukkan Lebar Koper",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: controller.inputHeight[index],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Input Height"),
                            hintText: "Masukkan Tinggi Koper",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: TextField(
                          controller: controller.inputType[index],
                          onChanged: (value) {
                            if (value.toLowerCase() == "backpack") {
                              controller.typeBackpack[index].value = 1;
                              controller.typeDuffel[index].value = 0;
                              controller.typeSuitcase[index].value = 0;
                            } else if (value.toLowerCase() == "duffel") {
                              controller.typeBackpack[index].value = 0;
                              controller.typeDuffel[index].value = 1;
                              controller.typeSuitcase[index].value = 0;
                            } else if (value.toLowerCase() == "suitcase") {
                              controller.typeBackpack[index].value = 0;
                              controller.typeDuffel[index].value = 0;
                              controller.typeSuitcase[index].value = 1;
                            } else {
                              controller.typeBackpack[index].value = 0;
                              controller.typeDuffel[index].value = 0;
                              controller.typeSuitcase[index].value = 0;
                            }
                          },
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Input Type"),
                            hintText: "Tipe Koper:(Backpack,Duffel,Suitcase)",
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            InkWell(
              onTap: () {
                List<Map<String, dynamic>> items = [];
                for (int i = 0; i < controller.numberOfItems.value; i++) {
                  items.add({
                    'length': int.parse(controller.inputLength[i].text),
                    'width': int.parse(controller.inputWidth[i].text),
                    'height': int.parse(controller.inputHeight[i].text),
                    'type_backpack': controller.typeBackpack[i].value,
                    'type_duffel': controller.typeDuffel[i].value,
                    'type_suitcase': controller.typeSuitcase[i].value,
                    'volume': int.parse(controller.inputLength[i].text) *
                        int.parse(controller.inputWidth[i].text) *
                        int.parse(controller.inputHeight[i].text),
                  });
                }
                controller.predictWeight(items);
                Navigator.of(context).pushNamed(Routes.HASIL);
              },
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.black),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ]),
                child: Center(
                  child: Text(
                    "Prediksi Berat Koper".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                controller.addItem();
              },
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.black),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ]),
                child: Center(
                  child: Text(
                    "Tambah Barang Lain".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
