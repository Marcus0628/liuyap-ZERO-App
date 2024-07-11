
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:zero/styles/color.dart';
import 'package:zero/styles/button.dart';

import 'package:zero/pages/Settings/settings.dart';
import 'package:zero/pages/Settings/paymentMethods.dart';


class CardDetails extends StatefulWidget{
  const CardDetails({super.key});
  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails>{

  @override
  Widget build(BuildContext context) => WillPopScope (
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
                mainAxisAlignment:MainAxisAlignment.center, // Center the contents horizontally
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


        body: ListView(
          children: [
            Container(
              width: double.maxFinite, // center,
              margin: EdgeInsets.only(top:12),
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
                        //First Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Transform.translate(
                                offset: Offset(0, 12), 
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
                            ),
                              
                            Padding(
                              padding: EdgeInsets.only(right: 25),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Transform.translate(
                                  offset: Offset(0, 11), 
                                  child: Icon(
                                    Icons.edit,
                                    size: 26,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        //Second Row
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                
                              SizedBox(  
                                width: 350,   
                                height: 35,
                                child: TextField(
                                  maxLines: 1,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(32, 138, 112, 112),
                                    hintText: "Marcus Ho",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "FjallaOne",
                                    ),
                                    border: OutlineInputBorder()
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],  
                    ),
                  ),

                  //Card number
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
                        //First Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                              child:Transform.translate(
                                offset: Offset(0, 12), // Adjust the offset to lower the text
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
                            ),
                              
                            Padding(
                              padding: EdgeInsets.only(right: 25),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Transform.translate(
                                  offset: Offset(0, 11), // Adjust the offset to lower the icon
                                  child: Icon(
                                    Icons.edit,
                                    size: 26,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        //Second Row
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(  
                                width: 350,   
                                height: 35,
                                child: TextField(
                                  obscureText: true,
                                  maxLines: 1,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(32, 138, 112, 112),
                                    hintText: "**** **** **** 2344",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "FjallaOne",
                                    ),
                                    border: OutlineInputBorder()
                                  ),
                                )
                              ),
                            ],
                          ),
                        )
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
                            //First Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Transform.translate(
                                  offset: Offset(20, 12), // Adjust the offset to lower the text
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
                                  
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Transform.translate(
                                    offset: Offset(-20, 11), // Adjust the offset to lower the icon
                                    child: Icon(
                                      Icons.edit,
                                      size: 26,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      
                            //Second Row
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(  
                                    width: 145,   
                                    height: 35,
                                    child: TextField(
                                      obscureText: true,
                                      maxLines: 1,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color.fromARGB(32, 138, 112, 112),
                                        hintText: "***",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "FjallaOne",
                                        ),
                                        border: OutlineInputBorder()
                                      ),
                                    )
                                  ),
                                ],
                              ), 
                            )
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
                            //First Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Transform.translate(
                                  offset: Offset(20, 12), // Adjust the offset to lower the text
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
                                  
                               Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Transform.translate(
                                    offset: Offset(-20, 11), // Adjust the offset to lower the icon
                                    child: Icon(
                                      Icons.edit,
                                      size: 26,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      
                            //Second Row
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(  
                                    width: 145,   
                                    height: 35,
                                    child: TextField(
                                      maxLines: 1,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color.fromARGB(32, 138, 112, 112),
                                        hintText: "01/01",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "FjallaOne",
                                        ),
                                        border: OutlineInputBorder()
                                      ),
                                    )
                                  ),
                                ],
                              ), 
                            )
                          ],  
                        ),
                      ),
                    ],
                  ),
                  //finish

                  //Save
                  SizedBox(height: 200.0,),
                  ElevatedButton(
                    onPressed: (){},
                    style: proceedButton,
                    child: Text(
                      "Save Changes",
                      style: TextStyle(
                        color: word,
                        fontSize: 28,
                        fontFamily: "FjallaOne",
                      ),
                    ),
                  ),

                  //Cancel
                  SizedBox(height: 20.0,),
                  ElevatedButton(
                    onPressed: (){
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