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
        title: const Text('Hasil Prediksi'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Obx(
            () => (controller.isLoading.value)
                ? Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
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
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Information",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Status : ${data["pesan"]}",
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    const Text(
                                      "Ketentuan limit total berat : 200kg",
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      "Total Berat Koper : ${data["total_weight"]}Kg",
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    ...weights.map(
                                      (weightData) {
                                        return Text(
                                          "Barang ${weightData['barang']} : ${weightData['weight']}Kg",
                                          style: const TextStyle(
                                            fontSize: 17,
                                          ),
                                        );
                                      },
                                    ),
                                    ...List.generate(
                                      controller.volume.length,
                                      (index) {
                                        var volume = controller.volume[index];
                                        return Text(
                                          "Nilai Volume ${index + 1}: $volume",
                                          style: const TextStyle(
                                            fontSize: 17,
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
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
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Information",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Status : ${data["pesan"]}",
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      const Text(
                                        "Ketentuan limit barang koper : 200kg",
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        "Total Berat Koper : ${data["total_weight"]}Kg",
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      ...weights.map(
                                        (weightData) {
                                          return Text(
                                            "Barang ${weightData['barang']} : ${weightData['weight']}Kg",
                                            style: const TextStyle(
                                              fontSize: 17,
                                            ),
                                          );
                                        },
                                      ),
                                      ...List.generate(
                                        controller.volume.length,
                                        (index) {
                                          var volume = controller.volume[index];
                                          return Text(
                                            "Nilai Volume ${index + 1}: $volume",
                                            style: const TextStyle(
                                              fontSize: 17,
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
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
