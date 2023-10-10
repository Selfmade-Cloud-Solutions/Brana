import 'dart:async';
import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: branaDark,
      appBar: AppBar(
      backgroundColor: branaDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: branaWhite,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        )),
      ),
      body: LatestTop(),
    );
  }
}

class LatestTop extends StatefulWidget {
  const LatestTop({Key? key}) : super(key: key);

  @override
  _LatestTopState createState() => _LatestTopState();
}

class _LatestTopState extends State<LatestTop> {
  final upcomings = [
    'assets/books/upcoming1.jpg',
    'assets/books/upcoming2.png',
    'assets/books/upcoming3.jpg',
  ];

  final _pageController = PageController();
  int _currentPage = 0;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < upcomings.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const ScrollPhysics(),
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: upcomings
                .map((e) => Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              e,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.black,
                                    Colors.black45,
                                    Colors.black12,
                                    Colors.black.withOpacity(0)
                                  ])),
                        ),
                        const Positioned(
                            left: 30,
                            top: 20,
                            child: Text(
                              'Upcoming Book',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            )),
                        const Positioned(
                            left: 30,
                            top: 55,
                            child: Text(
                              '30+ new book coming with various \nStories are waiting for you',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ))
                      ],
                    ))
                .toList(),
          ),
          Positioned(
              left: 30,
              bottom: 10,
              child: SmoothPageIndicator(
                controller: _pageController,
                count: upcomings.length,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 4,
                  dotWidth: 8,
                  dotHeight: 4,
                  activeDotColor: Colors.white,
                ),
                onDotClicked: (index) {
                  _pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 3),
                      curve: Curves.easeOut);
                },
              ))
        ],
      ),
    );
  }
}
