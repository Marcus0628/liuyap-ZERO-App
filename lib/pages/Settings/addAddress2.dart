// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zero/navigation_menu.dart';
import 'package:zero/styles/color.dart';
import 'package:zero/styles/button.dart';

import 'package:zero/pages/Settings/settings.dart' as MySettings;
import 'package:zero/pages/Settings/address.dart';

class AddAddress2 extends StatefulWidget {
  const AddAddress2({super.key});
  @override
  State<AddAddress2> createState() => _AddAddress2State();
}

class _AddAddress2State extends State<AddAddress2> {
  List<Map<String, dynamic>> addressesList =
      []; // List to store multiple addresses

  Map<String, String> addresses =
      {}; // Initialize an empty map to store addresses

  //current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  //all users
  final userCollection = FirebaseFirestore.instance.collection("Users");

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
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Address()),
            //     );
            //   },
            //   icon: Icon(Icons.arrow_back_ios),
            //   color: word,
            // ),

            bottom: PreferredSize(
              preferredSize: Size.fromHeight(25),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Center the contents horizontally
                  children: [
                    Icon(
                      Icons.location_pin,
                      size: 30,
                      color: word,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      "Address Details",
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
            children: [
              Container(
                width: double.maxFinite, // center,
                margin: EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    //Address 1
                    SizedBox(height: 16),
                    Container(
                      width: 390,
                      height: 105,
                      decoration: BoxDecoration(
                        color: lightbrown,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 123, 121, 119),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //First Column
                          Transform.translate(
                            offset: Offset(-135,
                                12), // Adjust the offset to lower the text
                            child: Text(
                              "Address 1",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: word,
                                fontFamily: "FjallaOne",
                              ),
                            ),
                          ),

                          // Second Column
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: 350,
                              height: 35,
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    addresses['Address1'] =
                                        value; // Update the value of 'Address1' in the addresses map
                                  });
                                },
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(32, 138, 112, 112),
                                    hintText: "",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "FjallaOne",
                                    ),
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Address 2
                    SizedBox(height: 25),
                    Container(
                      width: 390,
                      height: 105,
                      decoration: BoxDecoration(
                        color: lightbrown,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 123, 121, 119),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          //First Column
                          Transform.translate(
                            offset: Offset(-135,
                                12), // Adjust the offset to lower the text
                            child: Text(
                              "Address 2",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: word,
                                fontFamily: "FjallaOne",
                              ),
                            ),
                          ),

                          // Second Column
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: 350,
                              height: 35,
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    addresses['Address2'] =
                                        value; // Update the value of 'Address1' in the addresses map
                                  });
                                },
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(32, 138, 112, 112),
                                    hintText: "",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "FjallaOne",
                                    ),
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Postal Code & City
                    SizedBox(height: 25),
                    Row(
                      children: [
                        //Postal Code
                        Container(
                          width: 185,
                          height: 105,
                          margin: EdgeInsets.only(left: 22.0, right: 17.0),
                          decoration: BoxDecoration(
                            color: lightbrown,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color.fromARGB(255, 123, 121, 119),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              //First Column
                              Transform.translate(
                                offset: Offset(-27,
                                    12), // Adjust the offset to lower the text
                                child: Text(
                                  "Postal Code",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: word,
                                    fontFamily: "FjallaOne",
                                  ),
                                ),
                              ),

                              // Second Column
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  width: 170,
                                  height: 35,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        addresses['PostalCode'] =
                                            value; // Update the value of 'Address1' in the addresses map
                                      });
                                    },
                                    maxLines: 1,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(32, 138, 112, 112),
                                        hintText: "",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "FjallaOne",
                                        ),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //City
                        Container(
                          width: 185,
                          height: 105,
                          decoration: BoxDecoration(
                            color: lightbrown,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color.fromARGB(255, 123, 121, 119),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              //First Column
                              Transform.translate(
                                offset: Offset(-57,
                                    12), // Adjust the offset to lower the text
                                child: Text(
                                  "City",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: word,
                                    fontFamily: "FjallaOne",
                                  ),
                                ),
                              ),

                              // Second Column
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  width: 170,
                                  height: 35,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        addresses['City'] =
                                            value; // Update the value of 'Address1' in the addresses map
                                      });
                                    },
                                    maxLines: 1,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(32, 138, 112, 112),
                                        hintText: "",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "FjallaOne",
                                        ),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //finish

                    // Add address
                    SizedBox(
                      height: 200.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Extract values from text fields
                        String address1 = addresses['Address1'] ??
                            ''; // Get the value from the first address text field
                        String address2 = addresses['Address2'] ??
                            ''; // Get the value from the second address text field
                        String postalCode = addresses['PostalCode'] ??
                            ''; // Get the value from the postal code text field
                        String city = addresses['City'] ??
                            ''; // Get the value from the city text field

                        // Create a proper address format
                        String fullAddress =
                            '$address1, $address2, $postalCode, $city';

                        // Add the new address to the list
                        addressesList.add({
                          'FullAddress': fullAddress,
                          'Address1': address1,
                          'Address2': address2,
                          'PostalCode': postalCode,
                          'City': city,
                        });

                        // Sort addressesList by Address1, Address2, PostalCode, then City
                        addressesList.sort((a, b) {
                          int compare = a['Address1'].compareTo(b['Address1']);
                          if (compare != 0) return compare;

                          compare = a['Address2'].compareTo(b['Address2']);
                          if (compare != 0) return compare;

                          compare = a['PostalCode'].compareTo(b['PostalCode']);
                          if (compare != 0) return compare;

                          return a['City'].compareTo(b['City']);
                        });

                        try {
                          // Update the Firestore document with the new address data
                          await FirebaseFirestore.instance
                              .collection("Users")
                              .doc(currentUser!.email)
                              .update({
                            'Address': FieldValue.arrayUnion(addressesList)
                          }); // Replace 'Address' with the appropriate field name in your Firestore document

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Success"),
                                content: Text("Address added successfully"),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NavigationMenu()),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } catch (e) {
                          // Handle errors
                          print('Error adding address: $e');
                        }
                      },
                      style: proceedButton,
                      child: Text(
                        "Add Address",
                        style: TextStyle(
                          color: word,
                          fontSize: 28,
                          fontFamily: "FjallaOne",
                        ),
                      ),
                    ),

                    //Cancel
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MySettings.Settings()),
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
                ),
              ),
            ],
          ),
        ),
      );
}
