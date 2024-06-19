import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResultView'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Obx(
            () => (controller.isLoading.value)
                ? const Center(child: CircularProgressIndicator())
                : (controller.data[0]["status"] == "diterima")
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            "assets/checklist.json",
                            width: 300,
                            height: 300,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var data = controller.data[index];
                              var weights = data["weights"];
                              return Column(
                                children: [
                                  Text(data["pesan"]),
                                  const Text(
                                      "Ketentuan limit barang koper : 200kg"),
                                  Text(
                                      "Total Berat Koper : ${data["total_weight"]}Kg"),
                                  ...weights.map((weightData) {
                                    return Text(
                                        "Barang ${weightData['barang']} : ${weightData['weight']}Kg");
                                  }),
                                  ...List.generate(controller.volume.length,
                                      (index) {
                                    var volume = controller.volume[index];
                                    return Text(
                                        "Nilai Volume ke ${index + 1}: $volume");
                                  })
                                ],
                              );
                            },
                            itemCount: controller.data.length,
                          )
                        ],
                      )
                    : Center(
                        child: Column(
                          children: [
                            Lottie.asset(
                              "assets/failed.json",
                              width: 300,
                              height: 300,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data = controller.data[index];
                                var weights = data["weights"];
                                return Column(
                                  children: [
                                    Text(data["pesan"]),
                                    const Text(
                                        "Ketentuan limit barang koper : 200kg"),
                                    Text(
                                        "Total Berat Koper : ${data["total_weight"]}Kg"),
                                    ...weights.map((weightData) {
                                      return Text(
                                          "Barang ${weightData['barang']} : ${weightData['weight']}Kg");
                                    }),
                                    ...List.generate(controller.volume.length,
                                        (index) {
                                      var volume = controller.volume[index];
                                      return Text(
                                          "Nilai Volume ke ${index + 1}: $volume");
                                    })
                                  ],
                                );
                              },
                              itemCount: controller.data.length,
                            )
                          ],
                        ),
                      ),
          )
        ],
      ),
    );
  }
}
