import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zero/navigation_menu.dart';
import 'package:zero/pages/Welcome/signinpage.dart';
import 'package:zero/pages/home/homepage.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  late final Rx<User?> _firebaseUser;
  final _auth = FirebaseAuth.instance;

  //Getters
  User? get firebaseUser => _firebaseUser.value;
  

  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    setInitialScreen(_firebaseUser.value);
    //ever(firebaseUser, _setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const SignInPage())
        : Get.offAll(() => const NavigationMenu());
  }

//Google Authentication
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Logout User
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const SignInPage());
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } on FormatException catch (e) {
      throw e.message;
    } catch (e) {
      throw "Unable to logout. Try again.";
    }
  }

  // Add this method to listen for authentication state changes
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
