import 'package:flutter/material.dart';
import 'package:flutter_ml_luggage/app/routes/app_pages.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
            (controller.numberOfItems.value == 0)
                ? Column(
                    children: [
                      Lottie.asset("assets/preview.json",
                          width: 150, height: 150),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  )
                : ListView.builder(
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
                              child: TextFormField(
                                controller: controller.inputLength[index],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Isi field length";
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
                                controller: controller.inputWidth[index],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Isi field width";
                                  }
                                  return null;
                                },
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
                              child: TextFormField(
                                controller: controller.inputHeight[index],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Isi field Height";
                                  }
                                  return null;
                                },
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
                              child: DropdownSearch<String>(
                                  items: const [
                                    "Backpack",
                                    "Duffel",
                                    "Suitcase"
                                  ],
                                  clearButtonProps: const ClearButtonProps(
                                    isVisible: true,
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    controller.validasiTipeBarang(
                                        value!, index);
                                  },
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: Text("Input Type"),
                                      hintText: "Masukkan Tipe Koper",
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            (controller.isHiddenPredictButton.value)
                ? Container()
                : InkWell(
                    onTap: () {
                      for (int i = 0; i < controller.numberOfItems.value; i++) {
                        controller.inputBarang(i);
                      }
                      Navigator.of(context).pushNamed(Routes.RESULT,
                          arguments: {
                            "data": controller.items,
                            "volume": controller.volume
                          });
                      Future.delayed(
                        const Duration(seconds: 3),
                        () => controller.resetInput(),
                      );
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
                controller.penambahanBarang();
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
                    (controller.numberOfItems.value == 0)
                        ? "Tambah Data Barang Baru".toUpperCase()
                        : "Tambah Barang Lain".toUpperCase(),
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
