// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:zero/styles/color.dart';

import 'package:zero/pages/Settings/settings.dart';
import 'package:zero/pages/Settings/addCard.dart';
import 'package:zero/pages/Settings/cardDetails.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});
  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
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
            //       MaterialPageRoute(builder: (context) => Settings()),
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
                      "Payment Methods",
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
                    //Mastercard 1
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
                              offset: Offset(0, 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/mastercard.jpg',
                                  width: 80,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 20.0),
                                child: Text(
                                  "MasterCard",
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
                                  "**** **** **** 1234",
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
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CardDetails()),
                                    );
                                  },
                                  icon:
                                      Icon(Icons.keyboard_arrow_right_rounded),
                                  color: word,
                                  iconSize: 35.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Mastercard 2
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
                              offset: Offset(0, 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/mastercard.jpg',
                                  width: 80,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 20.0),
                                child: Text(
                                  "MasterCard",
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
                                  "**** **** **** 3455",
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
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CardDetails()),
                                    );
                                  },
                                  icon:
                                      Icon(Icons.keyboard_arrow_right_rounded),
                                  color: word,
                                  iconSize: 35.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Visacard
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
                              offset: Offset(0, 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/visacard.jpg',
                                  width: 80,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 20.0),
                                child: Text(
                                  "VISA",
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
                                  "**** **** **** 7736",
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
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CardDetails()),
                                    );
                                  },
                                  icon:
                                      Icon(Icons.keyboard_arrow_right_rounded),
                                  color: word,
                                  iconSize: 35.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Touch'n go
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
                              offset: Offset(0, 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/touchngo.jpg',
                                  width: 85,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 30.0),
                                child: Text(
                                  "Touch'N Go",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: word,
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
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CardDetails()),
                                    );
                                  },
                                  icon:
                                      Icon(Icons.keyboard_arrow_right_rounded),
                                  color: word,
                                  iconSize: 35.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //finish

                    //Add Card
                    SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddCard()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 25),
                            child: Row(
                              children: [
                                Transform.translate(
                                  offset: Offset(-5, 11),
                                  child: Icon(
                                    Icons.add, // Your desired icon
                                    color: word,
                                    size:
                                        28, // Adjust the size of the icon as needed
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(0,
                                      12), // Adjust the offset to lower the text
                                  child: Text(
                                    "Add Card",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: word,
                                      fontFamily: "FjallaOne",
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
            ],
          ),
        ),
      );
}
