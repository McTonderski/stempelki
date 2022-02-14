import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/Screens/home/qrpage.dart';
import 'package:shopapp/Screens/home/settings.dart';
import 'package:shopapp/Screens/home/stemple.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController(viewportFraction: 1, keepPage: true);
  int _currentPage = 0;
  void onTabBottomBar(int index){
    setState(() {
      _currentPage = index;
      pageController.jumpToPage(_currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Home screen");
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          centerTitle: true,
          title: const Text("Stempelki"),
        ),
        body: PageView(
          onPageChanged: (index){
            setState(() {
              _currentPage = index;
            });
          },
          controller: pageController,
          children: [Stemple(), DisplayUserQR(), UserSettings()]
          ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabBottomBar,
          currentIndex: _currentPage,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home)
              ),
            BottomNavigationBarItem(
              label: "QR",
              icon: Icon(Icons.qr_code)
              ),
            BottomNavigationBarItem(
              label: "User",
              icon: Icon(Icons.person),
            )
        ]),
      ),
      onWillPop: () async => false,
    );
  }
}
