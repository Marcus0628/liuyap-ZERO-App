// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zero/pages/Profile/FAQ.dart';

import 'package:zero/styles/color.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Notifications()),
                    // );
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
                      "Terms & Conditions",
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
                    "1. Introduction",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome to ZERO. By using our app, you agree to comply with and be bound by the following terms and conditions of use. Please review these terms carefully. If you do not agree to these terms, you should not use this app.",
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 20),
                  Text(
                    "2. Usage Terms",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "You agree that you will use this app in accordance with all applicable laws, rules, and regulations, and that you will not use the app for any unlawful purpose or in a manner inconsistent with these terms and conditions.",
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 20),
                  Text(
                    "3. Acceptance",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "By using the ZERO, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions of Use. If you do not agree with any of these terms, please do not use the App. Your continued use of the App following the posting of any changes to these terms will signify your acceptance of those changes.",
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 20),
                  Text(
                    "4. Termination",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "We may terminate or suspend your access to the App immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach these Terms.",
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 20),
                  Text(
                    "5. Limitation of Liability",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "To the fullest extent permitted by applicable law, in no event shall we be liable to you or any third party for any indirect, consequential, incidental, special, or punitive damages, including without limitation damages for lost profits, loss of data, or loss of goodwill.",
                    style: TextStyle(fontSize: 16),
                  ),

                  // Add more terms here if needed
                ],
              ),
            ),
          ),
        ),
      );
}
