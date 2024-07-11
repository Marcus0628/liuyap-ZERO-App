import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zero/pages/Home/homepage.dart';
import 'package:zero/pages/Profile/FAQ.dart';
import 'package:zero/pages/Profile/pointSystem.dart';
import 'package:zero/pages/Profile/myOrder.dart';
import 'package:zero/pages/Profile/tips.dart';
import 'package:zero/pages/Profile/wallet.dart';
import 'package:zero/pages/Profile/wastageAnalytics.dart';
import 'package:zero/pages/Settings/settings.dart' as MySettings;
import 'package:zero/pages/Welcome/signinpage.dart';

import 'package:zero/styles/button.dart';

import 'package:zero/styles/color.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // sign user out method
  void logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Get.offAll(() => const SignInPage());
    // setState(() {});
  }

  //current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;
  //all users
  final userCollection = FirebaseFirestore.instance.collection("Users");
  //future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
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
          actions: [
            Transform.translate(
              offset: Offset(10, 1),
              child: IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Notifications()),
                  // );
                },
                icon: Icon(Icons.notifications),
                color: word,
              ),
            ),
            Transform.translate(
              offset: Offset(0, 1),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FAQ()),
                  );
                },
                icon: Icon(Icons.help_outline_rounded),
                color: word,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(25),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 8.0),
                  FutureBuilder<DocumentSnapshot>(
                    future: getUserDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.hasData && snapshot.data!.exists) {
                        final userName = snapshot.data!.get('User Name');
                        return Text(
                          userName ?? "User#123",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: word,
                            fontFamily: "FjallaOne",
                          ),
                        );
                      }
                      return Text(
                          'No data available'); // Return an empty widget if no data is available
                    },
                  ),
                  // Text(
                  //   "User#123",
                  //   style: TextStyle(
                  //     fontSize: 25,
                  //     fontWeight: FontWeight.bold,
                  //     color: word,
                  //     fontFamily: "FjallaOne",
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // First Row
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lightbrown,
              ),
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            // Third row
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Wallet",
                    style: TextStyle(
                      color: word,
                      fontSize: 22,
                      fontFamily: "FjallaOne",
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Wallet()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Fourth Row
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Orders",
                    style: TextStyle(
                      color: word,
                      fontSize: 22,
                      fontFamily: "FjallaOne",
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyOrder()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Fifth Row
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Wastage Analytics",
                    style: TextStyle(
                      color: word,
                      fontSize: 22,
                      fontFamily: "FjallaOne",
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WastageAnalytics()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Sixth Row
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Points System",
                    style: TextStyle(
                      color: word,
                      fontSize: 22,
                      fontFamily: "FjallaOne",
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PointSystemPage()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Seventh Row
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Settings",
                    style: TextStyle(
                      color: word,
                      fontSize: 22,
                      fontFamily: "FjallaOne",
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MySettings.Settings()),
                      );
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Eco-Friendly Tips",
                    style: TextStyle(
                      color: word,
                      fontSize: 22,
                      fontFamily: "FjallaOne",
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Tips()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Eighth row
            SizedBox(height: 70),
            ElevatedButton(
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
                        child:
                            Text("Cancel", style: TextStyle(color: Colors.red)),
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
              style: uploadButton,
              child: Text(
                "Sign Out",
                style: TextStyle(
                  color: word,
                  fontSize: 28,
                  fontFamily: "FjallaOne",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
