import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:from_scratch/constants.dart';
import 'package:from_scratch/screens/explore_screen.dart';
import 'package:from_scratch/screens/profile_screen.dart';
import 'package:from_scratch/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  static const List<Widget> _bodyOptions = <Widget>[
    SearchScreen(),
    ExploreScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        _navIndex = index;
      });
    }

    return Scaffold(
      body: _bodyOptions.elementAt(_navIndex),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomNavigationBar(
          elevation: 10,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.green,
          currentIndex: _navIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/icons/Nav1.svg",
                  color: _navIndex != 0 ? kStroke : kGreen,
                ),
                label: "Search"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/icons/Nav2.svg",
                  color: _navIndex != 1 ? kStroke : kGreen,
                ),
                label: "Explore"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/icons/Nav3.svg",
                  color: _navIndex != 2 ? kStroke : kGreen,
                ),
                label: "Profile"),
          ],
        ),
      ),
    );
  }
}
