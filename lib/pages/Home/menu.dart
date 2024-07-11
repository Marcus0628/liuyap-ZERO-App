// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zero/components/itemTile.dart';
import 'package:zero/model/itemModel.dart';

import 'package:zero/pages/Home/cart.dart';


class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return Cart();
            }
          )
        ),
        backgroundColor: Colors.black,
        child: Icon(
          Icons.shopping_bag,
          color: Colors.white,
        ),  
      ),
      
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 48),

            //gm
            Padding(
              padding:   EdgeInsets.symmetric(horizontal:24),
              child: Text(
                "Good Morning,",
                style: TextStyle(
                  fontFamily: "FjallaOne",
                  fontSize: 36,
                ),
              ),
            ),

            SizedBox(height: 4),

            //let's
            Padding(
              padding: EdgeInsets.symmetric(horizontal:24),
              child: Text(
                "Let's order fresh item for you",
                style: TextStyle(
                  fontFamily: "FjallaOne",
                  fontSize: 30,
                ),
              ),
            ),

            SizedBox(height: 24),

            Padding(
              padding: EdgeInsets.symmetric(horizontal:8.0),
              child: Divider(
                thickness: 4,
              ),
            ),

            SizedBox(height: 24),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Fresh Items",
                style: TextStyle(
                  fontFamily: "FjallaOne",
                  fontSize: 30,
                ),
              ),
            ),

            Expanded(
              child: Consumer<ItemModel>(
                builder:(context, value, child){
                  return GridView.builder(
                    itemCount: value.shopItems.length,
                    padding: EdgeInsets.all(12),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1/1.2,
                    ),
      
                    itemBuilder:(context, index) {
                      return ItemTile(
                        itemName:  value.shopItems[index][0],
                        itemPrice: value.shopItems[index][1],
                        imagePath: value.shopItems[index][2],
                        color: value.shopItems[index][3],
                        onPressed: () {
                          Provider.of<ItemModel>(context,listen: false)
                          .addItemToCart(index);
                        },
                      );
                    },
                  );
                }
              )
            )
          ],
        ),
      ),
    );
  }
}