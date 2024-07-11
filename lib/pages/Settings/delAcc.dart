// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero/pages/Screen/onBoardingScreen.dart';
import 'package:zero/pages/Welcome/signinpage.dart';
import 'package:zero/styles/button.dart';
import 'package:zero/styles/color.dart';

import 'package:zero/pages/Settings/settings.dart' as MySettings;


class delAcc extends StatefulWidget {
  const delAcc({super.key});
  @override
  State<delAcc> createState() => _DelAccState();
}

class _DelAccState extends State<delAcc>{



// Function to delete the user account and corresponding document from Firestore
void deleteAccount() async {
  //current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Check if the user is authenticated
  if (currentUser != null) {
    try {
      // Delete the user account
      await currentUser.delete();

      // Delete the corresponding user document from Firestore
      await FirebaseFirestore.instance.collection('Users').doc(currentUser!.email).delete();

      // Log out the user if deletion is successful
      // You can add your own logic here if needed
      await FirebaseAuth.instance.signOut();
      
      Get.offAll(() => OnBoardingScreen());

      // Show a Snackbar to indicate that the account has been deleted
      Get.snackbar(
        'Account Deleted',
        'Account deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate to a different screen or perform other actions if needed
    } catch (e) {
      // Handle errors here
      print('Error deleting account: $e');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: background,

        appBar: AppBar(
            backgroundColor: topbar,
            title: null,
            
            leading: IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MySettings.Settings()),
                );
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
              color: word,
            ),

            bottom: PreferredSize(
              preferredSize: Size.fromHeight(25),
              child: Padding(
                padding: EdgeInsets.all(5.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_outline_rounded,
                      color: word,
                      size: 30,
                    ),
                    SizedBox(width: 8.0,),
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        color: word,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "FjallaOne",
                      ),
                    ),
                  ],
                )
              ),
              ),  
            ),
          ),


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/sadBee.png'),
        
            Text(
              "Are you sure?",
              style: TextStyle(
                color: word,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: "FjallaOne",
              ),
            ),

            SizedBox(height: 80.0,),
            ElevatedButton(
              onPressed: (){
                // Show the delete account confirmation dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Confirm Deletion"),
                    content: Text("Are you sure you want to delete your account? This action cannot be undone."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel", style: TextStyle(color: Colors.red)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Perform the delete account operation
                          deleteAccount();
                          
                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: Text("Delete"),
                      ),
                    ],
                  ),
                );
              },
              style: proceedButton,
              child: Text(
                "Delete Account",
                style: TextStyle(
                  color: word,
                  fontSize: 28,
                  fontFamily: "FjallaOne",
                ),
              ),
            ),

            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MySettings.Settings()),
                );
              },
              style: cancelButton,
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Color(0xff414141),
                  fontSize: 28,
                  fontFamily: "FjallaOne",
                ),
              ),
            )
          ],
        )
      ),
      ),
    );
  }
}


  