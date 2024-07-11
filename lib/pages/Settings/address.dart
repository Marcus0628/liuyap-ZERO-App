// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero/styles/button.dart';
import 'package:zero/styles/color.dart';

import 'package:zero/pages/Settings/settings.dart' as MySettings;
import 'package:zero/pages/Settings/addAddress.dart';
import 'package:zero/styles/container.dart';

class Address extends StatefulWidget {
  const Address({super.key});
  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
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

  // Initialize an empty map to store addresses
  Map<String, String> addresses = {};
  // Add a method to fetch additional addresses from Firestore
  Future<List<Map<String, dynamic>>> fetchAdditionalAddresses() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await getUserDetails();
    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data();
      if (userData != null && userData.containsKey('Address')) {
        // Check if the 'Address' field exists
        // Assuming 'Address' is a List<Map<String, dynamic>>
        List<Map<String, dynamic>> addresses =
            List<Map<String, dynamic>>.from(userData['Address']);
        return addresses;
      }
    }
    return []; // Return an empty list if no addresses are found or an error occurs
  }

  @override
  void initState() {
    super.initState();
    fetchAdditionalAddresses(); // Fetch additional addresses when the widget initializes
  }

  // Delete addresses
  void deleteMainAddress(String key) {
    setState(() {
      addresses.remove(key); // Remove the address locally
    });
    // Remove the address from Firestore
    userCollection.doc(currentUser!.email).update({
      'Addresses.$key': FieldValue.delete(),
    });
  }

  // Define addressesList to hold additional addresses
  List<Map<String, dynamic>> addressesList = [];
  // Delete additional address
  void deleteAdditionalAddress(int index) {
    if (addressesList.isNotEmpty &&
        index >= 0 &&
        index < addressesList.length) {
      Map<String, dynamic> addressToRemove = addressesList[index];

      setState(() {
        addressesList.removeAt(index); // Remove the address locally
      });

      // Remove the address from Firestore
      userCollection.doc(currentUser!.email).update({
        'Address': FieldValue.arrayRemove([addressToRemove]),
      }).then((_) {
        // Address removed successfully from Firestore
        print('Address removed successfully from Firestore: $addressToRemove');
      }).catchError((error) {
        // Handle any errors that occur during the update process
        print('Error removing address from Firestore: $error');
      });
    }
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
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => MySettings.Settings()),
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
                      "Addresses",
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
          body: SingleChildScrollView(
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 16.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: getUserDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      Map<String, dynamic>? userData = snapshot.data!.data();

                      if (userData != null &&
                          userData.containsKey('Addresses')) {
                        addresses =
                            Map<String, String>.from(userData['Addresses']);
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Home
                          AddressContainer(
                            label: 'Home',
                            icon: Icons.home,
                            initialValue: addresses['home'] ?? '',
                            onChanged: (value) {
                              addresses['home'] = value;
                            },
                            onDelete: () => deleteMainAddress('home'),
                          ),

                          SizedBox(height: 25),

                          //Work
                          AddressContainer(
                            label: 'Work',
                            icon: Icons.work,
                            initialValue: addresses['work'] ?? '',
                            onChanged: (value) {
                              addresses['work'] = value;
                            },
                            onDelete: () => deleteMainAddress('work'),
                          ),

                          SizedBox(height: 25),

                          //Hostel
                          AddressContainer(
                            label: 'Hostel',
                            icon: Icons.hotel,
                            initialValue: addresses['hostel'] ?? '',
                            onChanged: (value) {
                              addresses['hostel'] = value;
                            },
                            onDelete: () => deleteMainAddress('hostel'),
                          ),
                        ],
                      );
                    } else {
                      return Text("No data");
                    }
                  },
                ),

                SizedBox(height: 25),

                //Additional
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchAdditionalAddresses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      addressesList = snapshot.data ?? [];
                      return Column(
                        children: [
                          ...addressesList.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> address = entry.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: AddressContainer(
                                label: 'Address ${index + 1}',
                                icon: Icons.location_on,
                                initialValue: address['FullAddress'].toString(),
                                onChanged: (value) {
                                  // Update the corresponding address in addressesList
                                  addressesList[index]['FullAddress'] = value;
                                },
                                onDelete: () => deleteAdditionalAddress(index),
                              ),
                            );
                          }).toList(),

                          SizedBox(height: 10),

                          //Add address
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddAddress()),
                              );
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Row(
                                    children: [
                                      Transform.translate(
                                        offset: Offset(-5, 11),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                          size: 28,
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: Offset(0, 12),
                                        child: Text(
                                          "Add Address",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontFamily: "FjallaOne",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 140),

                                //Save changes
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      // Update main addresses
                                      await userCollection
                                          .doc(currentUser!.email)
                                          .update({
                                        'Addresses': addresses,
                                      });

                                      // Update additional addresses
                                      await userCollection
                                          .doc(currentUser!.email)
                                          .update({
                                        'Address': addressesList,
                                      });

                                      Get.snackbar(
                                        'Saved',
                                        'Changes save successfully',
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                      
                                    } catch (e) {
                                      print('Error saving addresses: $e');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'Failed to save changes. Please try again later.'),
                                      ));
                                    }
                                  },
                                  style: proceedButton,
                                  child: Text(
                                    "Save Changes",
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
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
