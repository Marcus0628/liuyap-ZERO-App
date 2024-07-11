// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zero/pages/Profile/howZeroWorks.dart';
import 'package:zero/pages/Profile/joinZero.dart';
import 'package:zero/pages/Profile/privacyPolicy.dart';
import 'package:zero/pages/Profile/termsConditions.dart';
import 'package:zero/pages/Profile/userProfile.dart';

import 'package:zero/styles/color.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
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
            //       MaterialPageRoute(builder: (context) => UserProfile()),
            //     );
            //   },
            //   icon: Icon(Icons.arrow_back_ios),
            //   color: word,
            // ),
            actions: [
              Transform.translate(
                offset: Offset(2, 1),
                child: IconButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Notifications()),
                    // );
                  },
                  icon: Icon(Icons.notifications_none_outlined),
                  color: word,
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(25),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8.0),
                    Text(
                      "Help Center",
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
              // First Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //How can we help?
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text(
                          "How can we help?",
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

              // Second row
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "How ZERO works?",
                      style: TextStyle(
                        color: word,
                        fontSize: 21,
                        fontFamily: "FjallaOne",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HowZeroWorks()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Third row
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Join ZERO",
                      style: TextStyle(
                        color: word,
                        fontSize: 21,
                        fontFamily: "FjallaOne",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => JoinZero()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Fourth row
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        color: word,
                        fontSize: 21,
                        fontFamily: "FjallaOne",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermsConditions()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Fifth row
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Privacy policy",
                      style: TextStyle(
                        color: word,
                        fontSize: 21,
                        fontFamily: "FjallaOne",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicy()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              //Row 6
              SizedBox(
                height: 240,
              ),

              //Row 7
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: [
                        Transform.translate(
                          offset: Offset(30,90),
                          child: Text(
                            "Call us",
                            style: TextStyle(
                              color: word,
                              fontSize: 15,
                              fontFamily: "FjallaOne",
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(230,90),
                          child: Text(
                            "Email us",
                            style: TextStyle(
                              color: word,
                              fontSize: 15,
                              fontFamily: "FjallaOne",
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //Row 8
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: [
                        Transform.translate(
                          offset: Offset(30, 90),
                          child: Text(
                            "+60 11-23456789",
                            style: TextStyle(
                              color: word,
                              fontSize: 15,
                              fontFamily: "FjallaOne",
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(170, 90),
                          child: Text(
                            "zero@gmail.com",
                            style: TextStyle(
                              color: word,
                              fontSize: 15,
                              fontFamily: "FjallaOne",
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
