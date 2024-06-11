import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hasil_controller.dart';

class HasilView extends GetView<HasilController> {
  const HasilView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HasilView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HasilView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
