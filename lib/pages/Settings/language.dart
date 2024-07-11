// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:zero/styles/color.dart';
import 'package:zero/styles/button.dart';

import 'package:zero/pages/Settings/settings.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  bool englishSelected = true;
  bool chineseSelected = false;
  bool malaySelected = false;
  bool japaneseSelected = false;
  bool koreanSelected = false;

  void _selectLanguage(String language) {
    setState(() {
      englishSelected = false;
      chineseSelected = false;
      malaySelected = false;
      japaneseSelected = false;
      koreanSelected = false;

      if (language == 'English') {
        englishSelected = true;
      } else if (language == 'Chinese') {
        chineseSelected = true;
      } else if (language == 'Malay') {
        malaySelected = true;
      } else if (language == 'Japanese') {
        japaneseSelected = true;
      } else if (language == 'Korean') {
        koreanSelected = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
          //       MaterialPageRoute(builder: (context) => Settings()),
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
                  Icon(
                    Icons.language_rounded,
                    size: 40,
                    color: word,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "Language",
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
        body: ListView(
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  // English
                  SizedBox(height: 16),
                  languageContainer(
                      'English', 'assets/english.jpg', englishSelected),

                  // Chinese
                  SizedBox(height: 16),
                  languageContainer(
                      'Chinese', 'assets/chinese.jpg', chineseSelected),

                  // Malay
                  SizedBox(height: 16),
                  languageContainer('Malay', 'assets/malay.jpg', malaySelected),

                  // Japanese
                  SizedBox(height: 16),
                  languageContainer(
                      'Japanese', 'assets/japan.jpg', japaneseSelected),

                  // Korean
                  SizedBox(height: 16),
                  languageContainer(
                      'Korean', 'assets/korea.jpg', koreanSelected),

                  // Save
                  SizedBox(height: 80.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: proceedButton,
                    child: Text(
                      "Save Changes",
                      style: TextStyle(
                        color: word,
                        fontSize: 28,
                        fontFamily: "FjallaOne",
                      ),
                    ),
                  ),

                  // Cancel
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Settings()),
                      );
                    },
                    style: cancelButton,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color.fromARGB(255, 28, 11, 11),
                        fontSize: 28,
                        fontFamily: "FjallaOne",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget languageContainer(String language, String imagePath, bool isSelected) {
    return Container(
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
                  imagePath,
                  width: 80,
                  height: 55,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 30.0),
                child: Text(
                  language,
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
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Transform.translate(
                offset: Offset(0, -30),
                child: GestureDetector(
                  onTap: () {
                    _selectLanguage(language);
                  },
                  child: Icon(
                    isSelected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_off_rounded,
                    size: 26.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
