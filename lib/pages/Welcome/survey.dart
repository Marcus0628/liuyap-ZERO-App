// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:zero/pages/Organiser/pbt.dart';

import 'package:zero/pages/Welcome/signinpage.dart';

import 'package:zero/styles/button.dart';
import 'package:zero/styles/color.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class Survey1 extends StatelessWidget {
  const Survey1({super.key});
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
            style: TextStyle(color: Color(0xff414141)),
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        TextButton(
          child: Text(
            'Discard',
            style: TextStyle(color: Color(0xff414141)),
          ),
          onPressed: () => Navigator.pop(context, true),
        ),
      ]
    ),
  );

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
        child: Column(
          children: [
            SizedBox(height: 35,),
            Text(
              'Let me know you more...',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'FjallaOne',
                color: Color(0xff414141)
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 10.0,
                animationDuration: 2500,
                percent: 0,
                // center:
                //     Text("33.3%", style: TextStyle(color: Colors.black)),
                barRadius: Radius.circular(15),
                progressColor: Colors.white,
              )
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, 
                children: [
                  Text(
                    '0% Completed',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'FjallaOne',
                      color: Color(0xff414141)
                    ),
                  ),
                ]
              ),
            ),
            SizedBox(height: 70,),
            ElevatedButton(
              style: buttonPrimary,
              child: const Text('Low Income Group',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'FjallaOne',
                  color: Color(0xff414141),
                )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Survey2Salary()),
                );
              },
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              style: buttonPrimary,
              child: const Text('B40 Group',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'FjallaOne',
                  color: Color(0xff414141),
                )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Survey2Salary()),
                );
              },
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              style: buttonPrimary,
              child: const Text('Student',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'FjallaOne',
                  color: Color(0xff414141),
                )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Survey2Student()),
                );
              },
            ),
          
            SizedBox(height: 30,),
            ElevatedButton(
              style: buttonPrimary,
              child: const Text(
                'None of the above',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'FjallaOne',
                  color: Color(0xff414141),
                )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Survey3Location()),
                );
              },
            ),
          ],
        )
      ),
    ),
  );
}

class Survey2Student extends StatefulWidget {
  const Survey2Student({super.key});

  @override
  State<Survey2Student> createState() => _Survey2StudentState();
}

class _Survey2StudentState extends State<Survey2Student> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    setState(() {
      uploadTask = null;
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      return true;
    },
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: background, 
        leading: BackButton()
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Please provide your student card',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'FjallaOne',
                color: Color(0xff414141)
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 10.0,
                animationDuration: 2500,
                percent: 0.3,
                // center:
                //     Text("33.3%", style: TextStyle(color: Colors.black)),
                barRadius: Radius.circular(15),
                progressColor: Colors.white,
              )
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, 
                children: [
                  Text(
                    '33% Completed',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'FjallaOne',
                      color: Color(0xff414141)
                    ),
                  ),
                ]
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 300,
              width: 310,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                  side: BorderSide(
                    width: 2, 
                    color: Colors.black
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (pickedFile != null)
                        Container(
                          height: 235,
                          width: 270,
                          color: Colors.white,
                          child: Center(
                            child: Image.file(
                              File(pickedFile!.path!),
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                    ],
                  )
                )
              ),
            ),
            SizedBox(height: 20,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: uploadButton,
                  child: const Text(
                    'Choose Image',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'FjallaOne',
                      color: Color(0xff414141),
                    )
                  ),
                  onPressed: selectFile
                ),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              style: uploadButton,
              child: const Text(
                'Upload Image',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'FjallaOne',
                  color: Color(0xff414141),
                )
              ),
              onPressed: uploadFile),
              
              SizedBox(height: 20),
              buildProgress(),
              
              SizedBox(height: 20,),
              ElevatedButton(
                style: buttonPrimary,
                child: const Text('Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'FjallaOne',
                    color: Color(0xff414141),
                )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Survey3Location()),
                );
              },
            ),
          ],
        )
      ),
    ),
  );

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
    stream: uploadTask?.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final data = snapshot.data!;
        double progress = data.bytesTransferred / data.totalBytes;
        // Check if progress is finite before rounding
        if (progress.isFinite) {
          return SizedBox(
            height: 30,
            width: 325,
            child: Stack(
              fit: StackFit.expand, 
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: const Color.fromARGB(255, 53, 135, 59),
                  borderRadius: BorderRadius.circular(10),
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: const TextStyle(
                      color: Colors.white
                    ),
                  )
                )
              ]
            )
          );
        } else {
          return const SizedBox(height: 50);
        }
      } else {
        return const SizedBox(height: 50);
      }
    }
  );
}

class Survey2Salary extends StatefulWidget {
  
  const Survey2Salary({super.key});

  @override
  State<Survey2Salary> createState() => _Survey2SalaryState();
}

class _Survey2SalaryState extends State<Survey2Salary> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    setState(() {
      uploadTask = null;
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      return true;
    },
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: background, 
        leading: BackButton()
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Please provide your bill salary',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'FjallaOne',
                color: Color(0xff414141),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 10.0,
                animationDuration: 2500,
                percent: 0.3,
                // center:
                //     Text("33.3%", style: TextStyle(color: Colors.black)),
                barRadius: Radius.circular(15),
                progressColor: Colors.white,
              )
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, 
                children: [
                  Text(
                    '33% Completed',
                    style: TextStyle(fontSize: 12),
                  ),
                ]
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 300,
              width: 310,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                  side: BorderSide(
                    width: 2, 
                    color: Colors.black
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (pickedFile != null)
                        Container(
                          height: 235,
                          width: 270,
                          color: Colors.white,
                          child: Center(
                            child: Image.file(
                              File(pickedFile!.path!),
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                    ],
                  )
                )
              ),
            ),
            SizedBox(height: 20,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: uploadButton,
                  child: const Text(
                    'Choose Image',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff414141),
                    )
                  ),
                  onPressed: selectFile
                ),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              style: uploadButton,
              child: const Text(
                'Upload Image',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'FjallaOne',
                  color: Color(0xff414141),
                )
              ),
              onPressed: uploadFile),
              
              SizedBox(height: 20),
              buildProgress(),
              
              SizedBox(height: 20,),
              ElevatedButton(
                style: buttonPrimary,
                child: const Text('Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'FjallaOne',
                    color: Color(0xff414141),
                )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Survey3Location()),
                );
              },
            ),
          ],
        )
      ),
    ),
  );

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
    stream: uploadTask?.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final data = snapshot.data!;
        double progress = data.bytesTransferred / data.totalBytes;
        // Check if progress is finite before rounding
        if (progress.isFinite) {
          return SizedBox(
            height: 30,
            width: 325,
            child: Stack(
              fit: StackFit.expand, 
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: const Color.fromARGB(255, 53, 135, 59),
                  borderRadius: BorderRadius.circular(10),
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: const TextStyle(
                      color: Colors.white
                    ),
                  )
                )
              ]
            )
          );
        } else {
          return const SizedBox(height: 50);
        }
      } else {
        return const SizedBox(height: 50);
      }
    }
  );
}

class Survey3Location extends StatefulWidget {
  const Survey3Location({super.key});

  @override
  State<Survey3Location> createState() => _Survey3LocationState();
}

const kGoogleApiKey = 'AIzaSyCVNxafpb6DAJ5T0gIA1nuDPwbC-0N6HFU';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _Survey3LocationState extends State<Survey3Location> {
  // TextEditingController _addressController = TextEditingController();
  // late bool _isLogged;
  // CameraPosition _cameraPosition =
  //     const CameraPosition(target: LatLng(3.0648, 101.6168), zoom: 17);
  // late LatLng _initialPosition = LatLng(3.0648, 101.6168);

  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(3.0648, 101.6168), zoom: 17);

  Set<Marker> markersList = {};
  late String chosenAddress = '';
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      return true;
    },
    child: Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        backgroundColor: background, 
        leading: BackButton()
      ),
      body: SafeArea(
        // GetBuilder<LocationController>(builder: (LocationController){
        //   _addressController.text = '${locationController.placemark.name??''}'
        //   '${locationController.placemark.locality??''}'
        //   '${locationController.placemark.postalCode??''}'
        //   '${locationController.placemark.country??''}';
        // print("address in my view is " + _addressController.text)
        child: Column(
          children: [
            Text(
              'Please locate your current location',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'FjallaOne',
                color: Color(0xff414141)
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 10.0,
                animationDuration: 2500,
                percent: 0.67,
                // center:
                //     Text("33.3%", style: TextStyle(color: Colors.black)),
                barRadius: Radius.circular(15),
                progressColor: Colors.white,
              )
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, 
                children: [
                  Text(
                    '67% Completed',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'FjallaOne',
                      color: Color(0xff414141)
                    ),
                  ),
                ]
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 330,
              width: 330,
              margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 2, color: Colors.black),
              ),
              child: Stack(
                children: [
                  GoogleMap(
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    initialCameraPosition: initialCameraPosition,
                    markers: markersList,
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) {
                      googleMapController = controller;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _handlePressButton,
                    child: const Text("Search Places"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    chosenAddress,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'FjallaOne',
                      color: Color(0xff414141)
                    ),
                  ),
                ),
              ),
            ),
            // Positioned(
            //   bottom: 16.0,
            //   left: 16.0,
            //   right: 16.0,
            //   child: Card(
            //     color: Colors.white,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(
            //         chosenAddress,
            //         style: TextStyle(fontSize: 16.0),
            //       )
            //     )
            //   )
            // ),
                
            SizedBox(height: 30),
            ElevatedButton(
              style: buttonPrimary,
              child: const Text(
                'Confirm Location',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'FjallaOne',
                    color: Color(0xff414141),
                  )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SurveyDone()),
                  );
                },
              ),
            ],
          )
        ),
      ),
    );

    Future<void> _handlePressButton() async {
      Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        //onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white
            )
          )
        ),
        components: [
          Component(Component.country, "pk"),
          Component(Component.country, "mys")
        ]
      );

      displayPrediction(p!, homeScaffoldKey.currentState);
    }


    // void onError(PlacesAutocompleteResponse response) {
    //   homeScaffoldKey.currentState!
    //       .showSnackBar(SnackBar(content: Text(response.errorMessage!)));
    // }

    Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
        GoogleMapsPlaces places = GoogleMapsPlaces(
          apiKey: kGoogleApiKey,
          apiHeaders: await const GoogleApiHeaders().getHeaders()
        );

      PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      markersList.clear();
      markersList.add(
        Marker(
          markerId: const MarkerId("0"),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: detail.result.name)
        )
      );

      setState(() {
        chosenAddress = detail.result.formattedAddress ?? '';
      });

      // Save the location to Firestore after updating chosenAddress
    await saveLocationToFirestore(chosenAddress);

      googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 17.0));
    }

    Future<void> saveLocationToFirestore(String location) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Save the location directly under the user's document in Firestore
        await FirebaseFirestore.instance.collection('Users').doc(user.email).set({
          'Current Location': location,
        }, SetOptions(merge: true)); // Merge option to retain existing data in the user document
        print('Location saved to Firestore for user ${user.email}: $location');
      } else {
        print('No user signed in.');
        // Handle the case where no user is signed in
      }
    } catch (e) {
      print('Error saving location to Firestore: $e');
      // Handle the error as needed
    }
  }
}


class SurveyDone extends StatelessWidget {
  const SurveyDone({super.key});

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      return true;
    },
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: background, 
        leading: BackButton()
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'You are all set',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'FjallaOne',
                color: Color(0xff414141)
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 10.0,
                animationDuration: 2500,
                percent: 1,
                barRadius: Radius.circular(15),
                progressColor: Colors.white,
              )
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, 
                children: [
                  Text(
                    '100% Completed',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'FjallaOne',
                      color: Color(0xff414141)
                    ),
                  ),
                ]
              ),
            ),
            Image.asset(
              'assets/earth.png',
              height: 300,
              width: 400,
            ),
            SizedBox(height: 10,),
            Text(
              "WELL DONE!",
              style: TextStyle(
                fontSize: 27,
                fontFamily: 'FjallaOne',
                color: Color(0xff414141),
              )
            ),
            SizedBox(height: 50,),
            ElevatedButton(
              style: buttonPrimary,
              child: const Text(
                "Let's get started",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'FjallaOne',
                  color: Color(0xff414141),
                )
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              },
            ),
          ],
        )
      ),
    ),
  );
}
