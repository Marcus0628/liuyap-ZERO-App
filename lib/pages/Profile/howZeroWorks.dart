import 'package:flutter/material.dart';
import 'package:zero/pages/Profile/FAQ.dart';
import 'package:zero/styles/color.dart';

class HowZeroWorks extends StatefulWidget {
  const HowZeroWorks({Key? key}) : super(key: key);

  @override
  State<HowZeroWorks> createState() => _HowZeroWorksState();
}

class _HowZeroWorksState extends State<HowZeroWorks> {
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
                    "How ZERO works",
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
                  "How does ZERO work",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "With ZERO you can save food from the restaurants, cafes and stores that are on the app. Instead of having to throw away food at the end of the day, these places offer what they have in Surprise Bags. The actual contents will be a surprise until you get there!Find a meal near you, purchase it through the app and turn up in the store within the given collection time. Show the staff your order to receive your Surprise Bag - and give them a high-five to celebrate that you just made a difference together.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Dietary requirements or allergies",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "The Surprise Bags you buy on ZERO are a surprise box, which means that we can't offer upfront information about allergens. If you have allergies, please ask the store when you collect your meal. Should the bag include food you are allergic to, please get in touch with us. If you have dietary requirements such as vegetarian, we suggest that you use the filter option in the browse tab to search for food that fits you.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Search stores at nearby area",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "We're working on it! We want to fight food waste everywhere so please check back at a later time. You're also very welcome to tell stores in your area about ZERO and encourage them to join us! Stay tuned and follow us on Instagram for updates on new store and city openings",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Should I pay with cash or card?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Cash payment is not acceptable at the store. All purchases need to be made through the app. You can make payment by saving your payment card while making a purchase in the app. The payment card can then be used for following purchases. This makes the process a lot easier and the collection quicker.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "How to delete my account?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "If you no longer wish to be a part of our fight against food waste, your account can be deleted in the privacy menu.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ));
}
