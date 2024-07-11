// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zero/pages/Organiser/editEvent.dart';
import 'package:zero/pages/Organiser/orgDetails.dart';
import 'package:zero/pages/Welcome/signinpage.dart';
import 'package:zero/pages/organiser/newevent.dart';

import 'package:zero/styles/color.dart';

class OrganiserHomePage extends StatefulWidget {
  const OrganiserHomePage({super.key});

  @override
  State<OrganiserHomePage> createState() => _OrganiserHomePageState();
}

int _currentIndex = 0;

class _OrganiserHomePageState extends State<OrganiserHomePage> {
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
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: topbar,
          title: Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: 
                FutureBuilder<DocumentSnapshot>(
            future: getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.hasData) {
                final companyName = snapshot.data!.get('Company Name');
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    companyName ?? "Company Name not available",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: word,
                      fontFamily: "FjallaOne",
                    ),
                  ),
                );
              }
              return SizedBox(); // Return an empty widget if no data is available
            },
          ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 35,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for event/company",
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: "FjallaOne",
                      ),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                )),
          ),
          actions: [
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
        ),
        
        body: Column(children: [
          Expanded(
              child: ListView(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Container(
                height: 195,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Posted Event',
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 14,
                              fontFamily: "FjallaOne",
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              // Navigate to the other page when "See more" is tapped
                            },
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.62),
                                fontSize: 14,
                                fontFamily: "FjallaOne",
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(0, 0, 0, 0.62),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: SizedBox(
                          height: 0,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 2,
                            separatorBuilder: (context, _) =>
                                SizedBox(width: 15),
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return InkWell(
                                    onTap: () {
                                      // Navigate to TomorrowLandPage when tapped
                                    },
                                    child: eventimg(
                                      'assets/tmrland.png',
                                      'TomorrowLand 2023',
                                      'Europe, Cake, Bread, Sandw..',
                                      'De Schorre Boom, Belgium',
                                    ),
                                  );

                                default:
                                  return Container();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 333, top: 370), // Adjust the values as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xffFFECD0),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add),
                      color: Color(0xffA79478),
                      iconSize: 28,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewEvent(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]))
        ]));
  }

  Widget eventimg(
    String imagePath,
    String title,
    String description,
    String location,
  ) =>
      Container(
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                width: 184,
                height: 93,
                decoration: BoxDecoration(
                  color: lightbrown,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 3,
                      color: Color.fromRGBO(255, 236, 208, 1),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    imagePath,
                    width: 184,
                    height: 93,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(-35, -40),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.translate(
                        offset: Offset(0, 0),
                        child: Container(
                          width: 16,
                          height: 20,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditEvent()),
                              );
                            },
                            icon: Icon(Icons.edit),
                            color: Colors.white,
                            iconSize: 15,
                          ),
                        ),
                      ),
                    ]),
              ),
            ]),
            SizedBox(height: 10),
            Transform.translate(
              offset: Offset(3, -3),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "FjallaOne",
                  color: Color(0xff000000),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(3, -8),
              child: Text(
                description,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: "PathwayGothicOne",
                    color: Color.fromRGBO(0, 0, 0, 0.45)),
              ),
            ),
            Transform.translate(
              offset: Offset(
                  0, -12), // Adjust the vertical offset for the location
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 13,
                    color: Color.fromRGBO(0, 0, 0, 0.45),
                  ),
                  SizedBox(width: 0), // Adjusted space between icon and text
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "PathwayGothicOne",
                      color: Color.fromRGBO(0, 0, 0, 0.45),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
