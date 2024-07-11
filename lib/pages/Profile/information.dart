import 'package:flutter/material.dart';
import 'package:zero/styles/color.dart';
import 'package:zero/pages/Profile/wastageAnalytics.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
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
          //       MaterialPageRoute(builder: (context) => WastageAnalytics()),
          //     );
          //   },
          //   icon: Icon(Icons.arrow_back_ios),
          //   color: word,
          // ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(25),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 8.0),
                  Text(
                    "CO2e Avoided",
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
                  "What is CO2e?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "CO2e stands for -carbon dioxide equivalent-. While CO2 only accounts for carbon dioxide, CO2e accounts for carbon dioxide as well as all other greenhouse gases.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ));
}
