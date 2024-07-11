// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:zero/pages/Home/homepage.dart';
import 'package:zero/pages/Discover/discover.dart';
import 'package:zero/pages/Favourite/favourite.dart';
import 'package:zero/pages/Profile/userProfile.dart';
import 'package:zero/styles/color.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      resizeToAvoidBottomInset: true, // Enable resizing when the keyboard appears
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          Homepage(),
          Discover(),
          Favourite(),
          UserProfile(),
        ],
      ),
      
      bottomNavigationBar: _shouldShowBottomNavBar(_selectedIndex)
      ? DefaultTextStyle(
        style: TextStyle(),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: topbar,
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Discover",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favourite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
            });
          },
          currentIndex: _selectedIndex,
        ),
      ): null,
    );
  }

  // Function to determine whether to show the bottom navigation bar based on the current page index
  bool _shouldShowBottomNavBar(int index) {
    return index == 0 || index == 1 || index == 2 || index == 3;
  }
}
