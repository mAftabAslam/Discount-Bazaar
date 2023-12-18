import 'package:flutter/material.dart';
import 'package:se_project/pages/MainPages/account.dart';
import 'package:se_project/pages/MainPages/chats.dart';
import 'package:se_project/pages/MainPages/home.dart';
import 'package:se_project/pages/MainPages/myAds.dart';
import 'package:se_project/pages/MainPages/sell.dart';

class Home2 extends StatefulWidget {
  final String userId;

  const Home2({Key? key, required this.userId}) : super(key: key);

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  int currentTab = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(userId: widget.userId),
      Chats(),
      MyAds(userId: widget.userId),
      ProfilePage(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentTab = index;
          });
        },
        children: screens,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: Color(0xff1E1E1E),
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home_filled),
              color: currentTab == 0 ? Color(0xffffffff) : Colors.grey,
              onPressed: () {
                setState(() {
                  currentTab = 0;
                  _pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.chat_rounded),
              color: currentTab == 1 ? Color(0xffffffff) : Colors.grey,
              onPressed: () {
                setState(() {
                  currentTab = 1;
                  _pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
            SizedBox(width: 48), // Extra space to align the add button
            IconButton(
              icon: Icon(Icons.bookmark),
              color: currentTab == 2 ? Color(0xffffffff) : Colors.grey,
              onPressed: () {
                setState(() {
                  currentTab = 2;
                  _pageController.animateToPage(
                    2,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: currentTab == 3 ? Color(0xffffffff) : Colors.grey,
              onPressed: () {
                setState(() {
                  currentTab = 3;
                  _pageController.animateToPage(
                    3,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff1cf396),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(
          Icons.add,
          color: Color(0xff333333),
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Sell(userId: widget.userId),
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
