// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import 'package:zero/pages/Settings/addAddress.dart';
import 'package:zero/pages/home/cart.dart';
import 'package:zero/pages/home/edc.dart';
import 'package:zero/pages/home/siam.dart';
import 'package:zero/pages/home/tmrland.dart';
import 'package:zero/pages/Discover/locations.dart' as locations;

import 'package:zero/styles/color.dart';



class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

const kGoogleApiKey = 'AIzaSyBP8V2wYPWSrUmn2-lWSMzJhS_er23Nt8I';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _DiscoverState extends State<Discover> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    if(!mounted) return;
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(3.133445, 101.684609), zoom: 7);

  Set<Marker> markersList = {};
  late String chosenAddress = ''; // Initialize chosenAddress to an empty string

  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;

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
    return Scaffold(
      key: homeScaffoldKey,
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

      body: Column(
        children: [
          Container(
            height: 400,
            width: 1000,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: initialCameraPosition,
              markers: _markers.values.toSet(),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 10, left: 15),
          //   child: ElevatedButton(
          //     style: searchButton,
          //     onPressed: _handlePressButton,
          //     child: const Text(
          //       "Search Locations",
          //       style: TextStyle(color: Colors.black),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: 12, left: 8),
            child: SizedBox(
              height: 229,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (context, _) => SizedBox(width: 10),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => TmrLand()),
                          );
                        },
                        child: buildcard(
                          'assets/tmrland.png',
                          'TomorrowLand 2023',
                          'Europe',
                          'Noodles, Burges, Desserts, Halal',
                          'De Schorre Boom, Belgium',
                          'RM4.90'
                        ),
                      );
                    case 1:
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => EDC()),
                          );
                        },
                        child: buildcard(
                          'assets/edc.png',
                          'EDC 2023',
                          'Asian',
                          'Bread, Pudding, Crossiant',
                          'Yang Cheng Lake, Suzhou',
                          'RM4.90'
                        ),
                      );
                    case 2:
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Siam()),
                          );
                        },
                        child: buildcard(
                          'assets/siam.png',
                          'Siam 2023',
                          'Asian',
                          'Cake, Bread, Sandwich',
                          'Urban Yard RCA, Bangkok',
                          'RM4.90'
                        ),
                      );

                    default:
                      return Container();
                  }
                },
              ),
            ),
          ),
        ]
      )
    );
  }

  Widget buildcard(
    String imagePath, 
    String title, 
    String categories,
    String description, 
    String location, 
    String rm) => Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: lightbrown.withOpacity(0.3)),
          height: 229,
          width: 171,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(
                  imagePath,
                  width: 153,
                  height: 86,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontFamily: "FjallaOne",
                    color: Colors.black
                  ),
                )
              ),
              const SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  categories,
                  style: TextStyle(
                    fontSize: 9,
                    fontFamily: "FjallaOne",
                    color: Colors.grey
                  ),
                )
              ),
              const SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 9,
                    fontFamily: "FjallaOne",
                    color: Colors.grey
                  ),
                )
              ),
              const SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  location,
                  style: TextStyle(
                    fontSize: 9,
                    fontFamily: "FjallaOne",
                    color: Colors.grey
                  ),
                )
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  rm,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontFamily: "FjallaOne",
                    color: Colors.black
                  ),
                )
              ),
            ],
          ),
        ),
      );

    Future<void> _handlePressButton() async {
      Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search',
          suffixIcon: Icon(Icons.search),
          contentPadding: const EdgeInsets.only(left: 20, bottom: 5, right: 5),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white)
          )
        ),
        components: [
          Component(Component.country, "mys"),
        ],
      );

      if (p != null) {
        displayPrediction(p, homeScaffoldKey.currentState);
      }
    }

    Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {
      GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(
      Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name),
      ),
    );

    setState(() {
      chosenAddress = detail.result.formattedAddress ?? '';
    });

    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
