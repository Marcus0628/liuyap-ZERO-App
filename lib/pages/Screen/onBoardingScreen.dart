// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zero/controllers/onBoardingScreen_controller.dart';
import 'package:zero/styles/color.dart';
import 'package:zero/styles/onBoardingScreenWidget.dart';
import 'package:zero/pages/Welcome/signinpage.dart';
import 'package:zero/styles/theme.dart' as Theme;

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final OnBoardingScreenController controller = Get.put(OnBoardingScreenController());


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Theme.background,
        child: Stack(
          children: [
            PageView(
              controller: controller.indicator,
              onPageChanged: (value) {
                controller.page.value = value;
                print(controller.page.value);
              },
              children: [
                // Onboarding screen 1
                OnBoardingScreenWidgets(
                  image: 'assets/ob1.jpeg',
                  title: 'Order Anytime, Anywhere',
                  subtitle:
                      'Order surplus food containers from your phone.\nMake an impact now!',
                ),
                // Onboarding screen 2
                OnBoardingScreenWidgets(
                  image: 'assets/ob2.png',
                  title: 'Choose, Fill, Conserve',
                  subtitle:
                      'Select and fill your container with surplus foods.\nReduce waste.',
                ),
                // Onboarding screen 3
                OnBoardingScreenWidgets(
                  image: 'assets/ob3.jpeg',
                  title: 'Saving Earth with One Container',
                  subtitle: 'Choose surplus food containers to save the planet.',
                ),
              ],
            ),
            Positioned(
              top: 50.0,
              right: 20.0,
              child: GestureDetector(
                onTap: () {
                  controller.indicator.jumpToPage(2);
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Obx(() => Container(
              alignment: Alignment(0, 0.85),
              child: controller.page.value != 2 ? SmoothPageIndicator(
                controller: controller.indicator,
                count: 3,
                effect: SlideEffect(
                  activeDotColor: Color(0xffFFECD0),
                  spacing: 8.0,
                  radius: 4.0,
                  dotWidth: 8,
                  dotHeight: 8,
                  dotColor: Theme.darkGrey,
                ),
              ) : GestureDetector(
                onTap: () {
                  Get.to(() => SignInPage()); // Navigate to SignInPage
                },
                
                child: Container(
                  height: 55,
                  width: Get.width * 0.8,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Color(0xffFFECD0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Getting Started',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff414141),
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
