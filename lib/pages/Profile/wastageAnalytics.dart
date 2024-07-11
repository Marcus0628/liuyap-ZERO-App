// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:zero/pages/Profile/userProfile.dart';
import 'package:zero/styles/button.dart';

import 'package:zero/styles/color.dart';
import 'package:zero/pages/Profile/information.dart';

class WastageAnalytics extends StatefulWidget {
  const WastageAnalytics({super.key});

  @override
  State<WastageAnalytics> createState() => _WastageAnalyticsState();
}

class _WastageAnalyticsState extends State<WastageAnalytics> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: topbar,
          title: null,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
            color: word,
          ),
          actions: [
            Transform.translate(
              offset: Offset(0, 1),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Information()),
                  );
                },
                icon: Icon(Icons.perm_device_info_outlined),
                color: word,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(25),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Center the contents horizontally
                children: [
                  SizedBox(width: 8.0),
                  Text(
                    "Wastage Analytics",
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // First Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    children: [
                      Text(
                        "You save:",
                        style: TextStyle(
                          color: word,
                          fontSize: 26,
                          fontFamily: "PathwayGothicOne",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //Second row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Total weight of waste food that have saved
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => AccountDetails()),
                      // );
                    },
                    style: settingsButton,
                    child: Center(
                      child: Column(
                        children: [
                          Transform.translate(
                            offset: Offset(0, 5),
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              color: word,
                              size: 100,
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, 5),
                            child: Text(
                              "5kg",
                              style: TextStyle(
                                color: word,
                                fontSize: 25,
                                fontFamily: "FjallaOne",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Co2e avoided
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Address()),
                      // );
                    },
                    style: settingsButton,
                    child: Center(
                      child: Column(
                        children: [
                          Transform.translate(
                            offset: Offset(0, 5),
                            child: Icon(
                              Icons.co2_outlined,
                              color: word,
                              size: 100,
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, 5),
                            child: Text(
                              "12.5kg",
                              style: TextStyle(
                                color: word,
                                fontSize: 25,
                                fontFamily: "FjallaOne",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Third row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Electricity
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => PaymentMethods()),
                      // );
                    },
                    style: settingsButton,
                    child: Column(
                      children: [
                        Transform.translate(
                          offset: Offset(0, 5),
                          child: Icon(
                            Icons.electric_bolt_outlined,
                            color: word,
                            size: 90,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, 5),
                          child: Text(
                            "5kWh",
                            style: TextStyle(
                              color: word,
                              fontSize: 25,
                              fontFamily: "FjallaOne",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
