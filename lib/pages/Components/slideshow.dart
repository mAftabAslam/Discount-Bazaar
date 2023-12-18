import 'package:flutter/material.dart';
import 'dart:async';

class BannerSlider extends StatefulWidget {
  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final List<String> bannerImages = [
    'lib/assets/banner.png',
    'lib/assets/banner2.png',
    'lib/assets/banner3.png',
    'lib/assets/banner.png',

    // Add more image paths as needed
  ];

  int _currentPage = 0;
  late PageController _pageController;
  final _duration = Duration(seconds: 3); // Adjust duration as needed
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(_duration, (_) {
      if (_currentPage < bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
        _pageController.jumpToPage(0); // Jump back to the first page instantly
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      width: double.infinity,
      height: 160, // Adjust the height as needed
      decoration: BoxDecoration(
        color: const Color(0xff333333),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0f101828),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Color(0x19101828),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: PageView.builder(
        controller: _pageController,
        itemCount: bannerImages.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              bannerImages[index],
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
