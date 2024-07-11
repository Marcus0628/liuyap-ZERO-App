import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero/controllers/wallet_controller.dart';
import 'package:zero/model/Transaction.dart';
import 'package:zero/navigation_menu.dart';
import 'package:zero/pages/Profile/userProfile.dart';
import 'package:zero/pages/Profile/topUp.dart';

import 'package:zero/styles/color.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});
  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  List<Transaction> transactionHistory = [];

  @override
  void initState() {
    super.initState();
    // Fetch top-up and payment history
    transactionHistory = Get.find<WalletController>().transactionHistory;
  }

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
            //     Navigator.pop(context);
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
                    SizedBox(width: 10.0),
                    Text(
                      "Wallet",
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
          body: ListView(
            children: [
              const SizedBox(height: 15),
              Container(
                child: Column(
                  children: [
                    Text(
                      "Available Balance",
                      style: TextStyle(
                        fontSize: 14,
                        color: word,
                        fontFamily: "FjallaOne",
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "RM" +
                          Get.find<WalletController>()
                              .balance
                              .toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 36,
                        color: word,
                        fontFamily: "FjallaOne",
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Container(
                height: 675,
                width: 394,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xffFFFFFF).withOpacity(0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(130, 59),
                              backgroundColor: lightbrown,
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => TopUp(),
                                ),
                              );
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    height: 33,
                                    width: 33,
                                    child: Image.asset(
                                      'assets/cash.png',
                                      height: 22,
                                      width: 19,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'Top Up',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'FjallaOne',
                                      color: Color(0xff414141),
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(130, 59),
                              backgroundColor: lightbrown,
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                            onPressed: () {
                              // Handle viewing payment history here
                              // For now, let's leave it empty as per your code
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    height: 33,
                                    width: 33,
                                    child: Image.asset(
                                      'assets/history.png',
                                      height: 22,
                                      width: 19,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    'History',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'FjallaOne',
                                      color: Color(0xff414141),
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: const Row(
                        children: [
                          Text(
                            "Wallet Transactions",
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'FjallaOne',
                              color: Color(0xff414141),
                            ),
                          ),
                          SizedBox(width: 134),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                // Combined transactions
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: transactionHistory.length,
                                  separatorBuilder: (context, index) =>
                                      Divider(),
                                  itemBuilder: (context, index) {
                                    List<Transaction> allTransactions = [
                                      // ...transactionHistory.map((transaction) => Transaction(
                                      //     description: transaction.description,
                                      //     amount: transaction.amount,
                                      //     date: transaction.date,
                                      //     type: TransactionType.Payment)),
                                      ...transactionHistory.map((transaction) =>
                                          Transaction(
                                              description:
                                                  transaction.description,
                                              amount: transaction.amount,
                                              date: transaction.date,
                                              type: TransactionType.TopUp))
                                    ];
                                    allTransactions.sort((a, b) => b.date
                                        .compareTo(a
                                            .date)); // Sort all transactions by date
                                    final transaction = allTransactions[index];
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
