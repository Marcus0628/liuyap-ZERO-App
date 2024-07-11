// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:zero/pages/Settings/settings.dart';

import 'package:zero/styles/color.dart';


class Notifications extends StatefulWidget {
  const Notifications({super.key});
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool pushNotificationsSwitched = true;
  bool emailSwitched = false;

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
            color: word,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(25),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Center the contents horizontally
                children: [
                  Icon(
                    Icons.notifications,
                    size: 40,
                    color: word,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "Notifications",
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
        body: ListView(
          children: [
            Container(
              width: double.maxFinite, // center,
              margin: EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Container(
                    width: 390,
                    height: 90,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Transform.translate(
                            offset: Offset(0, 22),
                            child: Icon(
                              Icons.notifications_active_rounded,
                              size: 40,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 20.0),
                              child: Text(
                                "Push Notifications",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .black, // Change 'word' to the desired color
                                  fontFamily: "FjallaOne",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Nearby events, updates and more",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "FjallaOne",
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Transform.translate(
                              offset: Offset(0, -20),
                              child: Switch(
                                value: pushNotificationsSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    pushNotificationsSwitched = value;
                                  });
                                },
                                activeColor: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Emails
                  SizedBox(height: 16),
                  Container(
                    width: 390,
                    height: 90,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Transform.translate(
                            offset: Offset(0, 22),
                            child: Icon(
                              Icons.notifications_off_rounded,
                              size: 40,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 20.0),
                              child: Text(
                                "Emails",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: word,
                                  fontFamily: "FjallaOne",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Promotions, updates and more",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "FjallaOne",
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(), // To push the icon to the right
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Transform.translate(
                              offset: Offset(0, -20),
                              child: Switch(
                                value: emailSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    emailSwitched = value;
                                  });
                                },
                                activeColor: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
