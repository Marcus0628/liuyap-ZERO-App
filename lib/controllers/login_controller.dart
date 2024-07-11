import 'package:get/get.dart';
import 'package:zero/pages/repository/authentication_repository/authentication_repository.dart';


class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final isGoogleLoading = false.obs;

  //Google Authentication
  Future<void> googleSignIn() async {
    try {
      isGoogleLoading.value = true;
      final auth = AuthenticationRepository.instance;
      await auth.signInWithGoogle();
      // await AuthenticationRepository.instance.signInWithGoogle();
      isGoogleLoading.value = false;
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isGoogleLoading.value = false;
      //Helper.errorSnackBar(title: t, message: e.toString());
    }
  }
}
