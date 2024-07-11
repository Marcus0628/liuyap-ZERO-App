// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero/styles/theme.dart';

class OnBoardingScreenWidgets extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;

  const OnBoardingScreenWidgets({this.image, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      child: Column(
        children: [
          SizedBox(height:120),
          Container(
            height: Get.height * 0.45,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: Get.height * 0.25,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title!,
                  style: semibold.copyWith(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Text(
                  subtitle!,
                  style: regular.copyWith(
                    fontSize: 12,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
