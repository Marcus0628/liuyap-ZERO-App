// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zero/navigation_menu.dart';
import 'package:zero/pages/Home/homepage.dart';
import 'package:zero/pages/Profile//userProfile.dart';

import 'package:zero/pages/Settings/accountDetails.dart';
import 'package:zero/pages/Settings/notification.dart';
import 'package:zero/pages/Settings/address.dart';
import 'package:zero/pages/Settings/paymentMethods.dart';
import 'package:zero/pages/Settings/language.dart';
import 'package:zero/pages/Welcome/signinpage.dart';

import 'package:zero/styles/color.dart';
import 'package:zero/styles/button.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // sign user out method
  void logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Get.offAll(() => const SignInPage());
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: topbar,
            title: null,
            leading: BackButton(),
            // IconButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   icon: Icon(Icons.arrow_back_ios),
            //   color: word,
            // ),
            actions: [
              Transform.translate(
                offset: Offset(10, 1),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Notifications()),
                    );
                  },
                  icon: Icon(Icons.notifications),
                  color: word,
                ),
              ),
              Transform.translate(
                offset: Offset(0, 1),
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Logout"),
                        content: Text("Are you sure you want to logout? "),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Close the dialog
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel",
                                style: TextStyle(color: Colors.red)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Perform the delete account operation
                              logout();

                              // Close the dialog
                              Navigator.of(context).pop();
                            },
                            child: Text("Confirm"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(Icons.logout),
                  color: word,
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(25),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Center the contents horizontally
                  children: [
                    Icon(Icons.settings, size: 30, color: word),
                    SizedBox(width: 8.0),
                    Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: word,
                        fontFamily: "FjallaOne",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // First Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Account
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountDetails()),
                        );
                      },
                      style: settingsButton,
                      child: Center(
                        child: Column(
                          children: [
                            Transform.translate(
                              offset: Offset(0, 5),
                              child: Icon(
                                Icons.account_box_rounded,
                                color: word,
                                size: 100,
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0, 5),
                              child: Text(
                                "ACCOUNT",
                                style: TextStyle(
                                  color: word,
                                  fontSize: 25,
                                  fontFamily: "FjallaOne",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Location
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Address()),
                        );
                      },
                      style: settingsButton,
                      child: Center(
                        child: Column(
                          children: [
                            Transform.translate(
                              offset: Offset(0, 5),
                              child: Icon(
                                Icons.location_pin,
                                color: word,
                                size: 100,
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0, 5),
                              child: Text(
                                "LOCATION",
                                style: TextStyle(
                                  color: word,
                                  fontSize: 25,
                                  fontFamily: "FjallaOne",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Second row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Payment
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentMethods()),
                        );
                      },
                      style: settingsButton,
                      child: Center(
                        child: Column(
                          children: [
                            Transform.translate(
                              offset: Offset(0, 5),
                              child: Icon(
                                Icons.payment_rounded,
                                color: word,
                                size: 100,
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0, 5),
                              child: Text(
                                "PAYMENT",
                                style: TextStyle(
                                  color: word,
                                  fontSize: 25,
                                  fontFamily: "FjallaOne",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //Language
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to another page when the button is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Language()),
                        );
                      },
                      style: settingsButton,
                      child: Center(
                        child: Column(
                          children: [
                            Transform.translate(
                              offset: Offset(0, 5),
                              child: Icon(
                                Icons.language_rounded,
                                color: word,
                                size: 100,
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0, 5),
                              child: Text(
                                "LANGUAGE",
                                style: TextStyle(
                                  color: word,
                                  fontSize: 25,
                                  fontFamily: "FjallaOne",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
