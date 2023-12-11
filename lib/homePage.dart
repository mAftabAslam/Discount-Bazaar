import 'package:flutter/material.dart';
import 'package:se_project/pages/MainPages/account.dart';
import 'package:se_project/pages/MainPages/chats.dart';
import 'package:se_project/pages/MainPages/home.dart';
import 'package:se_project/pages/MainPages/saved.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = const [
    HomeScreen(),
    Chats(),
    Saved(),
    Account(),
  ];

  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageStorage(
            child: currentScreen,
            bucket: PageStorageBucket(),
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 5,
            child: Container(
              height: 70, // Adjust the height of the BottomAppBar
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Color(0xff1E1E1E),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MaterialButton(
                    splashColor: Color(0xff1E1E1E),
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_filled,
                          color:
                              currentTab == 0 ? Color(0xffffffff) : Colors.grey,
                          size: 25,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 8,
                            color: currentTab == 0
                                ? Color(0xffffffff)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.only(right: 20),
                    splashColor: Color(0xff1E1E1E),
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Chats();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_rounded,
                          color:
                              currentTab == 1 ? Color(0xffffffff) : Colors.grey,
                          size: 25,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Chats',
                          style: TextStyle(
                            fontSize: 8,
                            color: currentTab == 1
                                ? Color(0xffffffff)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.only(left: 30),
                    splashColor: Color(0xff1E1E1E),
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Saved();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark,
                          color:
                              currentTab == 2 ? Color(0xffffffff) : Colors.grey,
                          size: 25,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Saved',
                          style: TextStyle(
                            fontSize: 8,
                            color: currentTab == 2
                                ? Color(0xffffffff)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    splashColor: Color(0xff1E1E1E),
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Account();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color:
                              currentTab == 3 ? Color(0xffffffff) : Colors.grey,
                          size: 25,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Account',
                          style: TextStyle(
                            fontSize: 8,
                            color: currentTab == 3
                                ? Color(0xffffffff)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Add similar MaterialButtons for other tabs
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 170,
            child: FloatingActionButton(
              backgroundColor: Color(0xff1cf396),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.black, width: 2.0), // Outline color and width
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Icon(
                Icons.add,
                color: Color(0xff333333),
                size: 40,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
