import 'package:flutter/material.dart';
import 'package:zero/pages/Organiser/orgDetails.dart';
import 'package:zero/pages/Organiser/organiserHomePage.dart';
import 'package:zero/styles/color.dart';

class OrganiserNavigationMenu extends StatefulWidget {
  const OrganiserNavigationMenu({Key? key}) : super(key: key);

  @override
  State<OrganiserNavigationMenu> createState() =>
      _OrganiserNavigationMenuState();
}

class _OrganiserNavigationMenuState extends State<OrganiserNavigationMenu> {
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
      resizeToAvoidBottomInset:
          true, // Enable resizing when the keyboard appears
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          OrganiserHomePage(),
          OrganiserDetails(),
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
                    icon: Icon(Icons.person),
                    label: "Profile",
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                    _pageController.animateToPage(index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                  });
                },
                currentIndex: _selectedIndex,
              ),
            )
          : null,
    );
  }

  // Function to determine whether to show the bottom navigation bar based on the current page index
  bool _shouldShowBottomNavBar(int index) {
    return index >= 0 && index <= 1;
  }
}
