import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:zero/pages/Organiser/organiserHomePage.dart';
import 'package:zero/pages/Organiser/organiser_navigation_menu.dart';
import 'package:zero/styles/button.dart';
import 'package:zero/styles/color.dart';
import 'package:expandable/expandable.dart';

class EditEvent extends StatefulWidget {
  EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

const kGoogleApiKey = 'AIzaSyBP8V2wYPWSrUmn2-lWSMzJhS_er23Nt8I';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _EditEventState extends State<EditEvent> {
  int value = 0;
  int count = 0;
  var hour = 0;
  var minute = 0;
  var timeFormat = 'AM';
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(3.0648, 101.6168), zoom: 17);

  Set<Marker> markersList = {};
  late String chosenAddress = '';
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: topbar,
        title: null,
        centerTitle: true,
        actions: [
          CloseButton(
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const OrganiserHomePage()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(25),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the contents horizontally
              children: [
                const SizedBox(width: 10.0),
                Text(
                  "Edit Post",
                  style: TextStyle(
                    fontSize: 28,
                    color: word,
                    fontFamily: "FjallaOne",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 15),
              child: Flexible(
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Write a caption...',
                          hintStyle:
                              TextStyle(color: Color.fromRGBO(0, 0, 0, 0.45)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none))))),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 177,
                height: 100,
                decoration: BoxDecoration(
                  color: lightbrown,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color.fromRGBO(255, 236, 208, 1),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/tmrland.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Container(
                  width: 110,
                  height: 100,
                  decoration: BoxDecoration(
                    color: lightbrown,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color.fromRGBO(255, 236, 208, 1),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.add,
                    color: Color(0xffA79478),
                    size: 45,
                  )),
            ]),
          ),
          SizedBox(height: 25),
          Divider(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            height: 25,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: ExpandablePanel(
                  header: Text('Add Location',
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  collapsed: SizedBox.shrink(),
                  expanded: Center(
                    child: Container(
                      height: 300,
                      width: 300,
                      margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: Colors.black),
                      ),
                      child: Stack(children: [
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: ElevatedButton(
                            onPressed: _handlePressButton,
                            child: Text(
                              'Search',
                              style: TextStyle(color: word),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(255, 236, 208,
                                  1), // Change this to the desired color
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Positioned(
                            bottom: 16.0,
                            left: 16.0,
                            right: 16.0,
                            child: Card(
                                color: Colors.grey.shade100,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      chosenAddress,
                                      style: TextStyle(
                                          fontFamily: 'PathwayGothicOne',
                                          fontSize: 18.0),
                                    )))),
                      ]),
                    ),
                  ))),
          Divider(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            height: 25,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: ExpandablePanel(
                  header: Text('Add Collect Time',
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  collapsed: SizedBox.shrink(),
                  expanded: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pick Up Time: ${hour.toString().padLeft(2, '0')}: ${minute.toString().padLeft(2, '0')} ${timeFormat}',
                            style: TextStyle(color: word, fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 17, vertical: 2),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 236, 208, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  NumberPicker(
                                    minValue: 0,
                                    maxValue: 12,
                                    value: hour,
                                    zeroPad: true,
                                    infiniteLoop: true,
                                    itemWidth: 70,
                                    itemHeight: 50,
                                    onChanged: (value) {
                                      setState(() {
                                        hour = value;
                                      });
                                    },
                                    textStyle: TextStyle(
                                        color: Colors.black38, fontSize: 20),
                                    selectedTextStyle: TextStyle(
                                        color: Colors.black87, fontSize: 25),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                              color: Colors.black,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.black,
                                            ))),
                                  ),
                                  NumberPicker(
                                    minValue: 0,
                                    maxValue: 59,
                                    value: minute,
                                    zeroPad: true,
                                    infiniteLoop: true,
                                    itemWidth: 70,
                                    itemHeight: 50,
                                    onChanged: (value) {
                                      setState(() {
                                        minute = value;
                                      });
                                    },
                                    textStyle: TextStyle(
                                        color: Colors.black38, fontSize: 20),
                                    selectedTextStyle: TextStyle(
                                        color: Colors.black87, fontSize: 25),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                              color: Colors.black,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.black,
                                            ))),
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            timeFormat = 'AM';
                                          });
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 17, vertical: 7),
                                            decoration: BoxDecoration(
                                              color: timeFormat == 'AM'
                                                  ? Colors.grey.shade800
                                                  : Colors.grey.shade700,
                                              border: Border.all(
                                                color: timeFormat == 'AM'
                                                    ? Colors.grey
                                                    : Colors.grey.shade700,
                                              ),
                                            ),
                                            child: Text(
                                              'AM',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )),
                                      ),
                                      SizedBox(height: 15),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              timeFormat = 'PM';
                                            });
                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 17, vertical: 7),
                                              decoration: BoxDecoration(
                                                color: timeFormat == 'PM'
                                                    ? Colors.grey.shade800
                                                    : Colors.grey.shade700,
                                                border: Border.all(
                                                  color: timeFormat == 'PM'
                                                      ? Colors.grey
                                                      : Colors.grey.shade700,
                                                ),
                                              ),
                                              child: Text(
                                                'PM',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ))),
                                    ],
                                  )
                                ],
                              ))
                        ]),
                  ))),
          Divider(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: ExpandablePanel(
                header: Text('Add Description',
                    style: TextStyle(
                      fontSize: 12,
                    )),
                collapsed: SizedBox.shrink(),
                expanded: Flexible(
                    child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Description...',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.45),
                                fontSize: 14),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none))))),
          ),
          Divider(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            height: 25,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: ExpandablePanel(
                header: Text('Add Quantity',
                    style: TextStyle(
                      fontSize: 12,
                    )),
                collapsed: SizedBox.shrink(),
                expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Medium Treasure Box",
                            style: TextStyle(fontSize: 15, color: word),
                          ),
                          Expanded(child: Container()),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color.fromRGBO(255, 236, 208, 1),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Color(0xff414141),
                                size: 14,
                              ),
                              onPressed: () {
                                setState(() {
                                  value++;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 25),
                          Text(
                            '$value', // Display the updated value directly
                            style: TextStyle(
                                fontSize: 15, color: Color(0xff414141)),
                          ),
                          SizedBox(width: 30),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color.fromRGBO(255, 236, 208, 1),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: Color(0xff414141),
                                size: 14,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (value > 0) value--;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 25),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Large Treasure Box",
                              style: TextStyle(fontSize: 15, color: word),
                            ),
                            Expanded(child: Container()),
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color.fromRGBO(255, 236, 208, 1),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Color(0xff414141),
                                  size: 14,
                                ),
                                onPressed: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 25),
                            Text(
                              '$count', // Display the updated value directly
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff414141),
                              ),
                            ),
                            SizedBox(width: 30),
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color.fromRGBO(255, 236, 208, 1),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  color: Color(0xff414141),
                                  size: 14,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (count > 0) count--;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 25),
                          ]),
                    ]),
              )),
          const Divider(
            color: Color.fromRGBO(0, 0, 0, 0.13),
            height: 25,
          ),
          SizedBox(height: 110),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20), // Adjust padding as needed
              child: ElevatedButton(
                style: buttonPrimary,
                child: const Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'PathwayGothicOne',
                    color: Color(0xff414141),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => OrganiserNavigationMenu()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                borderSide: BorderSide(color: Colors.white))),
        components: [
          Component(Component.country, "pk"),
          Component(Component.country, "mys")
        ]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {
      chosenAddress = detail.result.formattedAddress ?? '';
    });

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 17.0));
  }
}
