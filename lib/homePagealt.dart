import 'package:flutter/material.dart';
import 'package:se_project/pages/MainPages/account.dart';
import 'package:se_project/pages/MainPages/chats.dart';
import 'package:se_project/pages/MainPages/home.dart';
import 'package:se_project/pages/MainPages/saved.dart';

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  int currentTab = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final List<Widget> screens = const [
    HomeScreen(),
    Chats(),
    Saved(),
    Account(),
  ];

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
        backgroundColor: Color(0xff1cf396),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          Icons.add,
          color: Color(0xff333333),
          size: 40,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
