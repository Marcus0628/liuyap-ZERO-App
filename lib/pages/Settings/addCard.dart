// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:zero/styles/color.dart';
import 'package:zero/styles/button.dart';

import 'package:zero/pages/Settings/settings.dart';
import 'package:zero/pages/Settings/paymentMethods.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});
  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
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
            //       MaterialPageRoute(builder: (context) => PaymentMethods()),
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
                      Icons.credit_card_rounded,
                      size: 40,
                      color: word,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      "Card Details",
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
              Container(
                width: double.maxFinite, // center,
                margin: EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    //Name
                    SizedBox(height: 16),
                    Container(
                      width: 390,
                      height: 105,
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
                      child: Column(
                        children: [
                          //First Column
                          Transform.translate(
                            offset: Offset(-120,
                                12), // Adjust the offset to lower the text
                            child: Text(
                              "Name on Card",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: word,
                                fontFamily: "FjallaOne",
                              ),
                            ),
                          ),

                          // Second Column
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: 350,
                              height: 35,
                              child: TextField(
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(32, 138, 112, 112),
                                    hintText: "",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "FjallaOne",
                                    ),
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Number
                    SizedBox(height: 25),
                    Container(
                      width: 390,
                      height: 105,
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
                      child: Column(
                        children: [
                          //First Column
                          Transform.translate(
                            offset: Offset(-123,
                                12), // Adjust the offset to lower the text
                            child: Text(
                              "Card Number",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: word,
                                fontFamily: "FjallaOne",
                              ),
                            ),
                          ),

                          // Second Column
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: 350,
                              height: 35,
                              child: TextField(
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(32, 138, 112, 112),
                                    hintText: "",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "FjallaOne",
                                    ),
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //CVV & Expiry Date
                    SizedBox(height: 25),
                    Row(
                      children: [
                        //CVV
                        Container(
                          width: 185,
                          height: 105,
                          margin: EdgeInsets.only(left: 22.0, right: 17.0),
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
                          child: Column(
                            children: [
                              //First Column
                              Transform.translate(
                                offset: Offset(-55,
                                    12), // Adjust the offset to lower the text
                                child: Text(
                                  "CVV",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: word,
                                    fontFamily: "FjallaOne",
                                  ),
                                ),
                              ),

                              // Second Column
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  width: 170,
                                  height: 35,
                                  child: TextField(
                                    maxLines: 1,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(32, 138, 112, 112),
                                        hintText: "",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "FjallaOne",
                                        ),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Expiry Date
                        Container(
                          width: 185,
                          height: 105,
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
                          child: Column(
                            children: [
                              //First Column
                              Transform.translate(
                                offset: Offset(-27,
                                    12), // Adjust the offset to lower the text
                                child: Text(
                                  "Expiry Date",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: word,
                                    fontFamily: "FjallaOne",
                                  ),
                                ),
                              ),

                              // Second Column
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  width: 170,
                                  height: 35,
                                  child: TextField(
                                    maxLines: 1,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(32, 138, 112, 112),
                                        hintText: "MM/YY",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "FjallaOne",
                                        ),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //finish

                    //Add card
                    SizedBox(
                      height: 200.0,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: proceedButton,
                      child: Text(
                        "Add Card",
                        style: TextStyle(
                          color: word,
                          fontSize: 28,
                          fontFamily: "FjallaOne",
                        ),
                      ),
                    ),

                    //Cancel
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Settings()),
                        );
                      },
                      style: cancelButton,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Color(0xff414141),
                          fontSize: 28,
                          fontFamily: "FjallaOne",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
