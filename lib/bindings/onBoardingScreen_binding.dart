import 'package:get/get.dart';
import 'package:zero/controllers/onBoardingScreen_controller.dart';

class OnBoardingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingScreenController>(
      () => OnBoardingScreenController(),
    );
  }
}
