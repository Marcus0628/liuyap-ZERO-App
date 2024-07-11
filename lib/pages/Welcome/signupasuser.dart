// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zero/pages/Organiser/pbt.dart';

import 'package:zero/pages/Welcome/signinpage.dart';
import 'package:zero/pages/Welcome/survey.dart';

import 'package:zero/styles/button.dart';
import 'package:zero/styles/color.dart';
import 'package:zero/styles/textfield.dart';

class SignUpAsUser extends StatefulWidget {
  const SignUpAsUser({Key? key}) : super(key: key);


  @override
  State<SignUpAsUser> createState() => _SignUpAsUserState();
}

class _SignUpAsUserState extends State<SignUpAsUser> {
  final userNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final phoneNoController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Define a list of roles for the dropdown
  List<String> roles = ['User', 'Organiser']; // Add your roles here

  // Define a variable to hold the selected role
  String? selectedRole;
  String? companyName;

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
            style: TextStyle(
              color: Color(0xff414141),
            ),
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        TextButton(
          child: Text(
            'Discard',
            style: TextStyle(color: Color(0xff414141)),
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SignInPage()),
          ),
        ),
      ]
    ),
  );

  //sign user up method
  void register() async {

    //show loading circle
    showDialog(
      context: context, 
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );

    // Function to check if a string contains only numeric characters
    bool isNumeric(String str) {
      if (str == null) {
        return false;
      }
      return double.tryParse(str) != null;
    }

    // Validate phone number length and numeric characters
    String phoneNumber = phoneNoController.text.trim();
    if (phoneNumber.length != 10 || !isNumeric(phoneNumber)) {
      // Pop the loading circle
      Navigator.pop(context);
      // Show error message
      showErrorMessage("Phone number must be 10 digits and contain only numbers!", context);
      return; // Exit the method early
    }

    //if password dont match
    if(passwordController.text != confirmPasswordController.text){
      //pop the loading circle
      if(context.mounted) Navigator.pop(context);
      //show error message
      showErrorMessage("Passwords don't match!", context);
    }
    else{
      
      //try creating user
      try{
        UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text,
        );

        //create a user document and add to firestore
        createUserDocument(userCredential);

        //pop the loading circle
        Navigator.pop(context);

        // setState(() {});
        
        // Determine the destination page based on the selected role
        if (selectedRole == 'Organiser') {
          // Navigate to a different page for organiser
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => pbtLicense()), // Replace OtherPageForOrganiser() with your desired destination
          );
        } else {
          // Navigate to the survey page for users
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Survey1()), // Replace SurveyPage() with your desired destination
          );
        }

      Get.snackbar(
        'Sign Up Success',
        'Signed up successfully',
        snackPosition: SnackPosition.BOTTOM,
      );


      } on FirebaseAuthException catch (e){
        //pop the loading circle
        Navigator.pop(context);
        //show error message
        showErrorMessage(e.code, context);
      }
    }    
  }

  //error message to user
  void showErrorMessage(String message, BuildContext context) {
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.grey[400],
          title: Center(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'FjallaOne',
              ),
            )
          ),
        );
      },
    );
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      Map<String, dynamic> userData = {
        'Email': userCredential.user!.email,
        'User Name': userNameController.text,
        'Phone Number': phoneNoController.text,
        'Password': passwordController.text,
        'Selected Role': selectedRole,
      };

      // Include company name if the role is 'Organiser'
      if (selectedRole == 'Organiser') {
        userData['Company Name'] = companyNameController.text;
      }

      await FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user!.email)
        .set(userData);
    }
  } 



  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      final shouldPop = await showWarning(context);
      return shouldPop ?? false;
    },
    
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: background, 
        leading: BackButton()
      ),
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 28),
              ),
              
              const SizedBox(height: 30,),
              
              //Full Name
              Padding(
                padding: EdgeInsets.all(15.0),
                child: MyTextField(
                  controller: userNameController,
                  hintText: 'Enter your full name',
                  isPassword: false,
                  padding: 0,
                ),
              ),

              //Company Name
              Visibility(
                visible: selectedRole == 'Organiser',
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: MyTextField(
                    controller: companyNameController,
                    hintText: 'Enter your company name',
                    isPassword: false,
                    padding: 0,
                    // onChanged: (value) {
                    //   setState(() {
                    //     companyName = value;
                    //   });
                    // }
                  ),
                ),
              ),
          
              //Phone Number    
              Padding(
                padding: EdgeInsets.all(15.0),
                child: MyTextField(
                  controller: phoneNoController,
                  hintText: 'Enter your phone number',
                  isPassword: false,
                  padding: 0,
                ),
              ),
                  
              //Email
              Padding(
                padding: EdgeInsets.all(15.0),
                child: MyTextField(
                  controller: emailController,
                  hintText: 'Enter your email',
                  isPassword: false,
                  padding: 0,
                ),
              ),
                  
              //Password    
              Padding(
                padding: EdgeInsets.all(15.0),
                child: MyTextField(
                  controller: passwordController,
                  hintText: 'Enter your password',
                  isPassword: true,
                  padding: 0,
                ),
              ),
          
              //Confirm password    
              Padding(
                padding: EdgeInsets.all(15.0),
                child: MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  isPassword: true,
                  padding: 0,
                ),
              ),

              //Role    
              Padding(
                padding: EdgeInsets.all(15.0),
                child: 
                    // Dropdown button for role
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRole = newValue;
                          companyName = null;
                        });
                      },
                      items: roles.map((role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Select Role',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
              ),
                  
              SizedBox(height: 20),
              
              //Create button
              ElevatedButton(
                style: buttonPrimary,
                child: const Text(
                  'Create your account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff414141),
                  )
                ),
                onPressed: () {
                  register();
                },
              ),
                  
              SizedBox(height: 40,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  const Text(
                    'By creating an account, you agree to our',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'PathwayGothicOne',
                      color: Color(0xff414141)
                    ),
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
                      child: const Text(
                        'Terms',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'PathwayGothicOne',
                          color: Color(0xff414141)
                        )
                      ),
                    ),
                  ),
                ]
              ),
                  
              const SizedBox(height: 7),
                  
              // Already have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'PathwayGothicOne',
                      color: Color(0xff414141)
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignInPage()
                        )
                      );
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
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'PathwayGothicOne',
                          color: Color(0xff414141)
                        )
                      ),
                    ),
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
