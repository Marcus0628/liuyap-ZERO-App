// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zero/model/favourite_page_model.dart';
import 'package:zero/pages/Settings/addAddress.dart';
import 'package:zero/pages/home/cart.dart';

import 'package:zero/styles/color.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {

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


  // Define a state variable to keep track of the selected address
  String selectedAddress = '';
  // Define a variable to hold the selected address
  String selectedAddressText = ''; 
  // Function to handle address selection
  void selectAddress(String address) {
    setState(() {
      selectedAddress = address;
    });
  }

  // Method to fetch additional addresses from Firestore
  Future<List<Map<String, dynamic>>> fetchAdditionalAddresses() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await getUserDetails();
    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data();
      if (userData != null && userData.containsKey('Address')) {
        List<Map<String, dynamic>> addresses = List<Map<String, dynamic>>.from(userData['Address']);
        return addresses;
      }
    }
    return [];
  }

  // Method to fetch the newly added address from Firestore
  Future<String?> fetchNewlyAddedAddress() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await getUserDetails();
    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data();
      if (userData != null && userData.containsKey('NewAddress')) {
        return userData['NewAddress'] as String;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var favoritepage = context.watch<FavoritePageModel>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: topbar,
          title: Padding(
            padding: EdgeInsets.only(right: 0.0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedAddressText.isNotEmpty ? selectedAddressText : "Please select your address",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: word,
                    fontFamily: "FjallaOne",
                  ),
                ),
              ],
            ),
          ),

          leading: IconButton(
            onPressed: () {
              // Show bottom sheet when the leading icon is pressed
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    color: background, // Background color of the bottom sheet
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          backgroundColor: topbar, // Background color of the "Select Address" app bar
                          elevation: 0, // Remove elevation
                          leading: IconButton(
                            icon: Icon(
                              Icons.close, 
                              color: Colors.black
                            ), // Add a close icon
                            onPressed: () {
                              Navigator.pop(context); // Close the bottom sheet
                            },
                          ),
                          title: Text(
                            'Select Address',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "FjallaOne",
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                          
                        //Address
                        FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          future: getUserDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else if (snapshot.hasData) {
                              Map<String, dynamic>? userData = snapshot.data!.data();

                              if (userData != null) {
                                List<Widget> mainAddressListTiles = [];
                                List<Widget> additionalAddressListTiles = [];
                                // Check if the current location exists in the user data
                                // if (userData.containsKey('Current Location')) {
                                //   selectedAddressText = userData['Current Location'];
                                //   selectedAddress = 'current'; // Assuming 'current' is used to denote the current location
                                // }

                                // Display "Use Current Location" option
                                mainAddressListTiles.add(
                                  ListTile(
                                    leading: Icon(Icons.my_location, color: word),
                                    title: Text(
                                      'Use Current Location',
                                      style: TextStyle(
                                        color: word,
                                        fontSize: 20,
                                        fontWeight: selectedAddress == 'current' ? FontWeight.bold : FontWeight.normal,
                                        fontFamily: "FjallaOne",
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedAddressText = userData['Current Location'];
                                        selectAddress('current');
                                      });
                                      Navigator.pop(context); // Close the bottom sheet
                                    },
                                  ),
                                );

                                // Display main addresses (home, work, hostel)
                                List<String> mainAddressTypes = ['home', 'work', 'hostel'];
                                for (String addressType in mainAddressTypes) {
                                  if (userData.containsKey('Addresses') && userData['Addresses'].containsKey(addressType)) {
                                    mainAddressListTiles.add(
                                      ListTile(
                                        leading: Icon(Icons.location_on, color: word),
                                        title: Text(
                                          userData['Addresses'][addressType],
                                          style: TextStyle(
                                            color: word,
                                            fontSize: 20,
                                            fontWeight: selectedAddress == addressType ? FontWeight.bold : FontWeight.normal,
                                            fontFamily: "FjallaOne",
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedAddressText = userData['Addresses'][addressType];
                                            selectAddress(addressType);
                                          });
                                          Navigator.pop(context); // Close the bottom sheet
                                        },
                                      ),
                                    );
                                  }
                                }

                                // Display additional addresses
                                if (userData.containsKey('Address')) {
                                  List<Map<String, dynamic>> additionalAddresses = List<Map<String, dynamic>>.from(userData['Address']);
                                  for (int i = 0; i < additionalAddresses.length; i++) {
                                    String addressText = additionalAddresses[i]['FullAddress'].toString();
                                    additionalAddressListTiles.add(
                                      ListTile(
                                        leading: Icon(Icons.location_on, color: word),
                                        title: Text(
                                          addressText,
                                          style: TextStyle(
                                            color: word,
                                            fontSize: 20,
                                            fontWeight: selectedAddress == 'additional_$i' ? FontWeight.bold : FontWeight.normal,
                                            fontFamily: "FjallaOne",
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            selectedAddressText = addressText;
                                            selectAddress('additional_$i');
                                          });
                                          Navigator.pop(context); // Close the bottom sheet
                                        },
                                      ),
                                    );
                                  }
                                }

                                return Column(
                                  children: [
                                    // Main addresses (including "Use Current Location")
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: mainAddressListTiles,
                                    ),
                                    // Additional addresses
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: additionalAddressListTiles,
                                    ),
                                    // "Add New Address" ListTile
                                    ListTile(
                                      leading: Icon(Icons.add, color: Colors.black),
                                      title: Text(
                                        'Add New Address',
                                        style: TextStyle(
                                          color: word,
                                          fontSize: 20,
                                          fontFamily: "FjallaOne",
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => AddAddress()),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }
                            }
                            return Text("No data");
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.menu),
            color: word,
          ),

          actions: [
            Transform.translate(
              offset: Offset(0, 1),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()),
                  );
                },
                icon: Icon(Icons.shopping_basket_rounded),
                color: word,
              ),
            ),
          ],

          //Search bar
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: SizedBox(
                height: 35,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search for events",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontFamily: "FjallaOne",
                    ),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              )
            ),
          ),
        ),
        
        body: Container(
          padding: EdgeInsets.all(10), 
          child: _FavoritePageList()
        )
      )
    );
  }
}

class _FavoritePageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoritepage = context.watch<FavoritePageModel>();

    return ListView.builder(
      itemCount: favoritepage.items.length,
      itemBuilder: (context, index) => Container(
        alignment: Alignment.center,
        height: 95,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          //border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          color: lightbrown,
        ),
        child: ListTile(
          leading: Image.asset(
            favoritepage.items[index].image,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              favoritepage.remove(favoritepage.items[index]);
            },
          ),
          title: Text(
            favoritepage.items[index].name,
            style: TextStyle(
              fontFamily: 'FjallaOne', 
              fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text(favoritepage.items[index].subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontFamily: 'FjallaOne'
            )
          ),
          contentPadding: EdgeInsets.all(8),
          onTap: () {},
        )
      )
    );
  }
}
