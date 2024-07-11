// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:zero/controllers/wallet_controller.dart';
import 'package:zero/model/itemmodel.dart';

import 'package:zero/pages/Home/cart.dart';
import 'package:zero/pages/Home/orderSuccess.dart';
import 'package:zero/pages/Profile/pointSystem.dart';
import 'package:zero/navigation_menu.dart';
import 'package:zero/pages/Profile/wallet2.dart';
import 'package:zero/pages/Settings/settings.dart';
import 'package:zero/services/notification_service.dart';

import 'package:zero/styles/color.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  void placeOrder() {
    // Calculate total amount spent
    double totalAmountSpent = double.parse(Provider.of<ItemModel>(context, listen: false)
      .calculateTotalWithServiceTax());

    // Convert total amount spent to points (1 RM = 1 point)
    int pointsEarned = totalAmountSpent.toInt();

    // Update total points in PointSystem class
    Provider.of<PointSystem>(context, listen: false)
      .updateTotalPoints(pointsEarned);

    NotificationService()
      .showNotification(title: "ZERO", body: "Successfully Order!");

    // Proceed to order success page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderSucess()),
    );
  }

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
                  "Checkout",
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
                  height: 260, // Adjust height as needed to accommodate the image
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 240, 216, 197), // Light brown background color
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //location
                      Padding(
                        padding: const EdgeInsets.only(left: 14, right: 12, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 24,
                              color: Colors.black,
                            ),
                            SizedBox(width: 2), // Adjust the space between icon and text
                            Text(
                              "Location",
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
                        padding: const EdgeInsets.only(left: 12.0, right: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/map.png',
                            width: 380,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 14, right: 12, top: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Tomorrowland Belguim 2023",
                                      style: TextStyle(
                                        fontFamily: "FjallaOne",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Settings()),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Display on Map",
                                        style: TextStyle(
                                          fontFamily: "FjallaOne",
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.only(left: 14, right: 12, top: 5),
                        child: Text(
                          "De Schorre Boom, Belgium",
                          style: TextStyle(
                            fontFamily: "FjallaOne",
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Payment Methods
                SizedBox(height: 20),
                Container(
                  width: 390,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 240, 216, 197),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14, right: 12, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.wallet,
                              size: 24,
                              color: Colors.black,
                            ),
                            SizedBox(width: 2),
                            Text(
                              "Payment Methods",
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
                        padding: const EdgeInsets.only(left: 14, right: 12, top: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.credit_card,
                                      size: 24,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "Wallet",
                                      style: TextStyle(
                                        fontFamily: "FjallaOne",
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Settings()
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                          padding: const EdgeInsets.only(left: 14, right: 12, top: 8, bottom: 8),
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
                                    padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 0, right: 0, bottom: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: ListTile(
                                            leading: Image.asset(
                                              value.cartItems[index][2],
                                              height: 36,
                                            ),
                                            title: Row(
                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  value.cartItems[index][0], // Item name
                                                  style: TextStyle(
                                                    fontFamily: "FjallaOne",
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  'RM' + value.cartItems[index][1], // Price
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

                                  Divider(thickness: 1,),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 15, right: 25, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  "RM" + value.calculatorTotal(),
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
                                    padding: const EdgeInsets.only(left: 15, right: 25, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  "RM" + value.calculateServiceTax(),
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
                                    padding: const EdgeInsets.only(left: 15, right: 25, top: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  "RM" + value.calculateGovermentTax(),
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
                                    padding: const EdgeInsets.only(left: 15,right: 25,top: 10,bottom: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
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
                                                    "- RM" + value.calculateVoucher(),
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      fontFamily: "FjallaOne",
                                                      fontWeight: FontWeight.bold,
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
        
        bottomNavigationBar: 
        Container(
          height: 141, // Set the desired height here
          child: BottomAppBar(
            color: lightbrown,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust horizontal padding here
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            "RM" + value.calculateTotalWithServiceTax(),
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
                  // Adjusted vertical spacing here
                  SizedBox(
                    width: double.infinity, // Set width to occupy available space
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2), // Adjust vertical padding here
                      child: TextButton(
                        onPressed: () {
                          double totalPrice = double.parse(
                            Provider.of<ItemModel>(context, listen: false)
                              .calculateTotalWithServiceTax());
                          double balance = Get.find<WalletController>().balance;
                          if (balance >= totalPrice) {
                            // Sufficient balance, deduct payment
                            Get.find<WalletController>()
                              .deductPayment(totalPrice.toStringAsFixed(2));

                              placeOrder();
                              //   //Proceed to order success page
                              //   Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => OrderSucess()),
                              // );
                          } else {
                            // Display an alert or message indicating that the balance is insufficient
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Insufficient Balance'),
                                content: Text('Please top up your wallet to proceed.'),
                                actions: [
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Wallet2()),
                                          );
                                        },
                                        child: Text(
                                          'Check Balance',
                                          style:TextStyle(
                                            color: Colors.green
                                          )
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.red
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Place Order",
                          style: TextStyle(
                            fontFamily: "FjallaOne",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: topbar,
                          padding: EdgeInsets.symmetric(vertical: 5), // Adjust vertical padding here
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
