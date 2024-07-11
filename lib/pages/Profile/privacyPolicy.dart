import 'package:flutter/material.dart';
import 'package:zero/pages/Profile/FAQ.dart';
import 'package:zero/styles/color.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
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
                    "Privacy Policy",
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
                  "1. Information Collection and Use",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "We collect information from you when you register on our site, place an order, subscribe to our newsletter, respond to a survey or fill out a form.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "2. Log Data",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "We may also collect information that your browser sends whenever you visit our Service (\"Log Data\").",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "3. Cookies",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Cookies are files with a small amount of data, which may include an anonymous unique identifier.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "4. Security",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "We take reasonable measures to protect the security of your information. However, no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "5. Changes to This Privacy Policy",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "We reserve the right to update or change our Privacy Policy at any time. Any changes will be effective immediately upon posting the revised Privacy Policy on this page.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "6. Contact Us",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "If you have any questions about this Privacy Policy, please contact us at zero@gmail.com.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ));
}
