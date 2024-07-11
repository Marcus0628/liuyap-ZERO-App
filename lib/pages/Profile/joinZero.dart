import 'package:flutter/material.dart';
import 'package:zero/pages/Profile/FAQ.dart';
import 'package:zero/styles/color.dart';

class JoinZero extends StatefulWidget {
  const JoinZero({Key? key}) : super(key: key);

  @override
  State<JoinZero> createState() => _JoinZeroState();
}

class _JoinZeroState extends State<JoinZero> {
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
          //       MaterialPageRoute(builder: (context) => FAQ()),
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
                  // Navigate to Notifications screen
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
                    "Join ZERO",
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recommend a store that should join ZERO",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "We love hearing about stores that want to join the fight against food waste! Feel free to tell the store about ZERO and send us a tip with information about the store.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "I would like to join ZERO",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Thank you! We'd love you to join us in the fight against food waste. Please contact us here and we will help you sign up.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "I would like to work for ZERO",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Awesome! You can see our open positions and submit an application on our official website.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "How can I help spread the word about ZERO",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "We'd love you to help us spread the word about ZERO and get even more people involved in the fight against food waste. Please follow us on Facebook and Instagram, and tell your friends about the app!",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ));
}
