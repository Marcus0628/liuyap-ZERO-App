// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zero/pages/Profile/wallet.dart';
import 'package:zero/styles/button.dart';
import 'package:zero/styles/color.dart';
import '/controllers/wallet_controller.dart';
import 'package:get/get.dart';


class TopUp extends GetView<WalletController> {
  const TopUp({Key? key}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    double selectedAmount = 0.0;
    TextEditingController customAmountController = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: topbar,
          title: null,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Wallet()),
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
                  SizedBox(width: 8.0),
                  Text(
                    "Top Up",
                    style: TextStyle(
                      fontSize: 28,
                      color: word,
                      fontFamily: "FjallaOne",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
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
                        borderRadius: BorderRadius.circular(4),
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
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 20.0),
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
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                  style: topUpButton,
                                  child: const Text('Top Up',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff414141),
                                      )),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor: background,
                                        context: context,
                                        builder: (BuildContext bc) {
                                          return Container(
                                            height: 400,
                                            width: 500,
                                            child: ListView(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30),
                                                children: [
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    "Review Top-Up",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  SizedBox(height: 5),
                                                  TextField(
                                                    controller: customAmountController,
                                                    autocorrect: false,
                                                    decoration: InputDecoration(
                                                      prefixIcon: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SizedBox(width: 125),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: const Text(
                                                              "RM",
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          SizedBox(width: 5)
                                                        ],
                                                      ),
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                      hintText: selectedAmount.toStringAsFixed(2),
                                                      hintStyle:
                                                          TextStyle(fontSize: 30),
                                                    ),
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                    keyboardType:
                                                        TextInputType.numberWithOptions(decimal: true),
                                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                                                    //
                                                    onChanged: (value) {
                                                      // Handle changes in the text field
                                                      if (value.isNotEmpty) {
                                                        // Update the selected amount when the user enters a value
                                                        selectedAmount = double.parse(value);
                                                      } else {
                                                        // If the input is empty, reset the selected amount
                                                        selectedAmount = 0.0;
                                                      }
                                                    },
                                                    //
                                                  ),
                                                  Text(
                                                    "Available Balance: RM" + Get.find<WalletController>().balance.toStringAsFixed(2),
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 20),
                                                  Text(
                                                    "Amount",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(height: 20),
                                                  Obx(
                                                    () => Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                          onTap: () => controller.setAmount(20), // Change the index to the amount
                                                          child: Container(
                                                            padding: EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                              color: controller.setAmountIndex.value == 20
                                                                  ? Colors.brown
                                                                  : Colors.transparent,
                                                              border: Border.all(
                                                                color: controller.setAmountIndex.value == 20
                                                                    ? Colors.brown
                                                                    : Colors.grey,
                                                              ),
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Text(
                                                              "20.00",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: controller.setAmountIndex.value == 20
                                                                    ? Colors.white
                                                                    : Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                          GestureDetector(
                                                          onTap: () => controller.setAmount(50), // Change the index to the amount
                                                          child: Container(
                                                            padding: EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                              color: controller.setAmountIndex.value == 50
                                                                  ? Colors.brown
                                                                  : Colors.transparent,
                                                              border: Border.all(
                                                                color: controller.setAmountIndex.value == 50
                                                                    ? Colors.brown
                                                                    : Colors.grey,
                                                              ),
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Text(
                                                              "50.00",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: controller.setAmountIndex.value == 50
                                                                    ? Colors.white
                                                                    : Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                          GestureDetector(
                                                          onTap: () => controller.setAmount(100), // Change the index to the amount
                                                          child: Container(
                                                            padding: EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                              color: controller.setAmountIndex.value == 100
                                                                  ? Colors.brown
                                                                  : Colors.transparent,
                                                              border: Border.all(
                                                                color: controller.setAmountIndex.value == 100
                                                                    ? Colors.brown
                                                                    : Colors.grey,
                                                              ),
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Text(
                                                              "100.00",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: controller.setAmountIndex.value == 100
                                                                    ? Colors.white
                                                                    : Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                          GestureDetector(
                                                          onTap: () => controller.setAmount(200), // Change the index to the amount
                                                          child: Container(
                                                            padding: EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                              color: controller.setAmountIndex.value == 200
                                                                  ? Colors.brown
                                                                  : Colors.transparent,
                                                              border: Border.all(
                                                                color: controller.setAmountIndex.value == 200
                                                                    ? Colors.brown
                                                                    : Colors.grey,
                                                              ),
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Text(
                                                              "200.00",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: controller.setAmountIndex.value == 20
                                                                    ? Colors.white
                                                                    : Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        ]),
                                                  ),
                                                  SizedBox(height: 50),
                                                 ElevatedButton(
                                                  style: topUpConfirmButton,
                                                  child: Text(
                                                    "Top Up Now",
                                                    style: TextStyle(fontSize: 16, color: word),
                                                  ),
                                                  onPressed: () {
                                                    print("Button pressed");
                                                    double selectedAmount = 0.0; // Initialize selectedAmount to zero

                                                    // Check if the user entered a custom amount
                                                    if (customAmountController.text.isNotEmpty) {
                                                      double parsedAmount = double.tryParse(customAmountController.text) ?? 0.0;
                                                      print("Parsed amount: $parsedAmount");
                                                      if (parsedAmount > 0) {
                                                        selectedAmount = parsedAmount;
                                                      } else {
                                                        print("Invalid amount entered");
                                                        // Display an error message if the entered amount is not valid
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                            title: Text('Invalid Amount'),
                                                            content: Text('Please enter a valid top-up amount.'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context); // Close the dialog
                                                                },
                                                                child: Text('OK'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                        return; // Exit onPressed function if the amount is invalid
                                                      }
                                                    } else {
                                                      // If the user did not enter a custom amount, use the selected predefined amount
                                                      selectedAmount = controller.setAmountIndex.value.toDouble();
                                                    }

                                                    // Perform top-up only if a valid amount is entered
                                                    if (selectedAmount > 0) {
                                                      controller.topUpAmount(selectedAmount); // Update balance in WalletController

                                                      //controller.addTopUpTransaction(selectedAmount);

                                                      

                                                      showDialog(
                                                        context: context,
                                                        builder: (context) => AlertDialog(
                                                          title: Text('Top-Up Success'),
                                                          content: Text('Your wallet has been successfully topped up with RM${selectedAmount.toStringAsFixed(2)}.\n\nAvailable Balance: RM${Get.find<WalletController>().balance.toStringAsFixed(2)}.'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(context); // Close the dialog
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => Wallet()),
                                                                ); // Navigate back to the Wallet page
                                                              },
                                                              child: Text('OK'),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),



                                                ]),
                                          );
                                        });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 672,
                      width: 500,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(50)),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 200, top: 20),
                          child: Text(
                            "Other top-up methods",
                            style: TextStyle(
                              fontSize: 21,
                              color: word,
                              fontFamily: "FjallaOne",
                            ),
                          ),
                        ),
                        //Mastercard 2
                        SizedBox(height: 14),
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
                                      onPressed: () {},
                                      icon: Icon(
                                          Icons.keyboard_arrow_right_rounded),
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
                                      onPressed: () {},
                                      icon: Icon(
                                          Icons.keyboard_arrow_right_rounded),
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
                                      onPressed: () {},
                                      icon: Icon(
                                          Icons.keyboard_arrow_right_rounded),
                                      color: word,
                                      iconSize: 35.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    )
                    //finish
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
