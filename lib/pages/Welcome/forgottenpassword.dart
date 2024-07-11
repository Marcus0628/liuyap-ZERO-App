// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:zero/pages/Welcome/signinpage.dart';

import 'package:zero/styles/button.dart';
import 'package:zero/styles/color.dart';
import 'package:zero/styles/textfield.dart';

class ForgottenPassword extends StatefulWidget {
  const ForgottenPassword({super.key});

  @override
  State<ForgottenPassword> createState() => _ForgotPassword();

}

class _ForgotPassword extends State<ForgottenPassword> {
  

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Discard Changes?'),
      content: Text('Changes on this page will not be saved'),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Color(0xff414141)),
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        TextButton(
          child: Text(
            'Discard',
            style: TextStyle(color: Color(0xff414141)),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => SignInPage()
              ),
            );
          },
        ),
      ]
    ),
  );

  final emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim()
      );
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            content: Text("Password reset link sent! Check your email"),
          );
        }
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        }
      );
    }
  }


  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          appBar: AppBar(backgroundColor: background, leading: BackButton()),
          body: SafeArea(
              child: Column(
            children: [
              Text(
                'Identify Your Account',
                style: TextStyle(fontSize: 28),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Having any problems accessing?',
                style: TextStyle(fontSize: 20, fontFamily: 'PathwayGothicOne'),
              ),
              SizedBox(
                height: 80,
              ),
              MyTextField(
                controller: emailController,
                hintText: 'Enter your email',
                isPassword: false,
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: buttonPrimary,
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff414141),
                  )),
                onPressed: () {
                  passwordReset();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInPage()),
                  );
                },
              ),
              SizedBox(
                height: 300,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'By creating an account, you agree to our',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'PathwayGothicOne',
                      color: Color(0xff414141)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: null,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xff000000),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: const Text('Terms',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'PathwayGothicOne',
                            color: Color(0xff414141))),
                  ),
                ),
              ]),

              const SizedBox(height: 7),

              // Already have an account?
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'PathwayGothicOne',
                      color: Color(0xff414141)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SignInPage()));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xff000000),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: const Text('Sign In',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'PathwayGothicOne',
                            color: Color(0xff414141))),
                  ),
                ),
              ]),
            ],
          )),
        ),
      );
}

class SecurityCheck extends StatelessWidget {
  const SecurityCheck({super.key});

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: AppBar(backgroundColor: background, leading: BackButton()),
          body: SafeArea(
              child: Column(
            children: [
              Text(
                'Security Check',
                style: TextStyle(fontSize: 28),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Enter the security code displayed on your authenticator.',
                style: TextStyle(fontSize: 20, fontFamily: 'PathwayGothicOne'),
              ),
              SizedBox(
                height: 80,
              ),
              MyTextField(
                controller: null,
                hintText: 'Enter your Secruity Code',
                isPassword: false,
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: buttonPrimary,
                child: const Text('Continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff414141),
                    )),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewPassword()),
                  );
                },
              ),
              SizedBox(
                height: 300,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'By creating an account, you agree to our',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'PathwayGothicOne',
                      color: Color(0xff414141)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: null,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xff000000),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: const Text('Terms',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'PathwayGothicOne',
                            color: Color(0xff414141))),
                  ),
                ),
              ]),

              const SizedBox(height: 7),

              // Already have an account?
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'PathwayGothicOne',
                      color: Color(0xff414141)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SignInPage()));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xff000000),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: const Text('Sign In',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'PathwayGothicOne',
                            color: Color(0xff414141))),
                  ),
                ),
              ]),
            ],
          )),
        ),
      );
}

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: AppBar(backgroundColor: background, leading: BackButton()),
          body: SafeArea(
              child: Column(
            children: [
              Text(
                'Password',
                style: TextStyle(fontSize: 28),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'We recommend updating your password periodically to prevent unauthorised access',
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'PathwayGothicOne'),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: 50,
              ),
              MyTextField(
                controller: null,
                hintText: 'Enter New Password',
                isPassword: false,
              ),
              SizedBox(
                height: 25,
              ),
              MyTextField(
                controller: null,
                hintText: 'Re-enter New Password',
                isPassword: false,
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: buttonPrimary,
                child: const Text('Continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff414141),
                    )),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
              ),
              SizedBox(
                height: 220,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'By creating an account, you agree to our',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'PathwayGothicOne',
                      color: Color(0xff414141)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: null,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xff000000),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: const Text('Terms',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'PathwayGothicOne',
                            color: Color(0xff414141))),
                  ),
                ),
              ]),

              const SizedBox(height: 7),

              // Already have an account?
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'PathwayGothicOne',
                      color: Color(0xff414141)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SignInPage()));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xff000000),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: const Text('Sign In',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'PathwayGothicOne',
                            color: Color(0xff414141))),
                  ),
                ),
              ]),
            ],
          )),
        ),
      );
}
