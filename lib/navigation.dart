import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:brana_mobile/navigation_pages/home_page.dart';
// import 'package:brana_mobile/navigation_pages/library.dart';
import 'package:brana_mobile/navigation_pages/explore.dart';
import 'package:brana_mobile/navigation_pages/profile.dart';
import 'package:brana_mobile/constants.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Navigation> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomePage(),
          ExplorePage(),
          // LibraryPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 0,
              color:
                  branaDark, // Adjust the opacity (alpha value) and color as needed
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            gap: 8,
            color: branaBlue,
            activeColor: Colors.white,
            tabBackgroundColor: branaPrimaryColor,
            padding: const EdgeInsets.all(10),
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
              _pageController.jumpToPage(index);
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.explore_outlined,
                text: 'Explore',
              ),
              GButton(icon: Icons.person, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
