// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zero/controllers/wallet_controller.dart';
import 'package:zero/model/Transaction.dart';
import 'package:zero/pages/Profile/userProfile.dart';
import 'package:zero/styles/color.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  List<Transaction> transactionHistory = [];

  @override
  void initState() {
    super.initState();
    // Fetch top-up and payment history
    transactionHistory = Get.find<WalletController>().transactionHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: topbar,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: word,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(25),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                "My Orders",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: word,
                  fontFamily: "FjallaOne",
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "History",
                style: TextStyle(
                  color: Color(0xff414141),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PathwayGothicOne",
                ),
              ),
            ),

            SizedBox(height: 15),
            Container(
              height: 720,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(40.0), // Adjust the radius as needed
                color: Color(0xffFFFFFF).withOpacity(0.7),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 13.0, top: 10),
                child: Column(
                  children: [
                    // Payment transactions
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: transactionHistory.length,
                      itemBuilder: (context, index) {
                        final transaction = transactionHistory[index];
                        // Check if the transaction is a payment transaction
                        if (transaction.type == TransactionType.Payment) {
                          return ListTile(
                            title: Text(
                              '${transaction.description}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontFamily: 'FjallaOne',
                                color: Color(0xff414141),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount: RM ${transaction.amount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'FjallaOne',
                                    color: Color(0xff414141),
                                  ),
                                ),
                                Text(
                                  'Date & Time: ${transaction.date}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'FjallaOne',
                                    color: Color(0xff414141),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Divider(),
                              ],
                            ),
                          );
                        } else {
                          // Return an empty container for non-payment transactions
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            )

            // OrderItem(
            //   title: "STARBUCKS-SS15",
            //   price: "RM5.99",
            //   date: "5 Oct 2023, 02:15",
            //   points: "+ 6 points",
            // ),
            // OrderItem(
            //   title: "EDC 2023",
            //   price: "RM5.99",
            //   date: "1 Oct 2023, 10:22",
            //   points: "",
            // ),
            // OrderItem(
            //   title: "ROLLING LOAD 2023",
            //   price: "RM9.99",
            //   date: "17 Sep 2023, 08:21",
            //   points: "",
            // ),
            // OrderItem(
            //   title: "TOMORROWLAND 2023",
            //   price: "RM9.99",
            //   date: "2 Sep 2023, 13:55",
            //   points: "",
            // ),
            // OrderItem(
            //   title: "TOMORROWLAND 2023",
            //   price: "RM9.99",
            //   date: "23 Sep 2023, 16:34 PM",
            //   points: "",
            // ),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String title;
  final String price;
  final String date;
  final String points;

  const OrderItem({
    Key? key,
    required this.title,
    required this.price,
    required this.date,
    required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'FjallaOne',
                  color: Color(0xff414141),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'FjallaOne',
                  color: Color(0xff414141),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        //date&time
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            date,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'FjallaOne',
              color: Colors.grey,
            ),
          ),
        ),
        //points
        if (points.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              points,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'FjallaOne',
                color: Colors.grey,
              ),
            ),
          ),
        SizedBox(height: 20),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyOrder(),
  ));
}
