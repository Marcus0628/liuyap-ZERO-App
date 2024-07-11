// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zero/navigation_menu.dart';

import 'package:zero/pages/Home/edc.dart';
import 'package:zero/pages/Home/siam.dart';
import 'package:zero/pages/Home/tmrland.dart';
import 'package:zero/pages/Home/cart.dart';
import 'package:zero/pages/Profile/userProfile.dart';
import 'package:zero/pages/Settings/addAddress.dart';
import 'package:zero/pages/Settings/addAddress2.dart';
import 'package:zero/pages/Settings/settings.dart' as MySettings;

import 'package:zero/styles/color.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

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
        List<Map<String, dynamic>> addresses =
            List<Map<String, dynamic>>.from(userData['Address']);
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

  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(3.0648, 101.6168), zoom: 17);   
  Set<Marker> markersList = {};
  late GoogleMapController googleMapController;
  bool useCurrentLocation = false;

  // Determine the current position of the device.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
  
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  @override
  Widget build(BuildContext context) {
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
                    selectedAddressText.isNotEmpty
                        ? selectedAddressText
                        : "Please select your address",
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
                            backgroundColor:
                                topbar, // Background color of the "Select Address" app bar
                            elevation: 0, // Remove elevation
                            leading: IconButton(
                              icon: Icon(Icons.close,
                                  color: Colors.black), // Add a close icon
                              onPressed: () {
                                Navigator.pop(
                                    context); // Close the bottom sheet
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
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                Map<String, dynamic>? userData =
                                    snapshot.data!.data();

                                if (userData != null) {
                                  List<Widget> mainAddressListTiles = [];
                                  List<Widget> additionalAddressListTiles = [];
                                  

                                  // Display "Use Current Location" option
                                  mainAddressListTiles.add(
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Use Current Location?',
                                                style: TextStyle(
                                                  color: word,
                                                  fontFamily: 'FjallaOne',
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              content: Container(
                                                height: 300,
                                                width: 400,
                                                child: GoogleMap(
                                                  initialCameraPosition: initialCameraPosition,
                                                  myLocationButtonEnabled: true,
                                                  myLocationEnabled: true,
                                                  mapType: MapType.normal,
                                                  onMapCreated: (controller) {
                                                    googleMapController = controller;
                                                  },
                                                  markers: markersList,
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context, true);
                                                    setState(() {
                                                      selectedAddress = 'current'; // Update selectedAddress
                                                      useCurrentLocation = true;
                                                      selectedAddressText = 'Use Current Location';
                                                    });
                                                    Navigator.pop(context); // Close the bottom sheet
                                                  },
                                                  child: Text('Use current location'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context, false); // Cancel
                                                    selectedAddressText = 'Please select address';
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(color: Colors.red), // Set the color to red
                                                  ),
                                                ),
                                              ],

                                            );
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        leading: Icon(Icons.my_location, color: word),
                                        title: Text(
                                          'Use Current Location',
                                          style: TextStyle(
                                            color: word,
                                            fontSize: 20,
                                            fontWeight: selectedAddress == 'current'
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            fontFamily: "FjallaOne",
                                          ),
                                        ),
                                      ),
                                    ),
                                  );

                                  // Display main addresses (home, work, hostel)
                                  List<String> mainAddressTypes = [
                                    'home',
                                    'work',
                                    'hostel'
                                  ];
                                  for (String addressType in mainAddressTypes) {
                                    if (userData.containsKey('Addresses') &&
                                        userData['Addresses']
                                            .containsKey(addressType)) {
                                      mainAddressListTiles.add(
                                        ListTile(
                                          leading: Icon(Icons.location_on,
                                              color: word),
                                          title: Text(
                                            userData['Addresses'][addressType],
                                            style: TextStyle(
                                              color: word,
                                              fontSize: 20,
                                              fontWeight:
                                                  selectedAddress == addressType
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              fontFamily: "FjallaOne",
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              selectedAddressText =
                                                  userData['Addresses']
                                                      [addressType];
                                              selectAddress(addressType);
                                            });
                                            Navigator.pop(
                                                context); // Close the bottom sheet
                                          },
                                        ),
                                      );
                                    }
                                  }

                                  // Display additional addresses
                                  if (userData.containsKey('Address')) {
                                    List<Map<String, dynamic>>
                                        additionalAddresses =
                                        List<Map<String, dynamic>>.from(
                                            userData['Address']);
                                    for (int i = 0;
                                        i < additionalAddresses.length;
                                        i++) {
                                      String addressText =
                                          additionalAddresses[i]['FullAddress']
                                              .toString();
                                      additionalAddressListTiles.add(
                                        ListTile(
                                          leading: Icon(Icons.location_on,
                                              color: word),
                                          title: Text(
                                            addressText,
                                            style: TextStyle(
                                              color: word,
                                              fontSize: 20,
                                              fontWeight: selectedAddress ==
                                                      'additional_$i'
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              fontFamily: "FjallaOne",
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              selectedAddressText = addressText;
                                              selectAddress('additional_$i');
                                            });
                                            Navigator.pop(
                                                context); // Close the bottom sheet
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
                                        leading: Icon(Icons.add,
                                            color: Colors.black),
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
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddAddress2()),
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
                  )),
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: 20),

              //Categories
              Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (context, _) => SizedBox(width: 15),
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return InkWell(
                            onTap: () {
                              // Add navigation action for Popular image
                            },
                            child: buildcard('assets/popular.png', 'Popular'),
                          );
                        case 1:
                          return InkWell(
                            onTap: () {
                              // Add navigation action for Recommend image
                            },
                            child:
                                buildcard('assets/recommend.png', 'Recommend'),
                          );
                        case 2:
                          return InkWell(
                            onTap: () {
                              // Add navigation action for Nearby image
                            },
                            child: buildcard('assets/nearby.png', 'Nearby'),
                          );
                        case 3:
                          return InkWell(
                            onTap: () {
                              // Add navigation action for Favourite image
                            },
                            child:
                                buildcard('assets/favourite.png', 'Favourite'),
                          );
                        case 4:
                          return InkWell(
                            onTap: () {
                              // Add navigation action for Order Again image
                            },
                            child: buildcard(
                                'assets/orderagain.png', 'Order Again'),
                          );
                        default:
                          return Container();
                      }
                    },
                  ),
                ),
              ),

              Expanded(
                child: ListView(
                  children: [
                    //recommend
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Container(
                        height: 195,
                        color: Color.fromRGBO(229, 216, 186, 0.988),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 8, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Recommended for you',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "FjallaOne",
                                    ),
                                  ),
                                  SizedBox(width: 210),
                                  InkWell(
                                    onTap: () {
                                      // Navigate to the other page when "See more" is tapped
                                    },
                                    child: Text(
                                      'See more',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "FjallaOne",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 0),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: SizedBox(
                                  height: 0,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    separatorBuilder: (context, _) =>
                                        SizedBox(width: 20),
                                    itemBuilder: (context, index) {
                                      switch (index) {
                                        case 0:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to TomorrowLandPage when tapped
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TmrLand()));
                                            },
                                            child: eventimg(
                                                'assets/tmrland.png',
                                                'TomorrowLand',
                                                'Europe, Cake, Bread, Sandw..',
                                                'De Schorre Boom, Belgium'),
                                          );
                                        case 1:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to EDC2023Page when tapped
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EDC()));
                                            },
                                            child: eventimg(
                                                'assets/edc.png',
                                                'EDC 2023',
                                                'Asian, Bread, Pudding, Crossiant',
                                                'Yang Cheng Lake, Suzhou'),
                                          );
                                        case 2:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to SIAMSongkran2023Page when tapped
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Siam()));
                                            },
                                            child: eventimg(
                                                'assets/siam.png',
                                                'SIAM Songkran 2023',
                                                'Asian, Cake, Bread, Sandwich...',
                                                'Urban Yard RCA, Bangkok'),
                                          );
                                        case 3:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to XXXPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/gaia.jpg',
                                                'Gaia Festival',
                                                'Asia, Cake, Bread, Sandwich...',
                                                'Yang Cheng Lake, Suzhou'),
                                          );
                                        case 4:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to XXXPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/tmrwinter.jpg',
                                                'Tomorrowland Winter',
                                                'Europe, Cake, Bread, Sandw..',
                                                'De Schorre Boom, Belgium'),
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

                    // near
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 13, 0, 0),
                      child: Container(
                        height: 179,
                        color: background,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 8, top: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Event near to you ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "FjallaOne",
                                    ),
                                  ),
                                  SizedBox(width: 230),
                                  InkWell(
                                    onTap: () {
                                      // Navigate to the other page when "See more" is tapped
                                    },
                                    child: Text(
                                      'See more',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "FjallaOne",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: SizedBox(
                                  height: 0,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    separatorBuilder: (context, _) =>
                                        SizedBox(width: 20),
                                    itemBuilder: (context, index) {
                                      switch (index) {
                                        case 0:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to TomorrowLandPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/ultra.png',
                                                'Ultra Miami 2024',
                                                'Europe, Cake, Bread, Sandw..',
                                                'De Schorre Boom, Belgium'),
                                          );
                                        case 1:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to EDC2023Page when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EDC()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/vac.jpg',
                                                'VAC 2023',
                                                'Asian, Bread, Pudding, Crossiant',
                                                'Yang Cheng Lake, Suzhou'),
                                          );
                                        case 2:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to SIAMSongkran2023Page when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Siam()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/storm.jpg',
                                                'SIAM Songkran 2023',
                                                'Asian, Cake, Bread, Sandwich...',
                                                'Urban Yard RCA, Bangkok'),
                                          );
                                        case 3:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to XXXPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/ps.jpeg',
                                                'PeakStorm 2024',
                                                'Europe',
                                                'De Schorre Boom, Belgium'),
                                          );
                                        case 4:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to XXXPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/klwp.webp',
                                                'KLWP 2024',
                                                'Europe',
                                                'De Schorre Boom, Belgium'),
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

                    //popular
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Container(
                        height: 195,
                        color: Color.fromRGBO(229, 216, 186, 0.988),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 8, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Popular',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "FjallaOne",
                                    ),
                                  ),
                                  SizedBox(width: 290),
                                  InkWell(
                                    onTap: () {
                                      // Navigate to the other page when "See more" is tapped
                                    },
                                    child: Text(
                                      'See more',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "FjallaOne",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 0),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: SizedBox(
                                  height: 0,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    separatorBuilder: (context, _) =>
                                        SizedBox(width: 20),
                                    itemBuilder: (context, index) {
                                      switch (index) {
                                        case 0:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to TomorrowLandPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/s2o.jpg',
                                                'S2O Festival 2024',
                                                'Europe, Cake, Bread, Sandw..',
                                                'De Schorre Boom, Belgium'),
                                          );
                                        case 1:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to EDC2023Page when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EDC()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/cf.png',
                                                'Creamfields 2024',
                                                'Asian, Bread, Pudding, Crossiant',
                                                'Yang Cheng Lake, Suzhou'),
                                          );
                                        case 2:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to SIAMSongkran2023Page when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Siam()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/pinkfish.jpg',
                                                'PinkFish 2023',
                                                'Asian, Cake, Bread, Sandwich...',
                                                'Urban Yard RCA, Bangkok'),
                                          );
                                        case 3:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to XXXPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/gaia.jpg',
                                                'Gaia China 2024',
                                                'Europe',
                                                'De Schorre Boom, Belgium'),
                                          );
                                        case 4:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to XXXPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/neon.webp',
                                                'Neon 2023',
                                                'Europe',
                                                'De Schorre Boom, Belgium'),
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

                    //favourite
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 13, 0, 0),
                      child: Container(
                        height: 179,
                        color: background,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 8, top: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Favourite',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "FjallaOne",
                                    ),
                                  ),
                                  SizedBox(width: 280),
                                  InkWell(
                                    onTap: () {
                                      // Navigate to the other page when "See more" is tapped
                                    },
                                    child: Text(
                                      'See more',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "FjallaOne",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: SizedBox(
                                  height: 0,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    separatorBuilder: (context, _) =>
                                        SizedBox(width: 20),
                                    itemBuilder: (context, index) {
                                      switch (index) {
                                        case 0:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to TomorrowLandPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/dldk.jpg',
                                                'Dont Let Daddy Know',
                                                'Europe, Cake, Bread, Sandw..',
                                                'De Schorre Boom, Belgium'),
                                          );
                                        case 1:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to EDC2023Page when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EDC()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/DWPXV.jpg',
                                                'DWP Festival 2023',
                                                'Asian, Bread, Pudding, Crossiant',
                                                'Yang Cheng Lake, Suzhou'),
                                          );
                                        case 2:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to SIAMSongkran2023Page when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Siam()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/splp.png',
                                                'SUPALAPA 2024',
                                                'Asian, Cake, Bread, Sandwich...',
                                                'Urban Yard RCA, Bangkok'),
                                          );
                                        case 3:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to XXXPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/s2o.jpg',
                                                'S2O Korea',
                                                'Europe',
                                                'De Schorre Boom, Belgium'),
                                          );
                                        case 4:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to XXXPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/siam.png',
                                                'SSK 2024',
                                                'Europe',
                                                'De Schorre Boom, Belgium'),
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

                    //orderagain
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Container(
                        height: 195,
                        color: Color.fromRGBO(229, 216, 186, 0.988),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 8, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order it again',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "FjallaOne",
                                    ),
                                  ),
                                  SizedBox(width: 250),
                                  InkWell(
                                    onTap: () {
                                      // Navigate to the other page when "See more" is tapped
                                    },
                                    child: Text(
                                      'See more',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "FjallaOne",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 0),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: SizedBox(
                                  height: 0,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    separatorBuilder: (context, _) =>
                                        SizedBox(width: 20),
                                    itemBuilder: (context, index) {
                                      switch (index) {
                                        case 0:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to TomorrowLandPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TmrLand()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/neon.webp',
                                                'Neon 2023',
                                                'Europe, Cake, Bread, Sandw..',
                                                'De Schorre Boom, Belgium'),
                                          );
                                        case 1:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to EDC2023Page when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EDC()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/klwp.webp',
                                                'KLWP 2023',
                                                'Asian, Bread, Pudding, Crossiant',
                                                'Yang Cheng Lake, Suzhou'),
                                          );
                                        case 2:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to SIAMSongkran2023Page when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Siam()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/ps.jpeg',
                                                'PeakStorm 2023',
                                                'Asian, Cake, Bread, Sandwich...',
                                                'Urban Yard RCA, Bangkok'),
                                          );
                                        case 3:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to XXXPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/splp.png',
                                                'Supalapa 2024',
                                                'Europe',
                                                'De Schorre Boom, Belgium'),
                                          );
                                        case 4:
                                          return InkWell(
                                            onTap: () {
                                              // Navigate to XXXPage when tapped
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MySettings.Settings()),
                                              );
                                            },
                                            child: eventimg(
                                                'assets/vac.jpg',
                                                'VAC China 2024',
                                                'Europe',
                                                'De Schorre Boom, Belgium'),
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
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildcard(String imagePath, String title) => ClipOval(
        child: Container(
          width: 100,
          color: lightbrown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontFamily: "FjallaOne",
                    color: Colors.black),
              )
            ],
          ),
        ),
      );

  Widget eventimg(String imagePath, String title, String description,
          String location) =>
      Container(
        width: 150,
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 200,
                height: 100,
                fit: BoxFit.fitHeight,
                
              ),
            ),
            //SizedBox(height: 5,),
            Transform.translate(
              
              offset: Offset(0, 5),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "FjallaOne",
                  color: Colors.black,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 0),
              child: Text(
                description,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: "PathwayGothicOne",
                    color: Colors.black),
              ),
            ),
            Transform.translate(
              offset: Offset(
                  -3, -4), // Adjust the vertical offset for the location
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 13,
                    color: Colors.black,
                  ),
                  SizedBox(width: 0), // Adjusted space between icon and text
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "PathwayGothicOne",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
