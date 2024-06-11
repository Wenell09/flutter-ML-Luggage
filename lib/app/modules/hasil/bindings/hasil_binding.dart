import 'package:get/get.dart';

import '../controllers/hasil_controller.dart';

class HasilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HasilController>(
      () => HasilController(),
    );
  }
}
