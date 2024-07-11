// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:provider/provider.dart'; // Import Provider if not imported
import 'package:zero/components/itemTile.dart';
import 'package:zero/model/favourite_list_models.dart';
import 'package:zero/model/favourite_page_model.dart';
import 'package:zero/model/itemmodel.dart';
import 'package:zero/navigation_menu.dart';

import 'package:zero/pages/Home/cart.dart';
import 'package:zero/pages/Home/homepage.dart';
import 'package:zero/pages/Settings/settings.dart';

import 'package:zero/styles/color.dart';
import 'package:zero/styles/dimensions.dart';
import 'package:zero/styles/iconText.dart';
import 'package:zero/styles/textType.dart';

class EDC extends StatefulWidget {
  const EDC({Key? key}) : super(key: key);

  @override
  State<EDC> createState() => _EDCState();
}

class _EDCState extends State<EDC> {
  final int index = 1;
  @override
  Widget build(BuildContext context) {
    var item = context.select<FavoriteListModel, Item>(
        (favoritelist) => favoritelist.getByPosition(index));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                width: double.maxFinite,
                height: Dimensions.foodDetailsSize(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/edc.png'),
                  ),
                ),
              ),

              // Icons
              Transform.translate(
                offset: Offset(0, -250),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //back icon
                    Transform.translate(
                      offset: Offset(0, 0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: cancel,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavigationMenu()
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_back_ios_new_outlined),
                          color: word,
                        ),
                      ),
                    ),

                    //love icon
                    Transform.translate(
                      offset: Offset(160, 0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: cancel,
                        ),
                        child: _AddButton(item: item)
                      ),
                    ),

                    //phone icon
                    Transform.translate(
                      offset: Offset(80, 0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: cancel,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.phone_rounded),
                          color: word,
                        ),
                      ),
                    ),

                    //share icon
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: cancel,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.share_rounded),
                        color: word,
                      ),
                    ),
                  ],
                ),
              ),

              // Description
              Transform.translate(
                offset: Offset(0, -20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "EDC 2023",
                        textType: TextType.big,
                      ),
                      SizedBox(height: 3),
                      TextWidget(
                        text: "Company Name: We Are One World",
                        textType: TextType.small,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                              3,
                              (index) => Icon(
                                Icons.star_rounded,
                                color: Colors.red,
                                size: 15,
                              ),
                            ),
                          ),
                          Wrap(
                            children: List.generate(
                              2,
                              (index) => Icon(
                                Icons.star_rounded,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          TextWidget(
                            text: "3.5",
                            textType: TextType.small,
                          ),
                          SizedBox(width: 10),
                          TextWidget(
                            text: "100+ ratings",
                            textType: TextType.small,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      IconText(
                        icon: Icons.location_pin,
                        mainText: "Yang Cheng Lake, Suzhou",
                        subText: "3km away",
                        iconColor: word,
                        mainTextType: TextType.medium,
                        subTextType: TextType.small,
                      ),
                      SizedBox(height: 10),
                      IconText(
                        icon: Icons.access_time,
                        mainText: "Collect time",
                        subText: "8pm - 10pm",
                        iconColor: word,
                        mainTextType: TextType.medium,
                        subTextType: TextType.small,
                      ),
                      SizedBox(height: 15),
                      Divider(color: Colors.grey),
                      TextWidget(
                        text: "What you could get",
                        textType: TextType.medium,
                      ),
                      SizedBox(height: 5),
                      TextWidget(
                        text:"Received a Treasure Box containing a variety of food\nCan grab as much food as you wish, as long as the Treasure Box can be capped.",
                        textType: TextType.small,
                      ),
                      SizedBox(height: 15),
                      Divider(color: Colors.grey),
                      TextWidget(
                        text: "Description : Asian, Bread, Pudding, Crossiant",
                        textType: TextType.medium,
                      ),
                      SizedBox(height: 5),
                      TextWidget(
                        text: "Ingredients & Allergens",
                        textType: TextType.small,
                      ),
                      SizedBox(height: 15),
                      Divider(color: Colors.grey),
                      Center(
                        child: TextWidget(
                          text: "Select Your Treasure Box",
                          textType: TextType.big,
                        ),
                      ),
                      Consumer<ItemModel>(
                        builder: (context, value, child) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: value.shopItems.length,
                            padding: EdgeInsets.all(12),
                            gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.2,
                              ),
                            itemBuilder: (context, index) {
                              return ItemTile(
                                itemName: value.shopItems[index][0],
                                itemPrice: value.shopItems[index][1],
                                imagePath: value.shopItems[index][2],
                                color: value.shopItems[index][3],
                                onPressed: () {
                                  Provider.of<ItemModel>(context, listen: false)
                                    .addItemToCart(index);
                                },
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: double.infinity, // Set width to occupy available space
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 2), // Adjust vertical padding here
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Cart()),
                              );
                            },
                            child: Text(
                              "Add To Cart",
                              style: TextStyle(
                                fontFamily: "FjallaOne",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: topbar,
                              padding: EdgeInsets.symmetric(vertical: 5), // Adjust vertical padding here
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInFavoritePage = context.select<FavoritePageModel, bool>(
      (Favourite) => Favourite.items.contains(item),
    );

    return IconButton(
      icon: isInFavoritePage
        ? Icon(Icons.favorite, color: Colors.red)
        : Icon(Icons.favorite_border),
      onPressed: isInFavoritePage? () {
        var Favorite = context.read<FavoritePageModel>();
        Favorite.remove(item);
      }: () {
        var Favorite = context.read<FavoritePageModel>();
        Favorite.add(item);
      }
    );
  }
}
