// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zero/pages/Profile/userProfile.dart';
import 'package:zero/styles/button.dart';

import 'package:zero/styles/color.dart';

class PointSystem extends ChangeNotifier {
  int _totalPoints = 0;

  int get totalPoints => _totalPoints;

  void updateTotalPoints(int pointsEarned) {
    _totalPoints += pointsEarned;
    notifyListeners(); // Notify listeners about state change
  }
}

class PointSystemPage extends StatefulWidget {
  const PointSystemPage({Key? key}) : super(key: key);

  @override
  State<PointSystemPage> createState() => _PointSystemPageState();
}

class _PointSystemPageState extends State<PointSystemPage> {
  bool isClicked1 = false;
  bool isClicked2 = false;
  bool isClicked3 = false;
  bool isClicked4 = false;
  int totalPoints = 21;
  // PointSystem pointSystem = PointSystem();

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: background,
            title: null,
            leading: BackButton(),
            // IconButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   icon: Icon(Icons.arrow_back_ios),
            //   color: word,
            // ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer<PointSystem>(builder: (context, pointSystem, child) {
                return Column(
                  children: [
                    //Progress bar
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator(
                            value: pointSystem.totalPoints / 500,
                            strokeWidth: 10,
                            color: Colors.pinkAccent[100],
                            //color: Color.fromARGB(255, 255, 235, 197),
                            backgroundColor: cancel,
                          ),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                pointSystem.totalPoints.toString(),
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'points',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: word,
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ],
                );
              }),

              // First Row
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text(
                          "Earn 1 points for every RM1 spent",
                          style: TextStyle(
                            color: word,
                            fontSize: 21,
                            fontFamily: "PathwayGothicOne",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Second row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Rewards & Redeem
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text(
                          "Rewards & Redeem",
                          style: TextStyle(
                            color: word,
                            fontSize: 21,
                            fontFamily: "PathwayGothicOne",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //Third row(button)
              SizedBox(height: 10),
              Container(
                width: 235,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isClicked1 = !isClicked1;
                    });
                  },
                  style: uploadButton,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "10% off entire order",
                                style: TextStyle(
                                  color: word,
                                  fontSize: 15,
                                  fontFamily: "FjallaOne",
                                  fontWeight: isClicked1
                                      ? FontWeight.w200
                                      : FontWeight.bold,
                                ),
                              ),
                              Text(
                                "FREE",
                                style: TextStyle(
                                  color: Colors.red[300],
                                  fontSize: 15,
                                  fontFamily: "FjallaOne",
                                  fontWeight: isClicked1
                                      ? FontWeight.w200
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            isClicked1 ? Icons.lock_outlined : Icons.lock_open,
                            size: 20,
                            color: isClicked1 ? Colors.grey : word,
                          ),
                        ]),
                  ),
                ),
              ),

              //Fourth row
              SizedBox(height: 10),
              Container(
                width: 235,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isClicked2 = !isClicked2;
                    });
                  },
                  style: uploadButton,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "5% off entire order",
                                style: TextStyle(
                                  color: word,
                                  fontSize: 15,
                                  fontFamily: "FjallaOne",
                                  fontWeight: isClicked2
                                      ? FontWeight.w200
                                      : FontWeight.bold,
                                ),
                              ),
                              Text(
                                "FREE",
                                style: TextStyle(
                                  color: Colors.red[300],
                                  fontSize: 15,
                                  fontFamily: "FjallaOne",
                                  fontWeight: isClicked2
                                      ? FontWeight.w200
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            isClicked2 ? Icons.lock_outlined : Icons.lock_open,
                            size: 20,
                            color: isClicked2 ? Colors.grey : word,
                          ),
                        ]),
                  ),
                ),
              ),

              //Fifth row
              SizedBox(height: 10),
              Container(
                width: 235,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isClicked3 = !isClicked3;
                    });
                  },
                  style: uploadButton,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "5% off entire order",
                                style: TextStyle(
                                  color: word,
                                  fontSize: 15,
                                  fontFamily: "FjallaOne",
                                  fontWeight: isClicked3
                                      ? FontWeight.bold
                                      : FontWeight.w200,
                                ),
                              ),
                              Text(
                                "FREE",
                                style: TextStyle(
                                  color: Colors.red[300],
                                  fontSize: 15,
                                  fontFamily: "FjallaOne",
                                  fontWeight: isClicked3
                                      ? FontWeight.normal
                                      : FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            isClicked3 ? Icons.lock_open : Icons.lock_outlined,
                            size: 20,
                            color: isClicked3 ? word : Colors.grey,
                          ),
                        ]),
                  ),
                ),
              ),

              //Sixth row
              SizedBox(height: 10),
              Container(
                width: 235,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isClicked4 = !isClicked4;
                    });
                  },
                  style: uploadButton,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "10% off entire order",
                                style: TextStyle(
                                  color: word,
                                  fontSize: 15,
                                  fontFamily: "FjallaOne",
                                  fontWeight: isClicked4
                                      ? FontWeight.bold
                                      : FontWeight.w200,
                                ),
                              ),
                              Text(
                                "FREE",
                                style: TextStyle(
                                  color: Colors.red[300],
                                  fontSize: 15,
                                  fontFamily: "FjallaOne",
                                  fontWeight: isClicked4
                                      ? FontWeight.normal
                                      : FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            isClicked4 ? Icons.lock_open : Icons.lock_outlined,
                            size: 20,
                            color: isClicked4 ? word : Colors.grey,
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
