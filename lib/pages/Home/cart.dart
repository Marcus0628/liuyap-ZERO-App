// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zero/components/itemTile.dart';
import 'package:zero/model/itemmodel.dart';
import 'package:zero/navigation_menu.dart';

import 'package:zero/pages/Home/checkout.dart';
import 'package:zero/pages/Home/homepage.dart';
import 'package:zero/pages/Home/menu.dart';
import 'package:zero/pages/Settings/settings.dart';

import 'package:zero/styles/color.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
                  "Your Treasure Cart",
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
                onPressed: () {},
                icon: Icon(Icons.shopping_basket_rounded),
                color: word,
              ),
            ),
          ],
        ),
        
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Consumer<ItemModel>(
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.cartItems.length,
                        padding: EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
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
                                title: Text(
                                  value.cartItems[index][0],
                                  style: TextStyle(
                                    fontFamily: "FjallaOne",
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Text(
                                  'RM' + value.cartItems[index][1],
                                  style: TextStyle(
                                    fontFamily: "FjallaOne",
                                    fontSize: 13,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () => Provider.of<ItemModel>(
                                    context,
                                    listen: false
                                  )
                                  .removeItemToCart(index),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Divider(thickness: 1,),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add more Treasure Box",
                            style: TextStyle(
                              fontFamily: "FjallaOne",
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NavigationMenu()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),

              Divider(thickness: 4,),
              Transform.translate(
                offset: Offset(20, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hot Treasure Box",
                      style: TextStyle(
                        fontFamily: "FjallaOne",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Other customers also bought these",
                      style: TextStyle(
                        fontFamily: "FjallaOne",
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Consumer<ItemModel>(
                  builder: (context, value, child) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Transform.translate(
                          offset: Offset(0, 0),
                          child: Row(
                            children: [
                              for (int index = 0;index < value.shopItems.length;index++)
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                height: MediaQuery.of(context).size.height * 0.25,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: ItemTile(
                                  itemName: value.shopItems[index][0],
                                  itemPrice: value.shopItems[index][1],
                                  imagePath: value.shopItems[index][2],
                                  color: value.shopItems[index][3],
                                  onPressed: () {
                                    Provider.of<ItemModel>(
                                      context,
                                      listen: false
                                    )
                                    .addItemToCart(index);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Divider(thickness: 4,),

              //subtotal
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
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
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
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
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
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
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              "Use Voucher",
                              style: TextStyle(
                                fontFamily: "FjallaOne",
                                fontSize: 18,
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
                                "Select or enter Code",
                                style: TextStyle(
                                  fontFamily: "FjallaOne",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
            ],
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Checkout()),
                          );
                        },
                        child: Text(
                          "Review Payment",
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
