// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Import flutter_rating_bar package
import 'package:provider/provider.dart';
import 'package:zero/model/itemmodel.dart';
import 'package:zero/navigation_menu.dart';

import 'package:zero/pages/Home/cart.dart';
import 'package:zero/pages/Home/homepage.dart';

import 'package:zero/styles/color.dart';

class OrderSucess extends StatefulWidget {
  const OrderSucess({Key? key}) : super(key: key);

  @override
  State<OrderSucess> createState() => _OrderSucessState();
}

class _OrderSucessState extends State<OrderSucess> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: topbar,
          title: Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Order Success",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: word,
                    fontFamily: "FjallaOne",
                  ),
                ),
                Text(
                  "Tomorrowland Belguim 2023",
                  style: TextStyle(
                    fontSize: 12,
                    color: word,
                    fontFamily: "PathwayGothicOne",
                  ),
                ),
              ],
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavigationMenu()),
              );
            },
            icon: Icon(Icons.close),
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 390, // Adjust width as needed
                  height:
                      600, // Adjust height as needed to accommodate the image
                  decoration: BoxDecoration(
                    color: Color.fromARGB(
                        255, 240, 216, 197), // Light brown background color
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //ordersucess
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 14, right: 12, top: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Adjust the space between icon and text
                            Text(
                              "Order Sucess",
                              style: TextStyle(
                                fontFamily: "FjallaOne",
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //bee
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/bee.png',
                            width: 380,
                            height: 350,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //stars to the bee
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 14, right: 12, top: 25),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Stars to the Bee",
                                      style: TextStyle(
                                        fontFamily: "FjallaOne",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    10), // Add some space between text and rating bar
                            RatingBar.builder(
                              initialRating:
                                  0.0, // Set initial rating here (as a double)
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating:
                                  false, // Enable half-star ratings
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                // You can handle rating update here if needed
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //Order Details
                SizedBox(height: 20),
                SingleChildScrollView(
                  child: Container(
                    width: 390,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 240, 216, 197),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 14, right: 12, top: 8, bottom: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.wallet,
                                size: 24,
                                color: Colors.black,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "Order Details",
                                style: TextStyle(
                                  fontFamily: "FjallaOne",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 14,
                            right: 12,
                            top: 8,
                          ),
                          child: Consumer<ItemModel>(
                            builder: (context, value, child) {
                              return Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: value.cartItems.length,
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0, bottom: 0),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0, bottom: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: ListTile(
                                            leading: Image.asset(
                                              value.cartItems[index][2],
                                              height: 36,
                                            ),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  value.cartItems[index]
                                                      [0], // Item name
                                                  style: TextStyle(
                                                    fontFamily: "FjallaOne",
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  'RM' +
                                                      value.cartItems[index]
                                                          [1], // Price
                                                  style: TextStyle(
                                                    fontFamily: "FjallaOne",
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  Divider(
                                    thickness: 1,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 25, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Subtotal",
                                              style: TextStyle(
                                                fontFamily: "FjallaOne",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Consumer<ItemModel>(
                                              builder: (context, value, child) {
                                                return Text(
                                                  "RM" +
                                                      value.calculatorTotal(),
                                                  style: TextStyle(
                                                    fontFamily: "FjallaOne",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  //Service Tax
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 25, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Service Tax",
                                              style: TextStyle(
                                                fontFamily: "FjallaOne",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Consumer<ItemModel>(
                                              builder: (context, value, child) {
                                                return Text(
                                                  "RM" +
                                                      value
                                                          .calculateServiceTax(),
                                                  style: TextStyle(
                                                    fontFamily: "FjallaOne",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  //Goverment Tax
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 25, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Goverment Tax",
                                              style: TextStyle(
                                                fontFamily: "FjallaOne",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Consumer<ItemModel>(
                                              builder: (context, value, child) {
                                                return Text(
                                                  "RM" +
                                                      value
                                                          .calculateGovermentTax(),
                                                  style: TextStyle(
                                                    fontFamily: "FjallaOne",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  //Voucher
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 25,
                                        top: 10,
                                        bottom: 5),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.airplane_ticket,
                                                  size: 24,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Voucher",
                                                  style: TextStyle(
                                                    fontFamily: "FjallaOne",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Consumer<ItemModel>(
                                              builder: (context, value, child) {
                                                return Expanded(
                                                  child: Text(
                                                    "- RM" +
                                                        value
                                                            .calculateVoucher(),
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      fontFamily: "FjallaOne",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Divider(),

                                  //Total
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 25,
                                        top: 10,
                                        bottom: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total Price",
                                              style: TextStyle(
                                                fontFamily: "FjallaOne",
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Consumer<ItemModel>(
                                              builder: (context, value, child) {
                                                return Text(
                                                  "RM" +
                                                      value
                                                          .calculateTotalWithServiceTax(),
                                                  style: TextStyle(
                                                    fontFamily: "FjallaOne",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 141, // Set the desired height here
          child: BottomAppBar(
            color: lightbrown,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.0), // Adjust horizontal padding here
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width:
                        double.infinity, // Set width to occupy available space
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10), // Adjust vertical padding here
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigationMenu()),
                          );
                        },
                        child: Text(
                          "Back to Home",
                          style: TextStyle(
                            fontFamily: "FjallaOne",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: topbar,
                          padding: EdgeInsets.symmetric(
                              vertical: 15), // Adjust vertical padding here
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
