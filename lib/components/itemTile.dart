// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {

  final String itemName;
  final String itemPrice;
  final String imagePath;
  final color;
  void Function()? onPressed;

  ItemTile({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color[100],
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            //image
            Image.asset(
              imagePath,
              height: 110,
              width: 120,
            ),

            //item name
            Text(
              itemName,
              style: TextStyle(
                fontFamily: "FjallaOne",
                fontSize: 17,
              ),
            ),

            // price + button
            MaterialButton(
              onPressed: onPressed,
              color: color[800],
              child: Text(
                'RM'+itemPrice,
                style: TextStyle(
                  fontFamily: "FjallaOne",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}