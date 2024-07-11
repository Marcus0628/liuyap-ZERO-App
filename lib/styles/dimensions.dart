import 'package:flutter/widgets.dart';

class Dimensions {
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  // FoodDetails Size
  static double foodDetailsSize(BuildContext context) => screenHeight(context) / 3;
}
