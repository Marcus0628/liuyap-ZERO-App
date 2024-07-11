import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zero/navigation_menu.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OnBoardingScreenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final isGoogleLoading = false.obs;
  final PageController indicator = PageController();
  final RxInt page = 0.obs;

  @override
  void onReady() {
    super.onReady();
    setInitialScreen();
  }

  void setInitialScreen() {
    final user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() => NavigationMenu());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isGoogleLoading.value = true;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = 
        await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential =
        await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        Get.offAll(() => NavigationMenu());
      }
      isGoogleLoading.value = false;
    } catch (e) {
      isGoogleLoading.value = false;
      // Handle error
    }
  }
}
